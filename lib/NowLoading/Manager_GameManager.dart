import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:sosaku/Common/Save/Data_common_SaveManager.dart';
import 'package:sosaku/Conversation/Controller_conversation_ConversationScreenController.dart';
import 'package:sosaku/SelectAction/UI_selectAction_SelectActionScreen.dart';
import 'package:sosaku/Title/UI_title_TitleScreen.dart';
import 'package:sosaku/Wrapper/Functions_wrapper_convertCSV.dart';

import '../Common/Enum_common.ScreenType.dart';
import '../Common/Interface_common_GameScreenInterface.dart';
import '../Common/Save/Data_common_SaveSlot.dart';
import '../Conversation/UI_conversation_ConversationScreen.dart';
import '../main.dart';

class ScreenInfo {
  final ScreenType screenType;
  // For Conversation Screen
  final int? lastChapter;
  final int? lastSection;
  // For Select Action Screen
  final int? buttonNo;

  factory ScreenInfo.fromSelectAction(int selectedButtonNo) =>
      ScreenInfo._privateConstructor(ScreenType.selectActionScreen,
          buttonNo: selectedButtonNo);

  factory ScreenInfo.fromConversation(
          {required int lastChapter, required int lastSection}) =>
      ScreenInfo._privateConstructor(ScreenType.conversationScreen,
          lastChapter: lastChapter, lastSection: lastSection);

  ScreenInfo._privateConstructor(this.screenType,
      {this.lastChapter, this.lastSection, this.buttonNo});

  @override
  String toString() {
    return "ScreenInfo(screenType:$screenType, lastChapter:$lastChapter, lastSection:$lastSection, buttonNo:$buttonNo)";
  }
}

/// **Determine which screen will be show.**
/// This class provides single-ton instance.
///
/// ### Related class
/// [ScreenInfo]
///
/// ### Global Fields
/// None.
///
/// ### Global Methods
/// [processing], [notify]
class GameManager {
  // note: どうやって次の画面を決めるか
  // たった今なんの画面だったか知る必要がある
  //  -> notify関数を作る? or セーブデータから知る
  // 次にどうするべきか判断する
  //  -> 行動選択後にイベントが発生するのか、とか
  // 下に示す準備をして呼び出す
  //
  // note: Conversationを呼び出すとき
  // todo: どのイベントを呼び出すか決める
  //  -> 今何週目か、今まで見たことあるイベントは除外、残りでランダム
  // Jsonから項目を抽出する
  // ConversationControllerに各アセットをロードする
  // アセットをプリロードする (過去は振り返らない)
  // todo: どこから始めるか決める
  // nowCode, log, eventCodeを保存
  //  -> 引数として渡す?
  // Conversationを呼び出す
  //
  // note: SelectActionを呼び出すとき
  // todo: 今何週目か、川本電話可能かなどを取得する
  // todo: アセットをプリロードする(アセットは固定?)
  // todo: 引数と一緒にSelectActionを呼び出す
  //
  //  -> SelectActionで呼び出すべきでは?
  // (選択要素解禁はどうする？
  //  -> 追加情報がないかGameManagerに問い合わせる形をとるか、直に書いてもらうか)
  //
  // note: ロード中にアプリを落とされたら? 2で行く!
  // 1. ロールバックする -> もう一度同じ画面を見せるのは良くない
  // 2. onPausedで次の画面決定まで頑張る -> 次回のNow Loadingで高速化できる
  //    -> ロード画面ではどう表示する? -> 次の画面・No image でもあり?
  //
  // flutter + hooks で初期化(init())を使用する
  // static prepare() ==> prepare() に変更
  // Widgetクラスのコンストラクタは変更禁止にした
  // GameScreenInterfaceを作成する (prepare())

  static final GameManager _singletonInstance =
      GameManager._internalConstructor();

  ScreenInfo? _lastScreenInfo = ScreenInfo.fromSelectAction(-1); // todo: 書き換える

  /// get single-ton
  factory GameManager() => _singletonInstance;

  /// Start all process.
  ///
  /// App's screen will jump to new page determined by this class automatically
  /// some milliseconds after this function is executed.
  Future<GameScreenInterface> processing(BuildContext context) async {
    GameScreenInterface nextScreen = _determineNextScreen();
    await _prepareForNextScreen(context, nextScreen);
    /* _lastScreenInfo = null; */ // todo: 戻す
    return nextScreen;
  }

  /// Notify current status to GameManager
  ///
  /// **This method is called by only ConversationScreenController or SelectActionScreenController.**
  ///
  /// @param [screenInfo] : Specify ScreenInfo instance created by
  ///    factory constructor for the sake of each screen.
  void notify(ScreenInfo screenInfo) {
    _lastScreenInfo = screenInfo;
    logger.fine("Notify from ${_lastScreenInfo!.screenType}.");
  }

  GameScreenInterface _determineNextScreen() {
    GameScreenInterface nextScreen;
    print("GameManager._determineNextScreen() >> Start.");
    // When NowLoadingScreen is called for the first time after the app is launched.
    logger.fine("_lastScreenInfo = $_lastScreenInfo");
    if (_lastScreenInfo == null) {
      print("GameManager._determineNextScreen() >> null -> ConversationScreen");
      nextScreen = const ConversationScreen();
    } else {
      switch (_lastScreenInfo!.screenType) {
        case ScreenType.selectActionScreen:
          print(
              "GameManager._determineNextScreen() >> lastScreen = SelectAction");
          nextScreen = const ConversationScreen();
          break;
        case ScreenType.conversationScreen:
          print(
              "GameManager._determineNextScreen() >> lastScreen = ConversationAction");
          nextScreen = const SelectActionScreen();
          break;
        default:
          print(
              "GameManager._determineNextScreen() >> case default -> TitleScreen");
          nextScreen = const TitleScreen();
          throw Error();
      }
    }
    logger.info("The nextScreen type is $nextScreen");
    return nextScreen;
  }

  Future<void> _prepareForNextScreen(
      BuildContext context, GameScreenInterface nextScreen) async {
    // note: 次のScreenの内容決め
    //  ConversationScreen:
    //    1. セーブデータから次のイベント候補取得
    //    2. 候補からランダムに決める
    //    3. 決めた結果をセーブに書き込み(更新)
    //  SelectActionScreen:
    //    川本に電話可能か調べる
    // note: 次に使うアセットのロード
    //  ConversationScreen: CSVからロード
    //  SelectActionScreen: prepare関数実行
    //  他のScreen: prepare関数実行
    //  不正なScreen: SplashScreenのassetsロード
    // note:

    // Determine the contents of next screen.
    print("GameManager._prepareForNextScreen >> Start.");
    switch (nextScreen.runtimeType) {
      case ConversationScreen:
        print("GameManager._prepareForNextScreen >> case : ConversationScreen");
        int eventCode = _getEventCode();
        print("GameManager._prepareForNextScreen >> eventCode = $eventCode");
        String scenarioPath = "assets/text/event$eventCode.csv";
        print(
            "GameManager._prepareForNextScreen >> scenarioPath = $scenarioPath");
        // conversationScreenController.prepare(context, scenarioPath);
        break;
      case SelectActionScreen:
        print("GameManager._prepareForNextScreen >> case : SelectActionScreen");
      // selectActionScreenController.prepare(context, isKawamoto());
      // todo: 川本に電話可能？
    }
    nextScreen.prepare(context);
  }

  // Map<String, List<String>> _collectNeedAssets(String csv) {
  //   const String delimiter = ',';
  //   List<String> lines = csv.split('\n');
  //   Set<String> bgImagePaths = {}; // todo: 収集
  //   Set<String> characterImagePaths = {}; // todo:
  //   Set<String> uiImagePaths = {}; // todo:
  //   Set<String> uiAudioPaths = {}; // todo: note: ベタ書き？
  //   Set<String> bgmPaths = {};
  //   Set<String> asPaths = {};
  //   Set<String> cvPaths = {};
  //
  //   for (String line in lines) {
  //     List<String> elements = line.split(delimiter);
  //     // elements = [comment,	code,	op,	func,	arg1,	arg2,	arg3]
  //     // bgmPaths収集
  //     if (elements[])
  //     }
  //   }}

  Future<List<Map<String, dynamic>>> _loadScenario(String filePath) async {
    String csv = await rootBundle.loadString(filePath);
    var scenarioData = convertCSV(csv);
    return scenarioData;
  }

  /// get next conversation event code.
  int _getEventCode() {
    return 1; // todo: 常に1
  }

  /// private named constructor
  /// DO NOT MAKE INSTANCE FROM OTHER CLASS DIRECTLY.
  GameManager._internalConstructor();
}

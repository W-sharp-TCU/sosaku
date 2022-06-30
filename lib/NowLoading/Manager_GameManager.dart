import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sosaku/Wrapper/wrapper_SoundPlayer.dart';

import '../Conversation/UI_conversation_ConversationScreen.dart';

/// Determine which screen will be show.
///
/// This class is single-ton.
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
  // アセットをプリロードする
  // todo: どこから始めるか決める
  //  -> セーブデータから決める、引数として渡す? (要検討)
  // Conversationを呼び出す
  // todo: 選択肢がある時はそれより前でも可? (要検討)
  //
  // note: SelectActionを呼び出すとき
  // todo: 今何週目か、川本電話可能かなどを取得する
  // todo: アセットをプリロードする(アセットは固定?)
  // todo: 引数と一緒にSelectActionを呼び出す
  //
  // note: todo: ActionResultを呼び出すとき (要検討)
  //  -> SelectActionで呼び出すべきでは?
  // 選択要素解禁はどうする？
  //  -> 追加情報がないかGameManagerに問い合わせる形をとるか、直に書いてもらうか
  //
  // note: ロード中にアプリを落とされたら?
  // 1. ロールバックする -> もう一度同じ画面を見せるのは良くない
  // 2. onPausedで次の画面決定まで頑張る -> 次回のNow Loadingで高速化できる
  //    -> ロード画面ではどう表示する? -> 次の画面・No image でもあり?
  // 3. 「前の画面が終わって次NowLoadingを表示する」ということをセーブしておく
  //    -> GameManagerの処理は変わらない, ロード画面では前の画面を表示しておけばよい
  /// class status type
  int finished = 0;
  int started = 1;

  static final GameManager _singletonInstance = GameManager._internal();

  Type? _currentScreenType;
  int? _status;
  BuildContext? _context;
  List<String> _nextBgImages = [];
  List<String> _nextCharacterImages = [];
  List<String> _nextUIAudio = [];
  List<String> _nextBGM = [];
  List<String> _nextSE = [];
  List<String> _nextCV = [];

  /// get single-ton
  factory GameManager() {
    return _singletonInstance;
  }

  /// Start all process.
  ///
  /// App's screen will transition to new page determined by this class automatically
  /// some milliseconds after this function is executed.
  void processing(BuildContext context) {
    _clear();
    _context = context;
    _determineScreen();
  }

  /// notify current status to GameManager
  ///
  /// @param classType : Specify "this.runtimeType"
  /// @param status : Specify constant provided by GameManager.
  /// @param message : Don't have to specify this normally. <b>Read notes below.</b>
  ///
  /// Notes
  /// -----
  /// if ConversationScreen: <br>
  void notify(Type classType, int status, int? message) {
    _currentScreenType = classType;
    _status = status;
  }

  /// determine next screen
  ///
  /// @return 0:Conversation, 1:SelectAction, 2:ActionResult
  int _determineScreen() {
    // [temporary code] always go conversation screen
    if (_currentScreenType is ConversationScreen) {
      return 0;
    } else if (Type is SelectAction) {
      return 1;
    } else {
      throw "Unexpected class notification @GameManager";
    }
  }

  void _clear() {
    _nextBgImages.clear();
    _nextCharacterImages.clear();
    _nextUIAudio.clear();
    _nextBGM.clear();
    _nextSE.clear();
    _nextCV.clear();
    _context = null;
  }

  void _goNextScreen(BuildContext context) {}

  Future<Map<String, dynamic>> _loadJson(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);

    // replace <Player> to player's name // todo: 下を書き換える
    jsonString = jsonString.replaceAll('<Player>', "playerName");
    Map<String, dynamic> jsonData = json.decode(jsonString);
    return jsonData;
  }

  Future<void> _prepareForNextScreen(
      BuildContext context,
      List<String> bgImagePaths,
      List<String> characterImagePaths,
      List<String> bgmPaths,
      List<String> cvPaths,
      List<String> sePaths) async {
    // pre-cache sound sources
    if (bgmPaths.isNotEmpty) {
      bgmPaths = bgmPaths.toSet().toList();
      SoundPlayer.loadAll(filePaths: bgmPaths, audioType: SoundPlayer.BGM);
    }
    if (cvPaths.isNotEmpty) {
      cvPaths = cvPaths.toSet().toList();
      SoundPlayer.loadAll(filePaths: cvPaths, audioType: SoundPlayer.CV);
    }
    if (sePaths.isNotEmpty) {
      sePaths = sePaths.toSet().toList();
      SoundPlayer.loadAll(filePaths: sePaths, audioType: SoundPlayer.SE);
    }
    // pre-cache image sources
    bgImagePaths = bgImagePaths.toSet().toList();
    characterImagePaths = characterImagePaths.toSet().toList();
    for (var e in bgImagePaths) {
      await precacheImage(AssetImage(e), context);
    }
    for (var e in characterImagePaths) {
      await precacheImage(AssetImage(e), context);
    }
  }

  void _getEventCode() {
    // note: SaveDataクラスから既出のイベントを取得する
    // note: この関数内で条件文をべた書き?
  }

  /// private named constructor
  /// DO NOT MAKE INSTANCE FROM OTHER CLASS DIRECTLY.
  GameManager._internal();
}

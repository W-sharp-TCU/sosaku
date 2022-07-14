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
  /// class status type
  static const int finished = 0;
  static const int started = 1;

  static final GameManager _singletonInstance =
      GameManager._internalConstructor();

  Type? _lastScreenType;
  int? _lastScreenStatus;
  Map<String, int>? _lastScreenDetails;

  /// get single-ton
  factory GameManager() => _singletonInstance;

  /// Start all process.
  ///
  /// App's screen will transition to new page determined by this class automatically
  /// some milliseconds after this function is executed.
  Future<Widget> processing(BuildContext context) async {
    _clear();
    Type nextScreen = _determineNextScreen();
    await _prepareForNextScreen(context, nextScreen);
    return _getNextScreenObject(context, nextScreen);
  }

  /// notify current status to GameManager
  ///
  /// @param from : Specify "this.runtimeType"
  /// @param status : Specify constant provided by GameManager.
  /// @param details : Don't have to specify this normally. <b>Read notes below.</b>
  ///
  /// Notes
  /// -----
  /// if ConversationScreen: <br>
  void notify(Type from, int status, Map<String, int>? details) {
    _lastScreenType = from;
    _lastScreenStatus = status;
    _lastScreenDetails = details;
    print("|||||\nGameManager.notify(): _lastScreenType: $_lastScreenType, "
        "_lastScreenStatus: $_lastScreenStatus, _lastScreenDetails:\n\t$_lastScreenDetails \n|||||");
  }

  /// determine next screen
  ///
  /// @return 0:Conversation, 1:SelectAction
  Type _determineNextScreen() {
    Type nextScreen = ConversationScreen;
    // [temporary code] always go conversation screen
    // if (_lastScreenType is ConversationScreenController) {
    //   return 0;
    // } else if (_lastScreenType is SelectAction) {
    //   return 1;
    // } else {
    //   throw "Unexpected class notification @GameManager";
    // }
    print("GameManager._determineNextScreen(): nextScreen Type is $nextScreen");
    return nextScreen;
  }

  void _clear() {
    _lastScreenType = null;
    _lastScreenStatus = null;
    _lastScreenDetails = null;
  }

  Widget _getNextScreenObject(BuildContext context, Type screenType) {
    return const ConversationScreen();
  }

  Future<Map<String, dynamic>> _loadJson(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);

    // replace <Player> to player's name // todo: 下を書き換える
    Map<String, dynamic> jsonData = json.decode(jsonString);
    return jsonData;
  }

  Future<void> _prepareForNextScreen(
      BuildContext context, Type nextScreenType) async {
    List<String> bgImagePaths = List.empty(growable: true);
    List<String> characterImagePaths = List.empty(growable: true);
    List<String> bgmPaths = List.empty(growable: true);
    List<String> cvPaths = List.empty(growable: true);
    List<String> sePaths = List.empty(growable: true);
    if (nextScreenType is ConversationScreen) {
      // load json files of scenario data.
      Map jsonMap =
          await _loadJson("assets/text/ScenarioData/ChapterTest/event1.json");
      print("GameManager._prepareForNextScreen(): event1.json loaded.");
      List<int> types = List.empty(growable: true);
      List<String> cNames = List.empty(growable: true);
      List<String> texts = List.empty(growable: true);
      List<List<int>> gotos = List.empty(growable: true);
      List<List<String>> options = List.empty(growable: true);
      // List<List<int>> statusTypes = List.empty(growable: true);
      // List<List<int>> statusValues = List.empty(growable: true);
      for (Map e in jsonMap['context']) {
        if (e.containsKey('type')) {
          types.add(e['type'].cast<int>());
        }
        if (e.containsKey('name')) {
          cNames.add(e['name'].cast<String>());
        } else {
          cNames.add("");
        }
        if (e.containsKey('text')) {
          texts.add(e['text'].cast<String>());
        } else {
          texts.add("");
        }
        if (e.containsKey('BGImage')) {
          bgImagePaths.add(e['BGImage'].cast<String>());
        }
        if (e.containsKey('CharacterImage')) {
          characterImagePaths.add(e['CharacterImage'].cast<String>());
        }
        if (e.containsKey('BGM')) {
          bgmPaths.add(e['BGM'].cast<String>());
        }
        if (e.containsKey('SE')) {
          sePaths.add(e['SE'].cast<String>());
        }
        if (e.containsKey('Voice')) {
          cvPaths.add(e['Voice'].cast<String>());
        }
        if (e.containsKey('goto')) {
          gotos.add(e['goto'].cast<List<int>>());
        }
        if (e.containsKey('option')) {
          options.add(e['option'].cast<List<String>>());
        }
        /*if (e.containsKey('status')) {
          statusTypes.add(e['status'].cast<List<int>>());
        }
        if (e.containsKey('statusvalue')) {
          statusValues.add(e['statusvalue'].cast<List<int>>());
        }*/
      }
      conversationScreenController.setTypes(types);
      conversationScreenController.setBackgroundImagePaths(bgImagePaths);
      conversationScreenController.setCharacterImagePaths(characterImagePaths);
      conversationScreenController.setCharacterNames(cNames);
      conversationScreenController.setTexts(texts);
      conversationScreenController.setBgmPaths(bgmPaths);
      conversationScreenController.setVoicePaths(cvPaths);
      conversationScreenController.setSePaths(sePaths);
      conversationScreenController.setOptions(options);
      conversationScreenController.setGotoNumbers(gotos);
      print(
          "GameManager._prepareForNextScreen(): Set data to conversationScreenController.");
    } /*else if (nextScreenType is SelectActionScreen) {
      // todo: SelectActionScreenで使うassetsを列挙する
      // bgImagePaths = [];
      // cvPaths = [];
      // sePaths = [];
      // bgImagePaths = [];
      // characterImagePaths = [];
    }*/

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
    print("GameManager._prepareForNextScreen(): Finished pre-caching assets.");
  }

  /*void _getEventCode() {
    // note: SaveDataクラスから既出のイベントを取得する
    // note: この関数内で条件文をべた書き?
  }*/

  /// private named constructor
  /// DO NOT MAKE INSTANCE FROM OTHER CLASS DIRECTLY.
  GameManager._internalConstructor();
}

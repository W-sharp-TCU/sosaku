import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:jsonlogic/jsonlogic.dart';
import 'package:sosaku/Common/Save/Data_common_SaveManager.dart';
import 'package:sosaku/SelectAction/UI_selectAction_SelectActionScreen.dart';
import 'package:sosaku/Title/UI_title_TitleScreen.dart';

import '../Common/Enum_common_ScreenType.dart';
import '../Common/Interface_common_GameScreenInterface.dart';
import '../Conversation/UI_conversation_ConversationScreen.dart';
import '../main.dart';

class ScreenInfo {
  final ScreenType screenType;
  // For Conversation Screen
  final int? lastEvent;
  final int? lastInstructionNo;
  // For Select Action Screen
  final int? buttonNo;

  factory ScreenInfo.fromSelectAction(int selectedButtonNo) =>
      ScreenInfo._privateConstructor(ScreenType.selectActionScreen,
          buttonNo: selectedButtonNo);

  factory ScreenInfo.fromConversation(
          {required int eventCode, required int instructionNo}) =>
      ScreenInfo._privateConstructor(ScreenType.conversationScreen,
          lastEvent: eventCode, lastInstructionNo: instructionNo);

  ScreenInfo._privateConstructor(this.screenType,
      {this.lastEvent, this.lastInstructionNo, this.buttonNo});

  @override
  String toString() {
    return "ScreenInfo(screenType:$screenType, lastEvent:$lastEvent, lastInstructionNo:$lastInstructionNo, buttonNo:$buttonNo)";
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
  static const String _eventMapJsonPath =
      "assets/text/ScenarioData/eventMap.json";
  Map<String, dynamic>? _eventMap;
  final Jsonlogic _jlParser = Jsonlogic();
  final Random _random =
      Random((DateTime.now().millisecondsSinceEpoch).floor());

  /// private named constructor
  /// DO NOT MAKE INSTANCE FROM OTHER CLASS DIRECTLY.
  GameManager._internalConstructor();

  static final GameManager _singletonInstance =
      GameManager._internalConstructor();

  ScreenInfo? _lastScreenInfo = ScreenInfo.fromSelectAction(-1); // todo: 書き換える

  /// Get single-ton
  factory GameManager() => _singletonInstance;

  /// Start all process.
  ///
  /// A few milliseconds after this function is executed, the application screen
  /// automatically jumps to the new page specified in this class.
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
        int eventCode =
            await _getEventCode(SaveManager().playingSlot.lastEvent);
        print("GameManager._prepareForNextScreen >> eventCode = $eventCode");
        String scenarioPath = "assets/text/ScenarioData/event$eventCode.csv";
        print(
            "GameManager._prepareForNextScreen >> scenarioPath = $scenarioPath");
        conversationScreenController.prepare(context, scenarioPath);
        SaveManager().playingSlot.lastEvent = eventCode;
        break;
      case SelectActionScreen:
        print("GameManager._prepareForNextScreen >> case : SelectActionScreen");
      // selectActionScreenController.prepare(context, isKawamoto());
      // todo: 川本に電話可能？
    }
    nextScreen.prepare(context);
  }

  Future<Map<String, dynamic>> _getEventMap({force = false}) async {
    if ((_eventMap == null) || force) {
      String jsonString = await rootBundle.loadString(_eventMapJsonPath);
      _eventMap = jsonDecode(jsonString);
      logger.info(
          "EventMap version.${_eventMap!["version"]} loaded successfully.");
    }
    return _eventMap!["eventMap"];
  }

  /// get next conversation event code.
  Future<int> _getEventCode(int currentEventCode) async {
    var maps = await _getEventMap();
    print("maps: $maps");
    print("currentEventCode: $currentEventCode");
    print(maps.keys);
    var destinations = maps[currentEventCode.toString()];
    print(maps.containsKey(currentEventCode.toString()));
    print(destinations);
    List<int> candidateEvents = [];
    for (var event in destinations) {
      print("status: ${SaveManager().playingSlot.status}");
      print("status: ${SaveManager().playingSlot.status.runtimeType}");
      print("condition: ${event["condition"]}");
      if (event["condition"] == null ||
          _jlParser.apply(
              event["condition"], SaveManager().playingSlot.status)) {
        candidateEvents.add(event["goto"]);
      }
    }
    return candidateEvents[_random.nextInt(candidateEvents.length)];
  }
}

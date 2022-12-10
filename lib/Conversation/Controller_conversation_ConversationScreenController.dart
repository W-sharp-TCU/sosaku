import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sosaku/Conversation/Animation_conversation_ConversationAnimation.dart';
import 'package:sosaku/Conversation/Provider_conversationConversationCharacterProvider.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationImageProvider.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationLogProvider.dart';
import 'package:sosaku/Title/UI_title_TitleScreen.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';
import 'package:sosaku/Wrapper/wrapper_SoundPlayer.dart';
import '../Wrapper/wrapper_SakuraTransition.dart';
import '../main.dart';
import 'Provider_conversation_ConversationTextProvider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:csv/csv.dart';

class ConversationScreenController {
  int _interval = 40; // [ms]
  String _playerName = 'プレイヤー';
  ConversationImageProvider? _conversationImageProvider;
  ConversationTextProvider? _conversationTextProvider;
  ConversationLogProvider? _conversationLogProvider;
  ConversationCharacterProvider? _conversationCharacterProvider;
  BuildContext? _context;

  /// Code number of scenario data.
  int _nowCode = 0;

  final List<List<String>> _eventData = [];

  void _goNextScene() {
    String op = _eventData[_nowCode][0];
    String? func = _eventData[_nowCode][1];
    List<String> arg = _eventData[_nowCode].sublist(2);
    _nowCode++;
    switch (op) {
      case 'bg':
        _bg(func, arg);
        break;
      case 'character':
        _character(func, arg);
        break;
      case 'text':
        _text(func, arg);
        break;
      case 'selection':
        _selection(func, arg);
        break;
      case 'narration':
        _text(func, arg);
        break;
      case 'bgm':
        break;
      case 'voice':
        _voice(func, arg);
        break;
      case 'se':
        break;
      case '':
        _conversationCharacterProvider?.update();
        _addLog();
        break;
      case 'sleep':
        _sleep(func, arg);
        break;
      case 'goto':
        _goto(func, arg);
        break;
      case 'if':
        break;
      case 'end':
        endEvent();
        break;
      case '//':
        _goNextScene();
        break;
      default:
        throw ('scenario data ${_nowCode - 1} : operator "$op" is not defined');
    }

    // _nowCode++;
    // _goNextScene();
  }

  void goSelectedScene(int selectionNum) {
    _nowCode = _conversationImageProvider?.selections[selectionNum]['goto'];
    _conversationImageProvider?.setSelections([]);
    _conversationImageProvider?.setIsSelection(false);
    _goNextScene();
  }

  void _bg(String func, List<String> arg) {
    switch (func) {
      case 'set':
        String path = arg[0];
        // TODO : pathの読み込みをできるようにする
        path = 'assets/drawable/Conversation/002_classroomBB.png';
        _conversationImageProvider?.setBGImage(path);
        _goNextScene();
        break;
      case 'animation':
        break;
      default:
        throw ('scenario data ${_nowCode - 1} : function "$func" is not defined');
    }
  }

  void _character(String func, List<String> arg) {
    switch (func) {
      case 'in':
        String layerId = arg[0];
        String animationIn = arg[1];
        int sumPosNull = 1; // 座標が指定されていないキャラクターの数(1は追加キャラ分)
        for (LayerData layer in _conversationCharacterProvider!.layers.values) {
          if (layer.position == null) {
            sumPosNull++;
          }
        }
        // すでに配置されたキャラクターの新しい位置を設定
        int countPosNull = 1;
        for (LayerData layer in _conversationCharacterProvider!.layers.values) {
          if (layer.position == null) {
            double newPosition = countPosNull / (sumPosNull + 1);
            layer.animations.add(() {
              _conversationCharacterProvider?.animationNum++;
              // デフォルトキャラ移動animationの関数呼び出し
              // TODO : べた書き開始
              animationController
                  .animate('${layer.layerId}characterAnimation', 'positionX', [
                Easing(0, 1000, layer.positionX, newPosition).inOutQuint(),
              ]);
              animationController.setCallback(
                  '${layer.layerId}characterAnimation', 'positionX', () {
                layer.positionX = newPosition;
                // TODO : べた書き終了
                _conversationCharacterProvider?.animationNum--;
              });
            });
            countPosNull++;
          }
        }
        // 新しいキャラクターを登場させる
        print('create new character');
        _conversationCharacterProvider!.layers[layerId] =
            LayerData(layerId, countPosNull / (sumPosNull + 1));
        print(_conversationCharacterProvider!.layers);
        _conversationCharacterProvider!.layers[layerId]?.animations.add(() {
          _conversationCharacterProvider?.animationNum++;
          // キャラ登場アニメーションの呼び出し
          // TODO : べた書き開始
          animationController.animate('${layerId}characterAnimation', 'opacity',
              [Linear(0, 1000, 0, 1)]);
          animationController
              .setCallback('${layerId}characterAnimation', 'opacity', () {
            _conversationCharacterProvider?.animationNum--;
          });
          // TODO : べた書き終了
        });
        _goNextScene();
        break;
      case 'expression':
        String layerId = arg[0];
        String face = arg[1];
        _conversationCharacterProvider!.layers[layerId]!.face = face;
        _goNextScene();
        break;
      case 'mouth':
        String layerId = arg[0];
        String mouth = arg[1];
        _conversationCharacterProvider!.layers[layerId]!.mouth = mouth;
        _goNextScene();
        break;
      case 'eye':
        String layerId = arg[0];
        String eye = arg[1];
        _conversationCharacterProvider!.layers[layerId]!.eye = eye;
        _goNextScene();
        break;
      case 'position':
        // String layerId = arg[0];
        // String animationMove = arg[1];
        // double newPosition = double.parse(arg[2]);
        // int sumPosNull = 1; // 座標が指定されていないキャラクターの数(1は追加キャラ分)
        // for (LayerData layer in _conversationCharacterProvider!.layers.values) {
        //   if (layer.position == null) {
        //     sumPosNull++;
        //   }
        // }
        // // すでに配置されたキャラクターの新しい位置を設定
        // int countPosNull = 1;
        // for (LayerData layer in _conversationCharacterProvider!.layers.values) {
        //   if (layer.layerId == layerId) {
        //     layer.position = ;
        //     double newPosition = countPosNull / (sumPosNull + 1);
        //     layer.animations.add(() {
        //       _conversationCharacterProvider?.animationNum++;
        //       // デフォルトキャラ移動animationの関数呼び出し
        //       // TODO : べた書き開始
        //       animationController
        //           .animate('${layer.layerId}characterAnimation', 'positionX', [
        //         Easing(0, 1000, layer.positionX, newPosition).inOutQuint(),
        //       ]);
        //       animationController.setCallback(
        //           '${layer.layerId}characterAnimation', 'positionX', () {
        //         layer.positionX = newPosition;
        //         // TODO : べた書き終了
        //         _conversationCharacterProvider?.animationNum--;
        //       });
        //     });
        //     countPosNull++;
        //   } else if (layer.position == null) {
        //     double newPosition = countPosNull / (sumPosNull + 1);
        //     layer.animations.add(() {
        //       _conversationCharacterProvider?.animationNum++;
        //       // デフォルトキャラ移動animationの関数呼び出し
        //       // TODO : べた書き開始
        //       animationController
        //           .animate('${layer.layerId}characterAnimation', 'positionX', [
        //         Easing(0, 1000, layer.positionX, newPosition).inOutQuint(),
        //       ]);
        //       animationController.setCallback(
        //           '${layer.layerId}characterAnimation', 'positionX', () {
        //         layer.positionX = newPosition;
        //         // TODO : べた書き終了
        //         _conversationCharacterProvider?.animationNum--;
        //       });
        //     });
        //     countPosNull++;
        //   }
        // }
        _goNextScene();
        break;
      case 'animation':
        String layerId = arg[0];
        String animation = arg[1];
        _conversationCharacterProvider!.layers[layerId]!.animations.add(() {
          _conversationCharacterProvider?.animationNum++;
          animationController
              .animate('${layerId}characterAnimation', 'positionX', [
            Pause(0, 1000),
            Wave(
                1000,
                1500,
                _conversationCharacterProvider!.layers[layerId]!.positionX -
                    0.005,
                _conversationCharacterProvider!.layers[layerId]!.positionX +
                    0.005,
                100,
                1 / 2)
          ]);
          animationController
              .setCallback('${layerId}characterAnimation', 'positionX', () {
            _conversationCharacterProvider?.animationNum--;
          });
        });
        _goNextScene();
        break;
      case 'out':
        String layerId = arg[0];
        String animationIn = arg[1];
        int countPosNull = 1; // 座標が指定されていないキャラクターの数(1は追加キャラ分)
        for (LayerData layer in _conversationCharacterProvider!.layers.values) {
          if (layer.position == null) {
            countPosNull++;
          }
        }
        // すでに配置されたキャラクターの新しい位置を設定
        int i = 1;
        for (LayerData layer in _conversationCharacterProvider!.layers.values) {
          if (layer.position == null) {
            layer.animations.add(() {
              _conversationCharacterProvider?.animationNum++;
              animationController
                  .animate('${layer.layerId}characterAnimation', 'positionX', [
                Easing(0, 1000, layer.positionX, 1 / (countPosNull - 1))
                    .inOutQuint(),
              ]);
              animationController.setCallback(
                  '${layer.layerId}characterAnimation', 'positionX', () {
                layer.positionX = i / (countPosNull - 1);
                _conversationCharacterProvider?.animationNum--;
              });
            });
            i++;
          }
        }

        // キャラクターを消す
        print(_conversationCharacterProvider!.layers);
        _conversationCharacterProvider!.layers[layerId]?.animations.add(() {
          _conversationCharacterProvider?.animationNum++;
          animationController.animate('${layerId}characterAnimation', 'opacity',
              [Linear(0, 1000, 1, 0)]);
          animationController
              .setCallback('${layerId}characterAnimation', 'opacity', () {
            _conversationCharacterProvider!.layers.remove(layerId);
            _conversationCharacterProvider?.animationNum--;
          });
        });
        _goNextScene();
        break;
      default:
        throw ('scenario data ${_nowCode - 1} : function "$func" is not defined');
    }
  }

  void _text(String func, List<String> arg) async {
    String name = arg[0];
    String text = arg[1];
    _conversationImageProvider?.setCharacterName(name);
    _conversationImageProvider?.setCanNext(false);
    await animationController.animate('conversationTextAnimation', 'textLength',
        [Linear(0, text.length * _interval, 1, text.length.toDouble())]);
    animationController.setCallbacks('conversationTextAnimation', {
      'textLength': () async {
        _conversationImageProvider?.setCanNext(true);
        if (_conversationImageProvider!.selections.isNotEmpty) {
          _conversationImageProvider?.setIsSelection(true);
        }
        if (_conversationImageProvider!.isSelection) {
          await ConversationAnimation.selection(
              _conversationImageProvider!.selections.length);
        }
        _autoPlay();
      }
    });
    _conversationTextProvider?.setConversationText(text);
    _goNextScene();
  }

  void _selection(String func, List<String> arg) {
    String text = arg[1];
    int goto = int.parse(arg[2]);
    _conversationImageProvider?.addSelections({'text': text, 'goto': goto});
    animationController.setStates('selections', {
      'alignment' +
          (_conversationImageProvider!.selections.length - 1).toString(): 2,
      'opacity' +
          (_conversationImageProvider!.selections.length - 1).toString(): 0
    });
    _goNextScene();
  }

  void _bgm(String path) {
    SoundPlayer().playBGM(path);
    _goNextScene();
  }

  void _voice(String func, List<String> arg) {
    print('voice');
    String voicePath = arg[1];
    print(voicePath);
    SoundPlayer().playCV([voicePath]);
    _goNextScene();
  }

  void _se(String path) {
    SoundPlayer().playAS([path]);
    _goNextScene();
  }

  void _goto(String func, List<String> arg) {
    int goto = int.parse(arg[2]);
    _nowCode = goto;
    _goNextScene();
  }

  void _sleep(String func, List<String> arg) async {
    int duration = (double.parse(arg[0]) * 1000).ceil();
    _conversationImageProvider?.setIsSleep(true);
    await Future.delayed(Duration(milliseconds: duration));
    _conversationImageProvider?.setIsSleep(false);
    _goNextScene();
  }

  void _addLog() {
    _conversationLogProvider?.names
        .add(_conversationImageProvider!.characterName);
    _conversationLogProvider?.texts
        .add(_conversationTextProvider!.conversationText);
    _conversationLogProvider?.voicePaths
        .add(_conversationImageProvider!.voicePath);
    _conversationLogProvider?.isPlaying.add(false);
    switch (_conversationImageProvider?.characterName) {
      case ('籾原彩菜'):
      case ('彩菜'):
      case ('あやな'):
        _conversationLogProvider?.iconPaths
            .add('assets/drawable/Conversation/icon_ayana.png');
        break;
      case ('栃ノ瀬ののの'):
      case ('ののの'):
        _conversationLogProvider?.iconPaths
            .add('assets/drawable/Conversation/icon_nonono.png');
        break;
      case ('銀田榊'):
      case ('榊'):
      case ('さかき'):
        _conversationLogProvider?.iconPaths
            .add('assets/drawable/Conversation/icon_sakaki.png');
        break;
      default:
        _conversationLogProvider?.iconPaths
            .add('assets/drawable/Conversation/icon_unknown.png');
        break;
    }
  }

  void _autoPlay() {
    if (_conversationImageProvider!.isAuto &&
        SoundPlayer().cvState == PlayerState.completed &&
        SoundPlayer().asState == PlayerState.completed &&
        !animationController.isAnimation(
            'conversationTextAnimation', 'textLength')) {
      tapScreen();
    }
  }

  void setSettings({double? textSpeed, String? playerName}) {
    if (textSpeed != null) {
      int interval = 85 - textSpeed.toInt() * 15;
      _interval = interval;
    }
    _playerName = playerName ?? _playerName;
  }

  /// Start controller.
  /// This function is for ConversationScreenUI.
  ///
  /// @param cip : ConversationImageProvider
  /// @param ctp : ConversationTextProvider
  /// @param clp : ConversationLogProvider
  /// @param contest : BuildContext
  Future<void> start(
      ConversationImageProvider cip,
      ConversationTextProvider ctp,
      ConversationLogProvider clp,
      ConversationCharacterProvider ccp,
      BuildContext context) async {
    if (_conversationImageProvider == null ||
        _conversationTextProvider == null ||
        _conversationLogProvider == null ||
        _conversationCharacterProvider == null) {
      _conversationImageProvider = cip;
      _conversationTextProvider = ctp;
      _conversationLogProvider = clp;
      _conversationCharacterProvider = ccp;
      _context = context;

      // init
      _nowCode = 0;

      // TODO : べた書き
      SoundPlayer().precacheSounds(
          filePaths: ['assets/sound/CV/voice_sample_002.wav'],
          audioType: SoundPlayer.cv);
      SoundPlayer().precacheSounds(
          filePaths: ['assets/sound/CV/voice_sample_002.wav'],
          audioType: SoundPlayer.as);
      SoundPlayer().precacheSounds(
          filePaths: ['assets/sound/CV/voice_sample_002.wav'],
          audioType: SoundPlayer.ui);
      // load csv
      logger.fine('start load csv...');
      String scenarioCsv = await rootBundle.loadString(
          'assets/text/ScenarioData/ChapterTest/scenario_data_sample.csv');
      // Windowsローカル環境の改行コードは\r\nに対して
      // GitHubPagesの改行コードは\nだから
      // CsvToListConverterのeolを\nに指定しないと動かない
      List<List> scenarioList =
          const CsvToListConverter(eol: '\n').convert(scenarioCsv);
      logger.finer(scenarioList.toList());
      scenarioList.removeAt(0);
      for (List scenario in scenarioList) {
        scenario.removeRange(0, 2);
        _eventData.add(scenario.map((e) => e.toString()).toList());
      }
      logger.fine('finish load csv');
      logger.finer(_eventData.toString());
      // await SakuraTransitionProvider.beginTransition();
      // SakuraTransitionProvider.endTransition();
      // TODO : ディレイ取り除く
      await Future.delayed(const Duration(milliseconds: 100));
      _goNextScene();
      ConversationAnimation.characterDefault();
    }
  }

  /// Stop controller.
  /// This function is for ConversationScreenUI.
  void stop() async {
    _conversationImageProvider = null;
    _conversationTextProvider = null;
    _conversationLogProvider = null;
    _conversationCharacterProvider = null;
  }

  ///
  ///
  void tapScreen() {
    if (!_conversationImageProvider!.isHideUi &&
        !_conversationImageProvider!.isLog &&
        !_conversationImageProvider!.isMenu &&
        !_conversationImageProvider!.isSelection &&
        !_conversationImageProvider!.isSleep) {
      if (animationController.isAnimation(
          'conversationTextAnimation', 'textLength')) {
        // animationController.stopAnimation(
        //     'conversationTextAnimation', 'textLength');
        animationController
            .animate('conversationTextAnimation', 'textLength', [Pause(0, 0)]);
        animationController.setStates('conversationTextAnimation', {
          'textLength':
              _conversationTextProvider!.conversationText.length.toDouble()
        });
      } else {
        if (!_conversationCharacterProvider!.isAnimation) {
          SoundPlayer().stopCVAll();
          SoundPlayer().stopASAll();
          _conversationImageProvider!.setVoicePath(null);
          _goNextScene();
        }
      }
    } else {
      _conversationImageProvider?.setIsHideUi(false);
      _conversationImageProvider?.setIsLog(false); // TODO : openLog作成したら書き換え
      _conversationImageProvider?.setIsMenu(false);
    }
  }

  /// Change auto play.
  /// This function is for ConversationScreenUI.
  void changeAutoPlay() {
    _conversationImageProvider?.setIsAuto(!_conversationImageProvider!.isAuto);
    _autoPlay();
  }

  /// Change hide ui.
  /// This function is for ConversationScreenUi.
  void changeHideUi() {
    _conversationImageProvider
        ?.setIsHideUi(!_conversationImageProvider!.isHideUi);
  }

  /// Open the menu screen.(If already open, close it.)
  /// This function is for ConversationScreenUi
  void openMenu() {
    _conversationImageProvider?.setIsMenu(!_conversationImageProvider!.isMenu);
    _conversationImageProvider?.setIsAuto(false);
    changeHideUi();
  }

  void openLog() {
    SoundPlayer().stopCVAll();
    _conversationImageProvider?.setIsLog(!_conversationImageProvider!.isLog);
    _conversationImageProvider?.setIsAuto(false);
    changeHideUi();
  }

  /// Processing at the end of an event.
  void endEvent() async {
    if (_conversationImageProvider != null &&
        _conversationTextProvider != null &&
        _conversationLogProvider != null &&
        _conversationCharacterProvider != null &&
        _context != null) {
      await Navigator.pushReplacement(
        _context!,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const TitleScreen(),
        ),
      );
      stop();
    }
  }

  void save() {
    // map<>
    // map[log] = logProvider.save()
    // map[] =
    //
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:sosaku/Conversation/Animation_conversation_ConversationAnimation.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationImageProvider.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationLogProvider.dart';
import 'package:sosaku/Settings/Provider_Settings_SettingsProvider.dart';
import 'package:sosaku/Title/UI_title_TitleScreen.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';
import 'package:sosaku/Wrapper/wrapper_SoundPlayer.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Provider_conversation_ConversationTextProvider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;

class ConversationScreenController {
  int _interval = 40; // [ms]
  String _playerName = 'プレイヤー';
  ConversationImageProvider? _conversationImageProvider;
  ConversationTextProvider? _conversationTextProvider;
  ConversationLogProvider? _conversationLogProvider;
  BuildContext? _context;
  Timer? _timer;

  /// Code number to display.
  int _nowCode = 0;

  /// Length of teIs auto play?xt being displayed.
  int _nowLength = 0;

  /// Text being displayed.
  String _nowText = '';

  /// List of conversation logs.
  List<int> _conversationLogs = [];

  /// bgImage
  /// characterImage
  /// characterName
  /// text
  /// selection
  /// bgm
  /// voice
  /// se
  /// goto
  ///
  /// characterPosition
  /// characterAnimation
  /// characterImage key path pos(1)
  ///
  /// characterImage key path pos(-1)
  ///
  final List<List> _conversationData = [
    ['bgImage', 'assets/drawable/Conversation/002_classroomBB.png'],
    [
      'characterImage',
      'assets/drawable/CharacterImage/Ayana/angry(eyeClosed).png'
    ],
    ['characterName', 'あやな'],
    ['text', '早くしないと学食混んじゃうじゃない！'],
    [''],
    ['text', 'それじゃあ、このパソコンの角で起こしてほしかったかしら？'],
    [
      'characterImage',
      'assets/drawable/CharacterImage/Ayana/angry(eyeOpend).png'
    ],
    [''],
    ['text', '次の授業なんだっけ？'],
    ['selection', '国語', '14'],
    ['selection', '数学', '17'],
    ['selection', '英語', '20'],
    [''],
    ['text', '次の授業は国語だよ'],
    [''],
    ['goto', '23'],
    ['text', '次の授業は数学だよ'],
    [''],
    ['goto', '23'],
    ['text', '次の授業は英語だよ'],
    [''],
    ['goto', '23'],
    [
      'text',
      '吾輩わがはいは猫である。名前はまだ無い。どこで生れたかとんと見当けんとうがつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。'
    ],
    [''],
    [
      'text',
      '吾輩わがはいは猫である。名前はまだ無い。どこで生れたかとんと見当けんとうがつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。'
    ],
    [''],
    [
      'text',
      '吾輩わがはいは猫である。名前はまだ無い。どこで生れたかとんと見当けんとうがつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。'
    ],
    [''],
    [
      'text',
      '吾輩わがはいは猫である。名前はまだ無い。どこで生れたかとんと見当けんとうがつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。'
    ],
    [''],
    ['end']
  ];

  void _goNextScene() {
    String func = _conversationData[_nowCode][0];
    if (func == 'end') {
      endEvent();
    } else if (func == '') {
      _addLog();
      _nowCode++;
    } else if (func == 'goto') {
      _goto(int.parse(_conversationData[_nowCode][1]) - 1);
      _goNextScene();
    } else {
      if (func == 'bgImage') {
        _bgImage(_conversationData[_nowCode][1]);
      } else if (func == 'characterImage') {
        _characterImage(_conversationData[_nowCode][1]);
      } else if (func == 'bgm') {
        _bgm(_conversationData[_nowCode][1]);
      } else if (func == 'voice') {
        _voice(_conversationData[_nowCode][1]);
      } else if (func == 'se') {
        _se(_conversationData[_nowCode][1]);
      } else if (func == 'characterName') {
        _characterName(_conversationData[_nowCode][1]);
      } else if (func == 'text') {
        _text(_conversationData[_nowCode][1]);
      } else if (func == 'selection') {
        _selection(_conversationData[_nowCode][1],
            int.parse(_conversationData[_nowCode][2]));
      }
      _nowCode++;
      _goNextScene();
    }
  }

  void goSelectedScene(int selectionNum) {
    _nowCode = _conversationImageProvider?.selections[selectionNum]['goto'] - 1;
    _conversationImageProvider?.setSelections([]);
    _conversationImageProvider?.setIsSelection(false);
    _goNextScene();
  }

  void _bgImage(String path) {
    _conversationImageProvider?.setBGImage(path);
  }

  void _characterImage(String path) {
    _conversationImageProvider?.setCharacterImage(path);
  }

  void _bgm(String path) {
    SoundPlayer().playBGM(path);
  }

  void _voice(String path) {
    SoundPlayer().playCV([path]);
  }

  void _se(String path) {
    SoundPlayer().playAS([path]);
  }

  void _characterName(String name) {
    _conversationImageProvider?.setCharacterName(name);
  }

  void _text(String text) async {
    _conversationImageProvider?.setCanNext(false);
    await animationController.animate('conversationTextAnimation', 'textLength',
        [Linear(0, text.length * _interval, 1, text.length.toDouble())]);
    animationController.setCallback('conversationTextAnimation', {
      'textLength': () async {
        _conversationImageProvider?.setCanNext(true);
        if (_conversationImageProvider!.isSelection) {
          await ConversationAnimation.selection(
              _conversationImageProvider!.selections.length);
        }
        _autoPlay();
      }
    });
    _conversationTextProvider?.setConversationText(text);
  }

  void _selection(String text, int goto) {
    _conversationImageProvider?.addSelections({'text': text, 'goto': goto});
    animationController.setStates('selections', {
      'alignment' +
          (_conversationImageProvider!.selections.length - 1).toString(): 2,
      'opacity' +
          (_conversationImageProvider!.selections.length - 1).toString(): 0
    });
    _conversationImageProvider?.setIsSelection(true);
  }

  void _goto(int goto) {
    _nowCode = goto;
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
        SoundPlayer().cvState == PlayerState.stopped &&
        SoundPlayer().asState == PlayerState.stopped &&
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
    _timer?.cancel();
    // _animationLoop();
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
      BuildContext context) async {
    if (_conversationImageProvider == null ||
        _conversationTextProvider == null ||
        _conversationLogProvider == null) {
      _conversationImageProvider = cip;
      _conversationTextProvider = ctp;
      _conversationLogProvider = clp;
      _context = context;

      // init
      _nowCode = 0;
      _nowLength = 0;
      _nowText = '';
      _conversationLogs = [];
      // await loadJsonAsset(
      //     'assets/text/ScenarioData/ChapterTest/102.json'); // TODO : ここの引数変えればJSON読み込めます
      // SoundPlayer()
      //     .precacheSounds(filePaths: _bgmPaths, audioType: SoundPlayer.bgm);
      // SoundPlayer()
      //     .precacheSounds(filePaths: _voicePaths, audioType: SoundPlayer.cv);
      // setSettings(textSpeed: await settingsController.getTextSpeedValue());
      // _animationLoop();
      // _refreshScreen();
      print('start');
      // TODO : ディレイ取り除く
      await Future.delayed(const Duration(milliseconds: 100));
      _goNextScene();
      ConversationAnimation.characterDefault();
    }
  }

  /// Stop controller.
  /// This function is for ConversationScreenUI.
  void stop() async {
    _timer?.cancel();
    _conversationImageProvider = null;
    _conversationTextProvider = null;
    _conversationLogProvider = null;
  }

  ///
  ///
  void tapScreen() {
    if (!_conversationImageProvider!.isHideUi &&
        !_conversationImageProvider!.isLog &&
        !_conversationImageProvider!.isMenu &&
        !_conversationImageProvider!.isSelection) {
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
        SoundPlayer().stopCVAll();
        SoundPlayer().stopASAll();
        _conversationImageProvider!.setVoicePath(null);
        _goNextScene();
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
    _timer?.cancel();
    if (_conversationImageProvider != null &&
        _conversationTextProvider != null &&
        _conversationLogProvider != null &&
        _context != null) {
      await Navigator.pushReplacement(
        _context!,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => TitleScreen(),
        ),
      );
      stop();
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationImageProvider.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationLogProvider.dart';
import 'package:sosaku/Settings/Provider_Settings_SettingsProvider.dart';
import 'package:sosaku/Title/UI_title_TitleScreen.dart';
import 'package:sosaku/Wrapper/wrapper_SoundPlayer.dart';
import 'Provider_conversation_ConversationTextProvider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;

/// @Fields
/// [_types], [_backgroundImagePaths], [_characterImagePaths], [_characterNames],
/// [_texts], [_bgmPaths], [_voicePaths], [_sePaths], [_options], [_gotoNumbers],
/// [_nowCode], [_nowLength], [_nowText], [_conversationLogs]
///
/// @Setters(for load json)
/// [setTypes], [setBackgroundImagePaths], [setCharacterImagePaths], [setCharacterNames],
/// [setTexts], [setBgmPaths], [setVoicePaths], [setSePaths], [setOptions], [setGotoNumbers]
/// [setSettings],
///
/// @Methods
/// [start], [stop], [goNextScene], [goSelectedScene], [goLogScene]
/// [changeAutoPlay], [changeHideUi],
/// [openLog], [openMenu]
/// TODO[save]
class ConversationScreenController {
  int _interval = 40; // [ms]
  String _playerName = 'プレイヤー';
  ConversationImageProvider? _conversationImageProvider;
  ConversationTextProvider? _conversationTextProvider;
  ConversationLogProvider? _conversationLogProvider;
  BuildContext? _context;
  Timer? _timer;

  /// List of conversation types(speech or question or action).
  List<int> _types = [];

  /// List of background image paths.
  List<String> _backgroundImagePaths = [];

  /// List of character image paths.
  List<String> _characterImagePaths = [];

  /// List of character names.
  List<String> _characterNames = [];

  /// List of conversation texts.
  List<String> _texts = [];

  /// List of bgm paths.
  List<String> _bgmPaths = [];

  /// List of voice paths.
  List<String> _voicePaths = [];

  /// List of AS.
  List<String> _sePaths = [];

  /// List of options.
  List<List<String>> _options = [];

  /// List of goto numbers.
  List<List<int>> _gotoNumbers = [];

  /// Code number to display.
  int _nowCode = 0;

  /// Length of teIs auto play?xt being displayed.
  int _nowLength = 0;

  /// Text being displayed.
  String _nowText = '';

  /// List of conversation logs.
  List<int> _conversationLogs = [];

  void setTypes(List<int> typeList) {
    _types = typeList;
  }

  void setBackgroundImagePaths(List<String> backgroundImagePathList) {
    _backgroundImagePaths = backgroundImagePathList;
  }

  void setCharacterImagePaths(List<String> characterImagePathList) {
    _characterImagePaths = characterImagePathList;
  }

  void setCharacterNames(List<String> characterNameList) {
    _characterNames = characterNameList;
  }

  void setTexts(List<String> conversationTextList) {
    _texts = conversationTextList;
  }

  void setBgmPaths(List<String> bgmPathList) {
    _bgmPaths = bgmPathList;
  }

  void setVoicePaths(List<String> voicePathList) {
    _voicePaths = voicePathList;
  }

  void setSePaths(List<String> sePathList) {
    _sePaths = sePathList;
  }

  void setOptions(List<List<String>> optionList) {
    _options = optionList;
  }

  void setGotoNumbers(List<List<int>> gotoNumberList) {
    _gotoNumbers = gotoNumberList;
  }

  void setSettings({double? textSpeed, String? playerName}) {
    if (textSpeed != null) {
      int interval = 85 - textSpeed.toInt() * 15;
      _interval = interval;
    }
    _playerName = playerName ?? _playerName;
    _timer?.cancel();
    _animationLoop();
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

      SoundPlayer()
          .precacheSounds(filePaths: _bgmPaths, audioType: SoundPlayer.bgm);
      SoundPlayer()
          .precacheSounds(filePaths: _voicePaths, audioType: SoundPlayer.cv);
      await loadJsonAsset(
          'assets/text/ScenarioData/ChapterTest/102.json'); // TODO : ここの引数変えればJSON読み込めます
      setSettings(textSpeed: await settingsController.getTextSpeedValue());
      _animationLoop();
      _refreshScreen();
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

  /// Load json to list.
  /// @param path : Json path.;
  Future<void> loadJsonAsset(String path) async {
    String jsonString = await rootBundle.loadString(path);
    // 文字の置換(<Player>を_playerNameに)
    jsonString = jsonString.replaceAll('<Player>', _playerName);
    Map<String, dynamic> jsonData = json.decode(jsonString);
    List<dynamic> context = jsonData['context'];
    List<int> _types = [];
    List<String> _backgroundImagePaths = [];
    List<String> _characterImagePaths = [];
    List<String> _characterNames = [];
    List<String> _texts = [];
    List<String> _bgmPaths = [];
    List<String> _voicePaths = [];
    List<String> _sePaths = [];
    List<List<String>> _options = [];
    List<List<int>> _gotoNumbers = [];
    for (int i = 0; i < context.length; i++) {
      _types.add(context[i]['type']);
      _backgroundImagePaths.add(context[i]['BGImage']);
      _characterImagePaths.add(context[i]['CharacterImage']);
      _characterNames.add(context[i]['name']);
      _texts.add(context[i]['text']);
      _bgmPaths.add(context[i]['BGM']);
      // TODO: ボイスとSEをListにするなら書き換える
      _voicePaths
          .add(context[i]['Voice'].isEmpty ? '' : context[i]['Voice'][0]);
      _sePaths.add(context[i]['AS'].isEmpty ? '' : context[i]['Voice'][0]);
      _options.add(context[i]['option'].cast<String>());
      _gotoNumbers.add(context[i]['goto'].cast<int>());
    }
    setTypes(_types);
    setBackgroundImagePaths(_backgroundImagePaths);
    setCharacterImagePaths(_characterImagePaths);
    setCharacterNames(_characterNames);
    setTexts(_texts);
    setBgmPaths(_bgmPaths);
    setVoicePaths(_voicePaths);
    setSePaths(_sePaths);
    setOptions(_options);
    setGotoNumbers(_gotoNumbers);
  }

  /// Go to the next scene on the speech screen.
  /// This function is for ConversationScreenUI.
  void goNextScene() {
    //テキストが最後まで表示されていて、ログの表示やUIの非表示がされていないか
    if (_nowLength == _texts[_nowCode].length &&
        !_conversationImageProvider!.isHideUi &&
        !_conversationImageProvider!.isLog &&
        !_conversationImageProvider!.isMenu) {
      //speech画面ならば次のシーンへ進む
      if (_types[_nowCode] == 1) {
        if (_gotoNumbers[_nowCode].isEmpty) {
          if (_nowCode + 1 < _types.length) {
            _nowCode++;
          } else {
            throw FormatException(
                'Code ${_nowCode + 1} does not exist.  Set the correct goto.');
          }
        } else if (_gotoNumbers[_nowCode][0] == -1) {
          endEvent();
        } else {
          if (_gotoNumbers[_nowCode][0] < _types.length) {
            _nowCode = _gotoNumbers[_nowCode][0];
          } else {
            throw FormatException(
                'Code ${_gotoNumbers[_nowCode][0]} does not exist.  Set the correct goto.');
          }
        }
        _refreshScreen();
      }
    } else {
      if (_nowLength != _texts[_nowCode].length) {
        _nowLength = _texts[_nowCode].length - 1;
      }
      if (_conversationImageProvider!.isLog) {
        openLog();
      }
      if (_conversationImageProvider!.isMenu) {
        _conversationImageProvider?.changeMenuDisplay();
      }
      if (_conversationImageProvider!.isHideUi) {
        changeHideUi();
      }
    }
  }

  /// Go to selected scene.
  /// This function is for ThreeChoicesDialog.
  ///
  /// @param optionNumber :　number of the selected option (0,1,2,...)
  void goSelectedScene(int optionNumber) {
    if (_conversationImageProvider!.dialogFlag) {
      _conversationImageProvider?.changeDialogFlag();
    }
    if (_gotoNumbers[_nowCode][optionNumber] == -1) {
      endEvent();
    } else {
      if (_gotoNumbers[_nowCode][optionNumber] < _types.length) {
        _nowCode = _gotoNumbers[_nowCode][optionNumber];
      } else {
        throw FormatException(
            'Code ${_gotoNumbers[_nowCode][optionNumber]} does not exist.  Set the correct goto.');
      }
    }
    _refreshScreen();
  }

  /// Jump to the selected scene in the log.
  /// This function is for Log.
  ///
  /// @param logNumber :　Number in the log list of the selected scene.(Not a code number.)
  void goLogScene(int logNumber) {
    if (_conversationImageProvider!.dialogFlag) {
      _conversationImageProvider?.changeDialogFlag();
    }
    if (_conversationImageProvider!.isLog) {
      _conversationImageProvider?.changeLogDisplay();
    }
    if (_conversationImageProvider!.isMenu) {
      _conversationImageProvider?.changeMenuDisplay();
    }
    if (_conversationImageProvider!.isHideUi) {
      changeHideUi();
    }
    if (_conversationLogs[logNumber] < _types.length) {
      _nowCode = _conversationLogs[logNumber];
      _conversationLogs.removeRange(logNumber, _conversationLogs.length);
    } else {
      throw FormatException(
          'Code ${_conversationLogs[logNumber]} does not exist.  Set the correct goto.');
    }
    _refreshScreen();
  }

  /// Change auto play.
  /// This function is for ConversationScreenUI.
  void changeAutoPlay() {
    _conversationImageProvider?.changeAuto();
  }

  /// Change hide ui.
  /// This function is for ConversationScreenUi.
  void changeHideUi() {
    _conversationImageProvider?.changeHideUi();
  }

  /// Open the log screen.(If already open, close it.)
  /// This function is for ConversationScreenUi
  void openLog() {
    if (!_conversationImageProvider!.isLog) {
      _conversationLogProvider?.setCodes(_conversationLogs);
      List<String> _logNames = [];
      List<String> _logIconPaths = [];
      List<String> _logTexts = [];
      List<bool> _logIsPlaying = [];
      for (int i = 0; i < _conversationLogs.length; i++) {
        _logNames.add(_characterNames[_conversationLogs[i]]);
        switch (_characterNames[_conversationLogs[i]]) {
          case ('籾原彩菜'):
          case ('彩菜'):
          case ('あやな'):
            _logIconPaths.add('assets/drawable/Conversation/icon_ayana.png');
            break;
          case ('栃ノ瀬ののの'):
          case ('ののの'):
            _logIconPaths.add('assets/drawable/Conversation/icon_nonono.png');
            break;
          case ('銀田榊'):
          case ('榊'):
          case ('さかき'):
            _logIconPaths.add('assets/drawable/Conversation/icon_sakaki.png');
            break;
          default:
            _logIconPaths.add('assets/drawable/Conversation/icon_unknown.png');
            break;
        }
        _logTexts.add(_texts[_conversationLogs[i]]);
        _logIsPlaying.add(false);
      }
      _conversationLogProvider?.setNames(_logNames);
      _conversationLogProvider?.setTexts(_logTexts);
      _conversationLogProvider?.setIconPaths(_logIconPaths);
      _conversationLogProvider?.setIsPlaying(_logIsPlaying);
      changeHideUi();
      _conversationImageProvider?.changeLogDisplay();
    } else {
      if (_conversationLogProvider!.isPlaying.contains(true)) {
        // FIXED : CV could not be stopped.
        // When the x button is pressed, stop audio if it was playing in the conversation log.
        SoundPlayer().stopCVAll();
      }
      changeHideUi();
      _conversationImageProvider?.changeLogDisplay();
    }
  }

  /// Open the menu screen.(If already open, close it.)
  /// This function is for ConversationScreenUi
  void openMenu() {
    _conversationImageProvider?.changeMenuDisplay();
    changeHideUi();
  }

  void playLogVoice(int numOfLog) {
    List<bool> _logIsPlaying =
        List<bool>.filled(_conversationLogProvider!.codes.length, false);
    _logIsPlaying[numOfLog] = true;
    _conversationLogProvider?.setIsPlaying(_logIsPlaying);
    SoundPlayer()
        .playCV([_voicePaths[_conversationLogProvider!.codes[numOfLog]]]);
  }

  /// Thread loop
  void _animationLoop() {
    void _animationCallback(Timer timer) {
      _timer = timer;
      if (_conversationImageProvider != null &&
          _conversationTextProvider != null &&
          _conversationLogProvider != null) {
        _autoAnimation();
      } else {
        _timer?.cancel();
      }
    }

    Timer.periodic(Duration(milliseconds: _interval), _animationCallback);
  }

  /// Auto animation without operation.
  /// Text animation, display question dialog, autoplay, change log data, etc...
  void _autoAnimation() {
    if (_conversationImageProvider!.isLog) {
      // processing on the log screen
      if (_conversationLogProvider!.isPlaying.contains(true) &&
          SoundPlayer().cvState == PlayerState.stopped) {
        _conversationLogProvider?.setIsPlaying(
            List<bool>.filled(_conversationLogProvider!.codes.length, false));
      }
    } else if (_conversationImageProvider!.isMenu) {
      // processing on the menu screen
    } else {
      // Processing on other screens
      if (_nowLength < _texts[_nowCode].length) {
        _nowLength++;
        _nowText = _texts[_nowCode].substring(0, _nowLength);
        _conversationTextProvider?.setConversationText(_nowText);
        if (_conversationImageProvider!.canNext) {
          _conversationImageProvider!.setCanNext(false);
        }
      } else if ((_types[_nowCode] == 2 || _types[_nowCode] == 3) &&
          !_conversationImageProvider!.dialogFlag) {
        _conversationImageProvider?.setOptionTexts(_options[_nowCode]);
        _conversationImageProvider!.changeDialogFlag();
      } else if (_conversationImageProvider!.isAuto &&
          _types[_nowCode] == 1 &&
          _nowLength == _texts[_nowCode].length &&
          !_conversationImageProvider!.isHideUi) {
        //TODO : Rewrite the condition as when voice playback ends.
        goNextScene();
      } else if (!_conversationImageProvider!.canNext) {
        _conversationImageProvider!.setCanNext(true);
      }
    }
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

  /// Refresh the screen and save the Logs.
  void _refreshScreen() {
    if (_conversationImageProvider != null &&
        _conversationTextProvider != null &&
        _conversationLogProvider != null) {
      _nowLength = 0;
      _conversationLogs.add(_nowCode);
      _changeBackgroundImage();
      _changeCharacterImage();
      _changeCharacterName();
      _changeBgm();
      _changeVoice();
      _changeSe();
    }
  }

  ///Change background image.
  void _changeBackgroundImage() {
    // _backgroundImagePathsが空でなければ(変更があれば)
    if (_backgroundImagePaths[_nowCode].isNotEmpty &&
        _conversationImageProvider!.mBGImagePath !=
            _backgroundImagePaths[_nowCode]) {
      _conversationImageProvider?.setBGImage((_backgroundImagePaths[_nowCode]));
    }
  }

  ///Change character image.
  void _changeCharacterImage() {
    // _characterImagePathsが空でなければ(変更があれば)
    if (_characterImagePaths[_nowCode].isNotEmpty &&
        _conversationImageProvider!.characterImagePath !=
            _characterImagePaths[_nowCode]) {
      _conversationImageProvider!
          .setCharacterImage(_characterImagePaths[_nowCode]);
    }
  }

  /// Change character name.
  void _changeCharacterName() {
    _conversationImageProvider?.setCharacterName(_characterNames[_nowCode]);
  }

  /// Change bgm.
  void _changeBgm() async {
    if (_bgmPaths[_nowCode].isNotEmpty) {
      // await Future.delayed(Duration(milliseconds: 10));
      SoundPlayer().playBGM(_bgmPaths[_nowCode]);
    }
  }

  /// Change voice.
  void _changeVoice() {
    if (_voicePaths[_nowCode].isNotEmpty) {
      SoundPlayer().playCV([_voicePaths[_nowCode]]);
    }
  }

  /// Change se.
  void _changeSe() {
    if (_sePaths[_nowCode].isNotEmpty) {
      SoundPlayer().playAS([_sePaths[_nowCode]]);
    }
  }
}

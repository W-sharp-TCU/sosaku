import 'package:sosaku/Conversation/Provider_conversation_ConversationImage.dart';
import 'package:sosaku/Wrapper/wrapper_SoundPlayer.dart';
import 'Provider_conversation_ConversationText.dart';
import 'package:audioplayers/audioplayers.dart';

/// @Fields
/// [_types], [_backgroundImagePaths], [_characterImagePaths], [_characterNames],
/// [_conversationTexts], [_bgmPaths], [_voicePaths], [_sePaths], [_options], [_gotoNumbers],
/// [_nowScene], [_nowLength], [_nowText], [_conversationLogs]
///
/// @Setters(for load json)
/// [setTypes], [setBackgroundImagePaths], [setCharacterImagePaths], [setCharacterNames],
/// [setConversationTexts], [setBgmPaths], [setVoicePaths], [setSePaths], [setOptions], [setGotoNumbers]
///
/// @Getters(for display logs,hide UI, auto play, )
/// [characterNames], [conversationTexts], [voicePaths],
/// [_nowScene], [nowLength], [isAuto], [conversationLogs]
///
/// @Methods
/// [start], [stop], [goNextScene], [goSelectedScene], [changeAutoPlay], [changeHideUi], [changeLogDisplay]
/// Todo[save]
class ConversationScreenController {
  final int _interval = 40; // [ms]
  ConversationImageProvider? _conversationImageProvider;
  ConversationTextProvider? _conversationTextProvider;

  /// List of conversation types(speech or question).
  List<String> _types = [
    "speech",
    "speech",
    "speech",
    "speech",
    "speech",
    "speech",
    "speech",
    "question",
    "speech",
    "speech",
    "speech",
  ];

  /// List of background image paths.
  List<String> _backgroundImagePaths = [
    "assets/drawable/Conversation/background_sample1.jpg",
    "",
    "",
    "assets/drawable/Conversation/background_sample2.jpg",
    "assets/drawable/Conversation/background_sample1.jpg",
    "assets/drawable/Conversation/background_sample2.jpg",
    "",
    "",
    "",
    "assets/drawable/Conversation/background_sample1.jpg",
    "",
  ];

  /// List of character image paths.
  List<String> _characterImagePaths = [
    "assets/drawable/Conversation/no_character.png",
    "assets/drawable/Conversation/character_sample1.png",
    "",
    "assets/drawable/Conversation/no_character.png",
    "",
    "assets/drawable/Conversation/character_sample2.png",
    "assets/drawable/Conversation/no_character.png",
    "assets/drawable/Conversation/character_sample2.png",
    "",
    "",
    "",
  ];

  /// List of character names.
  List<String> _characterNames = [
    "車掌",
    "俺",
    "人",
    "女子高生",
    "俺",
    "車掌",
    "あいつ",
    "俺",
    "俺",
    "俺",
    "俺",
  ];

  /// List of conversation texts.
  List<String> _conversationTexts = [
    "「次は～、耶麻台～」",
    "桜が舞い落ちる四月。\n新年度ということもあってか、俺が飛び乗った電車はいつもより人が多い気がした。",
    "進学し、ぴかぴかな制服で登校するであろう女子高生。\n就職し、社会人として荒波に揉まれていくサラリーマン。\n電車内でいちゃいちゃしてる、派手な髪色の男女。",
    "世の中は皆、何かしら変化が起きている。\nそして、",
    "「まもなく～、耶麻台～、お出口は～右側です」",
    "「9時23分、こりゃ早朝マラソン確定だな……。いつも通りあいつに連絡するか」",
    "「俺のように、なーんにも変わっていない人もいる。」",
    "「次の授業なんだっけ？」",
    "「次の授業は国語だよ」",
    "「次の授業は数学だよ」",
    "「次の授業は英語だよ」",
  ];

  /// List of bgm paths.
  List<String> _bgmPaths = [
    "assets/sound/fb.wav",
    "",
    "",
    "",
    "",
    "",
    "",
    "assets/sound/fb.wav",
    "",
    "",
    "",
  ];

  /// List of voice paths.
  List<String> _voicePaths = [
    "assets/sound/voice_sample_000.wav",
    "assets/sound/voice_sample_001.wav",
    "assets/sound/voice_sample_002.wav",
    "assets/sound/voice_sample_003.wav",
    "assets/sound/voice_sample_004.wav",
    "assets/sound/voice_sample_005.wav",
    "assets/sound/voice_sample_006.wav",
    "assets/sound/voice_sample_007.wav",
    "assets/sound/voice_sample_008.wav",
    "assets/sound/voice_sample_009.wav",
    "assets/sound/voice_sample_010.wav",
  ];

  /// List of SE.
  List<String> _sePaths = [];

  /// List of options.
  List<List<String>> _options = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    ["国語", "数学", "英語"],
    [],
    [],
    [],
  ];

  /// List of goto numbers.
  List<List<int>> _gotoNumbers = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
    [8, 9, 10],
    [0],
    [0],
    [0],
  ];

  /// Scene number to display.(code)
  int _nowScene = 0;

  /// Length of teIs auto play?xt being displayed.
  int _nowLength = 0;

  /// Text being displayed.
  String _nowText = "";

  /// Is on auto play?
  bool _isAuto = false;

  /// List of conversation logs.
  List<int> _conversationLogs = [];

  List<String> get characterNames => _characterNames;
  List<String> get conversationTexts => _conversationTexts;
  List<String> get voicePaths => _voicePaths;
  int get nowScene => _nowScene;
  int get nowLength => _nowLength;
  bool get isAuto => _isAuto;
  List<int> get conversationLogs => _conversationLogs;

  void setTypes(List<String> typeList) {
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

  void setConversationTexts(List<String> conversationTextList) {
    _conversationTexts = conversationTextList;
  }

  void setBgmPaths(List<String> bgmPathList) {
    _bgmPaths = bgmPathList;
  }

  void setVoicePaths(List<String> voicePathList) {
    _voicePaths = voicePathList;
  }

  void setOptions(List<List<String>> optionList) {
    _options = optionList;
  }

  void setGotoNumbers(List<List<int>> gotoNumberList) {
    _gotoNumbers = gotoNumberList;
  }

  /// Start controller.
  /// This function is for ConversationScreenUI.
  ///
  /// @param cip : ConversationImageProvider
  /// @param ctp : ConversationTextProvider
  void start(ConversationImageProvider cip, ConversationTextProvider ctp) {
    if (_conversationImageProvider == null &&
        _conversationTextProvider == null) {
      _conversationImageProvider = cip;
      _conversationTextProvider = ctp;
      _animationAsync();
      _refreshScreen();
      // Todo : load in loadclass
      SoundPlayer.loadBGM(_bgmPaths);
      SoundPlayer.loadSE(_voicePaths);
    }
  }

  /// Stop controller.
  void stop() {
    _conversationImageProvider = null;
    _conversationTextProvider = null;
  }

  /// Go to the next scene on the speech screen.
  /// This function is for ConversationScreenUI.
  void goNextScene() {
    //テキストが最後まで表示されていて、ログの表示やUIの非表示がされていないか
    if (_nowLength == _conversationTexts[_nowScene].length &&
        !_conversationImageProvider!.isHideUi &&
        !_conversationImageProvider!.isLogDisplay) {
      //speech画面ならば次のシーンへ進む
      if (_types[_nowScene] == "speech") {
        if (_gotoNumbers[_nowScene].isEmpty) {
          _nowScene++;
        } else {
          _nowScene = _gotoNumbers[_nowScene][0];
        }
        _refreshScreen();
      }
    } else {
      if (_nowLength != _conversationTexts[_nowScene].length) {
        _nowLength = _conversationTexts[_nowScene].length - 1;
      }
      if (_conversationImageProvider!.isHideUi) {
        _conversationImageProvider!.changeHideUi();
      }
      if (_conversationImageProvider!.isLogDisplay) {
        _conversationImageProvider!.changeLogDisplay();
      }
    }
  }

  /// Go to selected scene.
  /// This function is for ThreeChoicesDialog
  ///
  /// @param optionNumber :　number of the selected option (0,1,2,...)
  void goSelectedScene(int optionNumber) {
    if (_conversationImageProvider!.dialogFlag) {
      _conversationImageProvider!.changeDialogFlag();
    }
    _nowScene = _gotoNumbers[_nowScene][optionNumber];
    _refreshScreen();
  }

  void changeAutoPlay() {
    _isAuto = !_isAuto;
  }

  ///Thread loop
  void _animationAsync() async {
    await Future.delayed(Duration(milliseconds: _interval));
    _autoAnimation();
    if (_conversationImageProvider != null &&
        _conversationTextProvider != null) {
      _animationAsync();
    }
  }

  /// Auto animation without operation.
  /// Text animation, display question dialog, autoplay, change log data, etc...
  void _autoAnimation() async {
    if (_nowLength < _conversationTexts[_nowScene].length) {
      _nowLength++;
      _nowText = _conversationTexts[_nowScene].substring(0, _nowLength);
      _conversationTextProvider!.setConversationText(_nowText);
    } else if (_types[_nowScene] == "question" &&
        !_conversationImageProvider!.dialogFlag) {
      _conversationImageProvider!.setOptionTexts(_options[_nowScene]);
      _conversationImageProvider!.changeDialogFlag();
    } else if (_isAuto &&
            _types[_nowScene] == "speech" &&
            _nowLength ==
                _conversationTexts[_nowScene]
                    .length /* &&
        SoundPlayer.seState != PlayerState.PLAYING*/
        ) {
      //Todo : Rewrite the condition as when voice playback ends.
      goNextScene();
    }
  }

  /// Refresh the screen and save the Logs.
  void _refreshScreen() {
    _nowLength = 0;
    _conversationLogs.add(_nowScene);
    // print("Log:" + _conversationLogs.toString());
    _changeBackgroundImage();
    _changeCharacterImage();
    _changeCharacterName();
    _changeBgm();
    _changeVoice();
  }

  ///Change background image.
  void _changeBackgroundImage() {
    // _backgroundImagePathsが空でなければ(変更があれば)
    if (_backgroundImagePaths[_nowScene].isNotEmpty &&
        _conversationImageProvider!.mBGImagePath !=
            _backgroundImagePaths[_nowScene]) {
      _conversationImageProvider!
          .setBGImage((_backgroundImagePaths[_nowScene]));
    }
  }

  ///Change character image.
  void _changeCharacterImage() {
    // _characterImagePathsが空でなければ(変更があれば)
    if (_characterImagePaths[_nowScene].isNotEmpty &&
        _conversationImageProvider!.characterImagePath !=
            _characterImagePaths[_nowScene]) {
      _conversationImageProvider!
          .setCharacterImage(_characterImagePaths[_nowScene]);
    }
  }

  /// Change character name.
  void _changeCharacterName() {
    _conversationImageProvider!.setCharacterName(_characterNames[_nowScene]);
  }

  /// Change bgm.
  void _changeBgm() async {
    if (_bgmPaths[_nowScene].isNotEmpty) {
      SoundPlayer.stopBGM();
      await Future.delayed(Duration(milliseconds: 10));
      SoundPlayer.playBGM(_bgmPaths[_nowScene]);
    }
  }

  /// Change voice.
  void _changeVoice() {
    SoundPlayer.stopSE();
    if (_voicePaths[_nowScene].isNotEmpty) {
      SoundPlayer.playSE(_voicePaths[_nowScene]);
    }
  }

  /// Change se.
  void _changeSe() {
    SoundPlayer.stopSE();
    if (_sePaths[_nowScene].isNotEmpty) {
      SoundPlayer.playSE(_sePaths[_nowScene]);
    }
  }
}

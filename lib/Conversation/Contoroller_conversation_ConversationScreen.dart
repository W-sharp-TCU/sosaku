import 'package:flutter/widgets.dart';
import 'package:sosaku/Conversasion/Provider_conversation_ConversationScreen.dart';

class ConversationScreenController {
  final int _interval = 40; // [ms]
  ConversationScreenProvider? _conversationScreenProvider;

  ///List of conversations.
  final List<String> _conversationTextList = [
    "「次は～、耶麻台～」",
    "桜が舞い落ちる四月。\n新年度ということもあってか、俺が飛び乗った電車はいつもより人が多い気がした。",
    "進学し、ぴかぴかな制服で登校するであろう女子高生。\n就職し、社会人として荒波に揉まれていくサラリーマン。\n電車内でいちゃいちゃしてる、派手な髪色の男女。",
    "世の中は皆、何かしら変化が起きている。\nそして、",
    "「まもなく～、耶麻台～、お出口は～右側です」",
    "「9時23分、こりゃ早朝マラソン確定だな……。いつも通りあいつに連絡するか」",
    "「俺のように、なーんにも変わっていない人もいる。」"
  ];

  ///List of character image path.
  final List<String> _characterImagePaths = [
    "assets/drawable/Title/default.jpg",
    "assets/drawable/Title/Lion.jpg",
    "assets/drawable/Title/default.jpg",
    "assets/drawable/Title/Lion.jpg",
    "assets/drawable/Title/default.jpg",
    "assets/drawable/Title/Lion.jpg",
    "assets/drawable/Title/default.jpg",
  ];

  ///List of background image path.
  final List<String> _backgroundImagePaths = [
    "assets/drawable/Title/Lion.jpg",
    "assets/drawable/Title/default.jpg",
    "assets/drawable/Title/Lion.jpg",
    "assets/drawable/Title/default.jpg",
    "assets/drawable/Title/Lion.jpg",
    "assets/drawable/Title/default.jpg",
    "assets/drawable/Title/Lion.jpg",
    "assets/drawable/Title/default.jpg",
  ];

  ///Scene number to display.
  int _numOfScene = 0;

  ///Length of text being displayed.
  int _nowLength = 0;

  ///Text being displayed.
  String _nowText = "";

  ///Start controller.
  ///
  /// @param context : context
  /// @param csp : conversation screen provider
  void start(BuildContext context, ConversationScreenProvider csp) {
    if (_conversationScreenProvider == null) {
      _conversationScreenProvider = csp;
      _animationAsync();
      _changeBackgroundImage();
      _changeCharacterImage();
    }
  }

  ///Stop controller
  void stop() {
    _conversationScreenProvider = null;
  }

  void _animationAsync() async {
    _textAnimation();
    await Future.delayed(Duration(milliseconds: _interval));
    if (_conversationScreenProvider != null) {
      _animationAsync();
    }
  }

  ///Animation to display one character at a time.
  void _textAnimation() {
    if (_nowLength < _conversationTextList[_numOfScene].length) {
      _nowLength++;
      _nowText = _conversationTextList[_numOfScene].substring(0, _nowLength);
      _conversationScreenProvider!.setConversationText(_nowText);
    }
  }

  ///Go to next scene.
  void nextScene() {
    if (_nowLength == _conversationTextList[_numOfScene].length) {
      _nowLength = 0;
      _changeBackgroundImage();
      _changeCharacterImage();
      if (_numOfScene != _conversationTextList.length - 1) {
        _numOfScene++;
      } else {
        _numOfScene = 0;
      }
    } else {
      _nowLength = _conversationTextList[_numOfScene].length - 1;
    }
  }

  void _changeBackgroundImage() {
    _conversationScreenProvider!
        .setBGImage((_backgroundImagePaths[_numOfScene]));
  }

  void _changeCharacterImage() {
    _conversationScreenProvider!
        .setCharacterImage(_characterImagePaths[_numOfScene]);
  }
}

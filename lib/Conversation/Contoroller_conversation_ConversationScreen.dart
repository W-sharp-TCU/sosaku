import 'package:flutter/widgets.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationImage.dart';

import 'Provider_conversation_ConversationText.dart';

class ConversationScreenController {
  final int _interval = 40; // [ms]
  ConversationImageProvider? _conversationImageProvider;
  ConversationTextProvider? _conversationTextProvider;

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
    "assets/drawable/Conversation/no_character.png",
    "assets/drawable/Conversation/character_sample1.png",
    "assets/drawable/Conversation/character_sample1.png",
    "assets/drawable/Conversation/no_character.png",
    "assets/drawable/Conversation/no_character.png",
    "assets/drawable/Conversation/character_sample2.png",
    "assets/drawable/Conversation/no_character.png",
  ];

  ///List of background image path.
  final List<String> _backgroundImagePaths = [
    "assets/drawable/Conversation/background_sample1.jpg",
    "assets/drawable/Conversation/background_sample1.jpg",
    "assets/drawable/Conversation/background_sample1.jpg",
    "assets/drawable/Conversation/background_sample2.jpg",
    "assets/drawable/Conversation/background_sample1.jpg",
    "assets/drawable/Conversation/background_sample2.jpg",
    "assets/drawable/Conversation/background_sample2.jpg",
  ];

  ///Scene number to display.
  int _numOfScene = 0;

  ///Length of text being displayed.
  int _nowLength = 0;

  ///Text being displayed.
  String _nowText = "";

  ///Start controller.
  ///
  /// @param cip : ConversationImageProvider
  /// @param ctp : ConversationTextProvider
  void start(ConversationImageProvider cip, ConversationTextProvider ctp) {
    if (_conversationImageProvider == null &&
        _conversationTextProvider == null) {
      _conversationImageProvider = cip;
      _conversationTextProvider = ctp;
      _animationAsync();
      _changeBackgroundImage();
      _changeCharacterImage();
    }
  }

  ///Stop controller
  void stop() {
    _conversationImageProvider = null;
    _conversationTextProvider = null;
  }

  void _animationAsync() async {
    await Future.delayed(Duration(milliseconds: _interval));
    _textAnimation();
    if (_conversationImageProvider != null &&
        _conversationTextProvider != null) {
      _animationAsync();
    }
  }

  ///Animation to display one character at a time.
  void _textAnimation() {
    if (_nowLength < _conversationTextList[_numOfScene].length) {
      _nowLength++;
      _nowText = _conversationTextList[_numOfScene].substring(0, _nowLength);
      _conversationTextProvider!.setConversationText(_nowText);
    }
  }

  ///Go to next scene.
  void nextScene() {
    if (_nowLength == _conversationTextList[_numOfScene].length) {
      _nowLength = 0;
      if (_numOfScene != _conversationTextList.length - 1) {
        _numOfScene++;
      } else {
        _numOfScene = 0;
      }
      _changeBackgroundImage();
      _changeCharacterImage();
    } else {
      _nowLength = _conversationTextList[_numOfScene].length - 1;
    }
  }

  void _changeBackgroundImage() {
    _conversationImageProvider!
        .setBGImage((_backgroundImagePaths[_numOfScene]));
  }

  void _changeCharacterImage() {
    _conversationImageProvider!
        .setCharacterImage(_characterImagePaths[_numOfScene]);
  }
}

import 'package:flutter/widgets.dart';
import 'package:sosaku/Conversasion/Provider_conversation_ConversationScreen.dart';
import 'package:sosaku/Title/Interface_title_SlideShowInterface.dart';

class ConversationScreenController {
  final int _interval = 100; // [ms]
  ConversationScreenProvider? _conversationScreenProvider;

  ///list of Conversations
  final List<String> _conversationTextList = [
    "わがはいは猫である。\n名前は\nまだない。",
    "どこで生まれたかとんと\n見当が\nつかぬ。",
    "おわり。",
  ];

  ///Text number to display.
  int _numOfConversation = 0;

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
    if (_nowLength < _conversationTextList[_numOfConversation].length) {
      _nowLength++;
      _nowText =
          _conversationTextList[_numOfConversation].substring(0, _nowLength);
      _conversationScreenProvider!.setConversationText(_nowText);
    }
  }

  ///Switch to next text.
  void switchText() {
    if (_nowLength == _conversationTextList[_numOfConversation].length) {
      _nowLength = 0;
      if (_numOfConversation != _conversationTextList.length - 1) {
        _numOfConversation++;
      } else {
        _numOfConversation = 0;
      }
    } else {
      _nowLength = _conversationTextList[_numOfConversation].length - 1;
    }
  }
}

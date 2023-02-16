import 'package:flutter/cupertino.dart';

class ConversationTextProvider extends ChangeNotifier {
  String _conversationText = "";
  String _narrationText = "";

  String get conversationText => _conversationText;
  String get narrationText => _narrationText;

  /// Set the text to be display.
  /// This function is for Controller.
  ///
  /// @param optionTexts : Text to be displayed in the conversation.
  void setConversationText(String text) {
    _conversationText = text;
    notifyListeners();
  }

  void setNarrationText(String text) {
    _narrationText = text;
    notifyListeners();
  }
}

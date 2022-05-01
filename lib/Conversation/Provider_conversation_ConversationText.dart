import 'package:flutter/cupertino.dart';

class ConversationTextProvider extends ChangeNotifier {
  String _conversationText = "おためし  apple banana \nテキスト orange\nです\n４行目は表示なし";

  String get conversationText => _conversationText;

  /// Set the text to be display.
  /// This function is for Controller.
  ///
  /// @param optionTexts : Text to be displayed in the conversation.
  void setConversationText(String text) {
    _conversationText = text;
    notifyListeners();
  }
}

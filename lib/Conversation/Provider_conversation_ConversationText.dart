import 'package:flutter/cupertino.dart';
import 'package:sosaku/Conversation/Contoroller_conversation_ConversationScreen.dart';

class ConversationTextProvider extends ChangeNotifier {
  String _conversationText = "おためし  apple banana \nテキスト orange\nです\n４行目は表示なし";

  String get conversationText => _conversationText;

  void setConversationText(String text) {
    _conversationText = text;
    notifyListeners();
  }
}

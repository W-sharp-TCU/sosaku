import 'package:flutter/cupertino.dart';
import 'package:sosaku/Conversasion/Contoroller_conversation_ConversationScreen.dart';

class ConversationScreenProvider extends ChangeNotifier {
  String _mBGImagePath = "drawable/Load/default.jpg";
  String _characterImagePath = "drawable/Load/default.jpg";
  String _conversationText = "おためし  apple banana \nテキスト orange\nです\n４行目は表示なし";
  final ConversationScreenController _conversationScreenController =
      ConversationScreenController();

  String get mBGImagePath => _mBGImagePath;
  String get characterImagePath => _characterImagePath;
  String get conversationText => _conversationText;
  ConversationScreenController get conversationScreenController =>
      _conversationScreenController;
  void setBGImage(String path) {
    _mBGImagePath = path;
    notifyListeners();
  }

  void setCharacterImage(String path) {
    _characterImagePath = path;
    notifyListeners();
  }

  void setConversationText(String text) {
    _conversationText = text;
    notifyListeners();
  }

  void start(BuildContext context) {
    _conversationScreenController.start(context, this);
  }

  void stop() {
    _conversationScreenController.stop();
  }
}

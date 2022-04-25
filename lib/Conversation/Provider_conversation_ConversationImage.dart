import 'package:flutter/cupertino.dart';
import 'package:sosaku/Conversation/Contoroller_conversation_ConversationScreen.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationText.dart';

class ConversationImageProvider extends ChangeNotifier {
  String _mBGImagePath = "drawable/Load/default.jpg";
  String _characterImagePath = "drawable/Load/default.jpg";

  String get mBGImagePath => _mBGImagePath;
  String get characterImagePath => _characterImagePath;

  void setBGImage(String path) {
    _mBGImagePath = path;
    notifyListeners();
  }

  void setCharacterImage(String path) {
    _characterImagePath = path;
    notifyListeners();
  }
}

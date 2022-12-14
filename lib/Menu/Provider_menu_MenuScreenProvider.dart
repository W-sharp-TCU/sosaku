import 'package:flutter/cupertino.dart';

// TODO : 必要なら実装
class MenuScreenProvider extends ChangeNotifier {
  bool _isMenu = false;
  bool _isHelp = false;
  bool get isMenu => _isMenu;
  bool get isHelp => _isHelp;

  void setIsMenu(bool isMenu) {
    _isMenu = isMenu;
    notifyListeners();
  }

  void setIsHelp(bool isHelp) {
    _isHelp = isHelp;
    notifyListeners();
  }
}

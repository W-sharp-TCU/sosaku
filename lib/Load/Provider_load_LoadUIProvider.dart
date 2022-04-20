import 'package:flutter/cupertino.dart';

class LoadUIProvider extends ChangeNotifier {
  bool _popFlag = false;
  bool get popFlag => _popFlag;

  void changeFlag(){
    _popFlag = !_popFlag;
    notifyListeners();
  }
}

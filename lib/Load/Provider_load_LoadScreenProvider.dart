import 'package:flutter/cupertino.dart';

class LoadScreenProvider extends ChangeNotifier {
  String _mBGImagePath = "drawable/Load/default.jpg";
  bool _popFlag = false;

  String get mBGImagePath => _mBGImagePath;
  bool get popFlag => _popFlag;

  @override
  void setImage(String path) {
    _mBGImagePath = path;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';

class LoadScreenProvider extends ChangeNotifier {
  String _mBGImagePath = "drawable/Load/default.jpg";

  String get mBGImagePath => _mBGImagePath;

  @override
  void setImage(String path) {
    _mBGImagePath = path;
    notifyListeners();
  }

  void start(BuildContext context) {}

  void stop() {}
}

import 'package:flutter/cupertino.dart';

class LoadUIProvider extends ChangeNotifier {
  String _mBGImagePath = "drawable/Load/default.jpg";
  bool _popFlag = false;

  String get mBGImagePath => _mBGImagePath;
  bool get popFlag => _popFlag;
}

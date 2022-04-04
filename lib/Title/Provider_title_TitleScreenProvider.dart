import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:provider/provider.dart';

class TitleScreenProvider extends ChangeNotifier {
  String _mBGImagePath = "assets/drawable/Title/splash.png";


  set mBGImagePath (String path) {
    _mBGImagePath = path;
    notifyListeners();
  }
}
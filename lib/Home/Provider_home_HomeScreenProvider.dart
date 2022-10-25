import 'package:flutter/widgets.dart';
import 'package:sosaku/Title/Interface_title_SlideShowInterface.dart';

class HomeScreenProvider extends ChangeNotifier implements SlideShowInterface {
  String _mBGImagePath = "assets/drawable/Title/title.png";

  String get mBGImagePath => _mBGImagePath;

  @override
  void setImage(String path) {
    _mBGImagePath = path;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:sosaku/Title/Controller_title_SlideShowController.dart';
import 'package:sosaku/Title/Interface_title_SlideShowInterface.dart';

class TitleScreenProvider extends ChangeNotifier implements SlideShowInterface{
  String _mBGImagePath = "drawable/Title/default.jpg";
  final SlideShowController _slideShowController = SlideShowController();

  String get mBGImagePath => _mBGImagePath;

  @override
  void setImage(String path) {
    _mBGImagePath = path;
    notifyListeners();
  }

  void start(BuildContext context){
    _slideShowController.start(context, this);
  }

  void stop() {
    _slideShowController.stop();
  }
}
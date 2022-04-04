import 'package:flutter/widgets.dart';
import 'package:sosaku/Title/Provider_title_TitleScreenProvider.dart';

class SlideShowController {
  final int _interval = 3000; // [ms]
  final List<String> _imagePaths = ["assets/drawable/Splash/splash.png"];

  late TitleScreenProvider _target;

  /// start change image in _interval milli seconds.
  void start(TitleScreenProvider target) {
    _target = target;
  }

  /// stop changing.
  void stop() {

  }

  Future<void> changeImage(BuildContext context) async {
    await precacheImage(AssetImage(_imagePaths[0]), context);
    _target.mBGImagePath = _imagePaths[0];
    Future.delayed(Duration(milliseconds: _interval));
  }

}
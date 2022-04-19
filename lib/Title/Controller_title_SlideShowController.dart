import 'package:flutter/widgets.dart';
import 'package:sosaku/Title/Interface_title_SlideShowInterface.dart';

class SlideShowController {
  final int _interval = 5000; // [ms]
  final List<String> _imagePaths = [
    "assets/drawable/Title/Ocean.jpg",
    "assets/drawable/Title/Lion.jpg",
    "assets/drawable/Title/default.jpg"
  ];
  SlideShowInterface? _target;
  int _i = 0;

  /// Start changing images in [_interval] milli seconds.
  /// This function can be called in build() of Widget class repeatedly.
  ///
  /// @param context : specify [BuildContext] of build().
  /// @param target : specify the instance of [ChangeNotifier] which extends
  /// [SlideShowInterface].
  void start(BuildContext context, SlideShowInterface target) {
    if (_target == null) {
      _target = target;
      _threadLoop(context);
    }
  }

  /// Stop changing.
  void stop() {
    _target = null;
  }

  Future<void> _threadLoop(BuildContext context) async {
    _changeImage(context).then((value) {
      Future.delayed(Duration(milliseconds: _interval), () {
        if (_target != null) {
          _threadLoop(context);
        } else {
          // do nothing.
        }
      });
    });
  }

  Future<void> _changeImage(BuildContext context) async {
    await precacheImage(AssetImage(_imagePaths[_i]), context);
    if (_i != _imagePaths.length - 1) {
      _i++;
    } else {
      _i = 0;
    }
    if (_target != null) {
      _target!.setImage(_imagePaths[_i]);
    }
  }
}

import 'package:flutter/widgets.dart';
import 'package:sosaku/Title/Interface_title_SlideShowInterface.dart';

class SlideShowController {
  final int _interval = 5000; // [ms]
  final List<String> imagePaths;
  SlideShowInterface? _target;
  int _i = 0;

  SlideShowController(this.imagePaths);

  /// Start changing images in [_interval] milli seconds.
  /// This function can be called in build() of Widget class repeatedly.
  ///
  /// @param context : specify [BuildContext] of build().
  /// @param target : specify the instance of [ChangeNotifier] which extends
  /// [SlideShowInterface].
  void start(SlideShowInterface target) {
    if (_target == null) {
      _target = target;
      _threadLoop();
    } else {
      _target = target;
    }
  }

  /// Stop changing.
  void stop() {
    _target = null;
  }

  Future<void> _threadLoop() async {
    _changeImage().then((value) {
      Future.delayed(Duration(milliseconds: _interval), () {
        if (_target != null) {
          _threadLoop();
        } else {
          // do nothing.
        }
      });
    });
  }

  Future<void> _changeImage() async {
    if (_i != imagePaths.length - 1) {
      _i++;
    } else {
      _i = 0;
    }
    if (_target != null) {
      _target!.setImage(imagePaths[_i]);
    }
  }
}

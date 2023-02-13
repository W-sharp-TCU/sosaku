import 'package:flutter/cupertino.dart';

class GetScreenSize {
  static double _deviceHeight = -1;
  static double _deviceWidth = -1;

  static void setSize(double deviceHeight, double deviceWidth) {
    _deviceHeight = deviceHeight;
    _deviceWidth = deviceWidth;
  }

  static void follow(BuildContext context) {
    setSize(
      MediaQuery.of(context).size.height,
      MediaQuery.of(context).size.width,
    );
  }

  static double screenHeight() {
    double _i = 0.0, _j = 0.0, screenHeight;
    _i = _deviceHeight / 9;
    _j = _deviceWidth / 16;

    if (_i >= _j) {
      screenHeight = _j * 9;
      return screenHeight;
    } else {
      screenHeight = _i * 9;
      return screenHeight;
    }
  }

  static double screenWidth() {
    double _i = 0.0, _j = 0.0, screenWidth;
    _i = _deviceHeight / 9;
    _j = _deviceWidth / 16;

    if (_i >= _j) {
      screenWidth = _j * 16;
      return screenWidth;
    } else {
      screenWidth = _i * 16;
      return screenWidth;
    }
  }
}

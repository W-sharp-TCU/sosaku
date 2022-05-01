import 'package:flutter/widgets.dart';

class Otameshi extends ChangeNotifier {
  double _textSliderValue = 1;
  double _voiceSliderValue = 5;
  double _bgmSliderValue = 5;
  double _seSliderValue = 5;

  double get textSliderValue => _textSliderValue;
  double get voiceSliderValue => _voiceSliderValue;
  double get bgmSliderValue => _bgmSliderValue;
  double get seSliderValue => _seSliderValue;

  void setTextSliderValue(double value) {
    _textSliderValue = value;
    notifyListeners();
  }

  void setBGMSliderValue(double value) {
    _bgmSliderValue = value;
    notifyListeners();
  }

  void setVoiceSliderValue(double value) {
    _voiceSliderValue = value;
    notifyListeners();
  }

  void setSESliderValue(double value) {
    _seSliderValue = value;
    notifyListeners();
  }
}
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Otameshi extends ChangeNotifier{
  double _textSliderValue = 1;
  double get textSliderValue => _textSliderValue;

  void setSliderValue(double value){
    _textSliderValue = value;
    notifyListeners();
  }

}
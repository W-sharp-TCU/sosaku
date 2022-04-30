import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Otameshi extends ChangeNotifier{
  double _sliderValue = 1;
  double get sliderValue => _sliderValue;

  void setSliderValue(double value){
    _sliderValue = value;
    notifyListeners();
  }

}
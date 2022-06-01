import 'package:flutter/material.dart';

class DialogProvider extends ChangeNotifier{
  double _i = 0.0;
  double get i => _i;

  Future<void> animatedButton() async{
    _i = 1.0;
    notifyListeners();

  }
}
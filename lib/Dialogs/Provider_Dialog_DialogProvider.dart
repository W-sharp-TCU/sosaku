import 'package:flutter/material.dart';

class DialogProvider extends ChangeNotifier{
  double _i = 1.0;
  double get i => _i;



  Future<void> animatedButton() async {
    _i = 1.0;
    await Future.delayed(const Duration(microseconds: 1000));
    _i = 1.5;
    notifyListeners();
    await Future.delayed(const Duration(microseconds: 1000));
    _i = 1.0;
    notifyListeners();
  }
}
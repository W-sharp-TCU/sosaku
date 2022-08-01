import 'package:flutter/material.dart';

class LoadUIProvider extends ChangeNotifier {
  bool _popFlagDialog = false;
  bool get popFlagDialog => _popFlagDialog;
  bool _popFlagSaveMenu = true;
  bool get popFlagSaveMenu => _popFlagSaveMenu;

  void changeFlagDialog(){
    _popFlagDialog = !_popFlagDialog;
    notifyListeners();
  }

  void changeFlagSaveMenu(){
    _popFlagSaveMenu = !_popFlagSaveMenu;
    notifyListeners();
  }
}

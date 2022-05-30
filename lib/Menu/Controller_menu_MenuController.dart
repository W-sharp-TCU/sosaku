import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';

import '../Home/UI_home_HomeScreen.dart';
import '../Settings/UI_Setting_SettingScreen.dart';
import 'Provider_menu_MenuProvider.dart';

class MenuScreenController {
  late final MenuScreenProvider _menuProvider;
  late final BuildContext _context;
  MenuScreenController();

  void start(MenuScreenProvider menuScreenProvider, BuildContext context) {
    _menuProvider = menuScreenProvider;
    _context = context;
  }

  void save() {}
  void openOption() {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(builder: (context) => const SettingScreen()),
    );
  }

  void openHelp() {
    if (_menuProvider.isHelp == false) {
      _menuProvider.setIsHelp(isHelp: true);
    } else {
      _menuProvider.setIsHelp(isHelp: false);
    }
  }

  void goHome() {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}

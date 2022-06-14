import 'package:flutter/material.dart';

import '../Home/UI_home_HomeScreen.dart';
import '../Settings/UI_Setting_SettingScreen.dart';
import 'Provider_menu_MenuScreenProvider.dart';

class MenuScreenController {
  MenuScreenProvider? _menuScreenProvider;
  late BuildContext _context;
  MenuScreenController();

  void start(MenuScreenProvider menuScreenProvider, BuildContext context) {
    if (_menuScreenProvider != null) {
      _menuScreenProvider = menuScreenProvider;
    }
    _context = context;
  }

  void save() {}
  void openOption() {
    Navigator.push(
      _context,
      PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SettingScreen(),
          transitionDuration: const Duration(milliseconds: 100)),
    );
  }

  void openHelp() {
    if (_menuScreenProvider?.isHelp == false) {
      _menuScreenProvider?.setIsHelp(isHelp: true);
    } else {
      _menuScreenProvider?.setIsHelp(isHelp: false);
    }
  }

  void goHome() {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}

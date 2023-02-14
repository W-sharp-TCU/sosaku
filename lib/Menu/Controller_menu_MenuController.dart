import 'package:flutter/material.dart';
import 'package:sosaku/Help/UI_help_HelpPopUp.dart';

import '../Home/UI_home_HomeScreen.dart';
import '../Settings/UI_settings_SettingScreen.dart';
import '../Wrapper/Functions_wrapper_TransitionBuilders.dart';
import '../Wrapper/wrapper_AnimationWidget.dart';
import 'Provider_menu_MenuScreenProvider.dart';
import 'UI_Menu_MenuScreen.dart';

class MenuScreenController {
  MenuScreenProvider? _menuScreenProvider;
  MenuScreenController();

  void start(MenuScreenProvider menuScreenProvider, BuildContext context) {
    if (_menuScreenProvider != null) {
      _menuScreenProvider = menuScreenProvider;
    }
  }

  static void onTapOpenDefault(
      BuildContext context, MenuScreen? menuScreen) async {
    await precacheImage(
        const AssetImage('assets/drawable/Menu/status_sample.png'), context);
    await precacheImage(
        const AssetImage('assets/drawable/Menu/status_bar_sample.png'),
        context);
    Navigator.push(
      context,
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => menuScreen ?? const MenuScreen(),
          transitionDuration: const Duration(milliseconds: 0)),
    );

    /// TODO : 現在のステータスをロード
    double money = 10000;
    double ayanaSkill = 3;
    double nononoSkill = 10;
    animationController
        .animate('statusUI', 'money', [Linear(0, 500, 0, money)]);
    animationController
        .animate('statusUI', 'ayanaSkill', [Linear(0, 500, 0, ayanaSkill)]);
    animationController
        .animate('statusUI', 'nononoSkill', [Linear(0, 500, 0, nononoSkill)]);
  }

  static void onTapCloseDefault(BuildContext context) {
    Navigator.pop(context);
  }

  static void onTapSaveDefault() {
    // TODO : 進行状況をセーブ
  }
  static void onTapOptionDefault(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) => const SettingScreen(),
          transitionDuration: const Duration(milliseconds: 100)),
    );
  }

  static void onTapHelpDefault(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (_, __, ___) =>
              HelpPopUp(contentsFilePath: "assets/text/HelpData/example.json"),
          transitionDuration: const Duration(milliseconds: 100)),
    );
  }

  static void onTapGoTitleDefault(BuildContext context) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomeScreen(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              buildFadeTransition(
                  context, animation, secondaryAnimation, child)),
    );
  }
}

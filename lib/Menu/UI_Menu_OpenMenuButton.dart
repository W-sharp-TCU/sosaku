import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Menu/Controller_menu_MenuController.dart';

import '../Wrapper/wrapper_AnimationButton.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_Menu_MenuScreen.dart';

class OpenMenuButton extends ConsumerWidget {
  final Widget? openMenuButton;
  final MenuScreen? menuScreen;

  /// タップすると、menuScreenに遷移するボタン
  ///
  /// @param openMenuButton : ボタンのウィジェット
  ///
  /// @param menuScreen : 遷移先のmenuScreen画面のwidget
  const OpenMenuButton({Key? key, this.openMenuButton, this.menuScreen})
      : assert(
            openMenuButton == null || menuScreen == null,
            'openMenuButtonがデフォルト(null)でない場合、openMenuButtonのonTap内に'
            'MenuScreenController.onTapOpenDefault(context, MenuScreen());'
            'のようにメニュースクリーンへ遷移する関数を記述してください'),
        super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('openMenuButton context $context');
    return openMenuButton ??
        Align(
          alignment: const Alignment(1, -1),
          child: AnimationButton(
              key: const Key('menuOpen'),
              onTap: () {
                MenuScreenController.onTapOpenDefault(
                    context, menuScreen ?? MenuScreen());
              },
              width: GetScreenSize.screenWidth() * 0.06,
              height: GetScreenSize.screenWidth() * 0.06,
              margin: EdgeInsets.all(GetScreenSize.screenWidth() * 0.02),
              child: const FittedBox(fit: BoxFit.contain, child: Text('≡'))),
        );
  }
}

///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Menu/Controller_menu_MenuController.dart';
import 'package:sosaku/Menu/UI_Menu_OpenMenuButton.dart';
import 'package:sosaku/Menu/UI_Menu_MenuScreen.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';

import '../Settings/Provider_settings_SettingsProvider.dart';
import '../Wrapper/wrapper_AnimationButton.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_conversation_ConversationScreen.dart';

class SideUIs extends ConsumerWidget {
  const SideUIs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
      MediaQuery.of(context).size.height,
      MediaQuery.of(context).size.width,
    );

    return Container(
      margin: EdgeInsets.all(GetScreenSize.screenWidth() * 0.01),
      width: GetScreenSize.screenWidth() * 0.1,
      height: GetScreenSize.screenHeight() * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ///menu
          OpenMenuButton(
            openMenuButton: AnimationButton(
                key: const Key('menu'),
                onTap: () {
                  conversationScreenController.openMenu();
                  MenuScreenController.onTapOpenDefault(
                    context,
                    MenuScreen(
                      onTapClose: () {
                        conversationScreenController.openMenu();
                        conversationScreenController.setSettings(
                            textSpeed: settingsController.textSpeed);
                      },
                      onTapGoTitle: () {
                        // TODO : conversationScreenControllerにタイトルに戻る関数を作成する
                        conversationScreenController.endEvent();
                      },
                    ),
                  );
                },
                width: GetScreenSize.screenWidth() * 0.07,
                height: GetScreenSize.screenWidth() * 0.07,
                margin: EdgeInsets.only(
                    left: GetScreenSize.screenWidth() * 0.01,
                    top: GetScreenSize.screenWidth() * 0.01,
                    right: GetScreenSize.screenWidth() * 0.01),
                child: const FittedBox(
                    fit: BoxFit.contain, child: Icon(Icons.menu))),
            // menuScreen: const MenuScreen(),
          ),

          const Spacer(),

          ///UI appear
          AnimationButton(
              key: const Key('ui'),
              onTap: () {
                conversationScreenController.changeHideUi();
              },
              width: GetScreenSize.screenWidth() * 0.07,
              height: GetScreenSize.screenWidth() * 0.07,
              margin: EdgeInsets.only(
                  left: GetScreenSize.screenWidth() * 0.01,
                  // top: GetScreenSize.screenWidth() * 0.01,
                  right: GetScreenSize.screenWidth() * 0.01),
              child: const FittedBox(
                fit: BoxFit.contain,
                child: Icon(Icons.close),
              )),

          // const Spacer(),

          ///auto button
          AnimationButton(
              key: const Key('auto'),
              onTap: () {
                conversationScreenController.changeAutoPlay();
              },
              width: GetScreenSize.screenWidth() * 0.07,
              height: GetScreenSize.screenWidth() * 0.07,
              margin: EdgeInsets.only(
                  left: GetScreenSize.screenWidth() * 0.01,
                  right: GetScreenSize.screenWidth() * 0.01),
              // image: 'assets/drawable/Conversation/yokonagabotton.png',
              child: FittedBox(
                  fit: BoxFit.contain,
                  // child: Text("Auto"),
                  child: ref.watch(conversationImageProvider).isAuto
                      ? const Icon(Icons.stop)
                      : const Icon(Icons.play_arrow))),

          ///Log button
          AnimationButton(
              key: const Key('log'),
              onTap: () {
                conversationScreenController.openLog();
              },
              width: GetScreenSize.screenWidth() * 0.07,
              height: GetScreenSize.screenWidth() * 0.07,
              margin: EdgeInsets.only(
                  left: GetScreenSize.screenWidth() * 0.01,
                  right: GetScreenSize.screenWidth() * 0.01),
              // image: 'assets/drawable/Conversation/yokonagabotton.png',
              child: const FittedBox(
                fit: BoxFit.contain,
                child: Icon(Icons.note),
              )),

          /// いしかわ先生の元コード
          // ///menu
          // GestureDetector(
          //   onTap: () {
          //     conversationScreenController.openMenu();
          //   },
          //   child: Container(
          //       // width: GetScreenSize.screenWidth() * 0.05,
          //
          //       width: ref.watch(_button1).stateDouble['width'],
          //       // height: GetScreenSize.screenWidth() * 0.05,
          //       height: ref.watch(_button1).stateDouble['height'],
          //       margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.02),
          //       color: Colors.red.withOpacity(0.5),
          //       child: Center(
          //         child: Text(
          //           "三",
          //           style: TextStyle(
          //             fontSize: GetScreenSize.screenHeight() * 0.04,
          //           ),
          //         ),
          //       )),
          // ),
          //
          // ///UI appear
          // GestureDetector(
          //   onTap: () {
          //     conversationScreenController.changeHideUi();
          //     animationController.stopAnimation('button1', 'width');
          //     animationController.stopAnimation('button1', 'height');
          //   },
          //   child: Container(
          //     width: GetScreenSize.screenWidth() * 0.05,
          //     height: GetScreenSize.screenWidth() * 0.05,
          //     margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.02),
          //     color: Colors.red.withOpacity(0.5),
          //     child: Center(
          //       child: Text(
          //         "UI",
          //         style: TextStyle(
          //           fontSize: GetScreenSize.screenHeight() * 0.04,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          //
          // const Spacer(),
          //
          // ///auto button
          // GestureDetector(
          //   onTap: () {
          //     conversationScreenController.changeAutoPlay();
          //   },
          //   child: Container(
          //     height: GetScreenSize.screenHeight() * 0.05,
          //     width: GetScreenSize.screenWidth() * 0.1,
          //     color: Colors.red.withOpacity(0.5),
          //     margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.02),
          //     child: Center(
          //       child: Text(
          //         "Auto",
          //         style: TextStyle(
          //           fontSize: GetScreenSize.screenHeight() * 0.02,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          //
          // ///Log button
          // GestureDetector(
          //   onTap: () {
          //     conversationScreenController.openLog();
          //   },
          //   child: Container(
          //     height: GetScreenSize.screenHeight() * 0.05,
          //     width: GetScreenSize.screenWidth() * 0.1,
          //     color: Colors.red.withOpacity(0.5),
          //     margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.02),
          //     child: Center(
          //       child: Text(
          //         "Log",
          //         style: TextStyle(
          //           fontSize: GetScreenSize.screenHeight() * 0.02,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          //
          // const Spacer(),
        ],
      ),
    );
  }
}

///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';

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
          AnimationButton(
              onTap: () {
                conversationScreenController.openMenu();
              },
              width: GetScreenSize.screenWidth() * 0.05,
              height: GetScreenSize.screenWidth() * 0.05,
              margin: EdgeInsets.all(GetScreenSize.screenWidth() * 0.01),
              color: Colors.red.withOpacity(0.5),
              child: const FittedBox(
                fit: BoxFit.contain,
                child: Image(
                  image: AssetImage('assets/drawable/Conversation/sakura.png'),
                ),
              )),

          ///UI appear
          AnimationButton(
              onTap: () {
                conversationScreenController.changeHideUi();
              },
              width: GetScreenSize.screenWidth() * 0.05,
              height: GetScreenSize.screenWidth() * 0.05,
              margin: EdgeInsets.all(GetScreenSize.screenWidth() * 0.01),
              color: Colors.red.withOpacity(0.5),
              child: const FittedBox(
                fit: BoxFit.contain,
                child: Text("UI"),
              )),

          const Spacer(),

          ///auto button
          AnimationButton(
              onTap: () {
                conversationScreenController.changeAutoPlay();
              },
              width: GetScreenSize.screenWidth() * 0.1,
              height: GetScreenSize.screenHeight() * 0.05,
              margin: EdgeInsets.all(GetScreenSize.screenWidth() * 0.01),
              color: Colors.red.withOpacity(0.5),
              child: const FittedBox(
                fit: BoxFit.contain,
                child: Text("Auto"),
              )),

          ///Log button
          AnimationButton(
              onTap: () {
                conversationScreenController.openLog();
              },
              width: GetScreenSize.screenWidth() * 0.1,
              height: GetScreenSize.screenHeight() * 0.05,
              margin: EdgeInsets.all(GetScreenSize.screenWidth() * 0.01),
              color: Colors.red.withOpacity(0.5),
              child: const FittedBox(
                fit: BoxFit.contain,
                child: Text("LOG"),
              )),

          /// いしかわ先生の元コード
          ///menu
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

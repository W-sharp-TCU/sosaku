///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_conversation_ConversationScreen.dart';
import '../Wrapper/wrapper_AnimationButton.dart';

class SideUIs extends ConsumerWidget {
  const SideUIs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
      MediaQuery.of(context).size.height,
      MediaQuery.of(context).size.width,
    );

    return SizedBox(
      width: GetScreenSize.screenWidth() * 0.1,
      height: GetScreenSize.screenHeight(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          /// MENU
          AnimationButton(
            id: 'buttonMenu',
            onTap: () {
              conversationScreenController.openMenu();
              abc.startZoomInOut('buttonMenu');
            },
            width: GetScreenSize.screenWidth() * 0.07,
            height: GetScreenSize.screenWidth() * 0.07,
            opacity: 0,
            text: '三',
            textStyle: TextStyle(
              fontSize: GetScreenSize.screenWidth() * 0.02,
            ),
            image: "assets/drawable/Conversation/button_sample.png",
          ),

          /// UI
          AnimationButton(
            id: 'buttonUI',
            onTap: () {
              conversationScreenController.changeHideUi();
              abc.startZoomInOut('buttonUI');
            },
            width: GetScreenSize.screenWidth() * 0.07,
            height: GetScreenSize.screenWidth() * 0.07,
            opacity: 0,
            text: '×',
            textStyle: TextStyle(
              fontSize: GetScreenSize.screenWidth() * 0.04,
            ),
            image: "assets/drawable/Conversation/button_sample.png",
          ),

          /// AUTO
          AnimationButton(
            id: 'buttonAuto',
            onTap: () {
              conversationScreenController.changeAutoPlay();
              abc.startZoomInOut('buttonAuto');
            },
            width: GetScreenSize.screenWidth() * 0.07,
            height: GetScreenSize.screenWidth() * 0.07,
            opacity: 0,
            text: ref.watch(conversationImageProvider).isAuto ? '■' : '▶',
            textStyle: TextStyle(
              fontSize: GetScreenSize.screenWidth() * 0.04,
            ),
            image: "assets/drawable/Conversation/button_sample.png",
          ),

          /// LOG
          AnimationButton(
            id: 'buttonLog',
            onTap: () {
              conversationScreenController.openLog();
              abc.startZoomInOut('buttonLog');
            },
            width: GetScreenSize.screenWidth() * 0.07,
            height: GetScreenSize.screenWidth() * 0.07,
            opacity: 0,
            text: 'LOG',
            textStyle: TextStyle(
              fontSize: GetScreenSize.screenWidth() * 0.02,
            ),
            image: "assets/drawable/Conversation/button_sample.png",
          )
        ],
      ),
    );
  }
}

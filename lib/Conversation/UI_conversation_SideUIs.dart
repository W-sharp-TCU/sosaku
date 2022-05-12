///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_conversation_ConversationScreen.dart';
import '../Wrapper/wrapper_AnimationButton.dart';

class SideUIs extends ConsumerWidget{
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
          ///menu
          GestureDetector(
            onTap: () {},
            child: Container(
                width: GetScreenSize.screenWidth() * 0.05,
                height: GetScreenSize.screenWidth() * 0.05,
                margin: EdgeInsets.all(
                    GetScreenSize.screenHeight() * 0.02),
                color: Colors.red.withOpacity(0.5),
                child: Center(
                  child: Text(
                    "三",
                    style: TextStyle(
                      fontSize:
                      GetScreenSize.screenHeight() * 0.04,
                    ),
                  ),
                )),
          ),

          ///UI appear
          GestureDetector(
            onTap: () {
              conversationScreenController.changeHideUi();
            },
            child: Container(
              width: GetScreenSize.screenWidth() * 0.05,
              height: GetScreenSize.screenWidth() * 0.05,
              margin: EdgeInsets.all(
                  GetScreenSize.screenHeight() * 0.02),
              color: Colors.red.withOpacity(0.5),
              child: Center(
                child: Text(
                  "UI",
                  style: TextStyle(
                    fontSize:
                    GetScreenSize.screenHeight() * 0.04,
                  ),
                ),
              ),
            ),
          ),

          AnimationButton(
            id: "buttonAuto",
            onTap: () {
              conversationScreenController.changeAutoPlay();
            },
            width: GetScreenSize.screenWidth() * 0.07,
            height: GetScreenSize.screenWidth() * 0.07,
            margin: 0,
            text: (ref.watch(conversationImageProvider).isAuto
                ? '■'
                : '▶'),
            textStyle: TextStyle(
              fontSize: GetScreenSize.screenWidth() * 0.04,
            ),
            image:
            "assets/drawable/Conversation/button_sample.png",
            color: Colors.white,
            opacity: 0,
            ratio: 1.1,
            duration: 64,
          ),

          const Spacer(),

          ///auto button
          GestureDetector(
            onTap: () {
              conversationScreenController.changeAutoPlay();
            },
            child: Container(
              height: GetScreenSize.screenHeight() * 0.05,
              width: GetScreenSize.screenWidth() * 0.1,
              color: Colors.red.withOpacity(0.5),
              margin: EdgeInsets.all(
                  GetScreenSize.screenHeight() * 0.02),
              child: Center(
                child: Text(
                  "Auto",
                  style: TextStyle(
                    fontSize: GetScreenSize.screenHeight() * 0.02,
                  ),
                ),
              ),
            ),
          ),

          ///Log button
          GestureDetector(
            onTap: () {
              conversationScreenController.openLog();
            },
            child: Container(
              height: GetScreenSize.screenHeight() * 0.05,
              width: GetScreenSize.screenWidth() * 0.1,
              color: Colors.red.withOpacity(0.5),
              margin: EdgeInsets.all(
                  GetScreenSize.screenHeight() * 0.02),
              child: Center(
                child: Text(
                  "Log",
                  style: TextStyle(
                    fontSize: GetScreenSize.screenHeight() * 0.02,
                  ),
                ),
              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}

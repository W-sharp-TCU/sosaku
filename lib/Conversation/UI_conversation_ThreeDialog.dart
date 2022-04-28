///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Conversation/Contoroller_conversation_ConversationScreen.dart';
import 'package:sosaku/Conversation/UI_conversation_ConversationScreen.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

class ThreeDialog extends ConsumerWidget {
  const ThreeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Container(
        width: GetScreenSize.screenWidth(),
        height: GetScreenSize.screenHeight(),
        color: Colors.black.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///first
            GestureDetector(
              onTap: () {
                conversationScreenController.goSelectedScene(0);
              },
              child: Container(
                  width: GetScreenSize.screenWidth() * 0.6,
                  height: GetScreenSize.screenHeight() * 0.15,
                  margin: EdgeInsets.only(
                    top: GetScreenSize.screenHeight() * 0.1,
                  ),
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      ref.watch(conversationImageProvider).optionTexts[0],
                      style: TextStyle(
                          fontSize: GetScreenSize.screenHeight() * 0.04),
                    ),
                  )),
            ),

            ///second
            GestureDetector(
              onTap: () {
                conversationScreenController.goSelectedScene(1);
              },
              child: Container(
                  width: GetScreenSize.screenWidth() * 0.6,
                  height: GetScreenSize.screenHeight() * 0.15,
                  margin: EdgeInsets.only(
                    top: GetScreenSize.screenHeight() * 0.1,
                  ),
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      ref.watch(conversationImageProvider).optionTexts[1],
                      style: TextStyle(
                          fontSize: GetScreenSize.screenHeight() * 0.04),
                    ),
                  )),
            ),

            ///third
            GestureDetector(
              onTap: () {
                conversationScreenController.goSelectedScene(2);
              },
              child: Container(
                  width: GetScreenSize.screenWidth() * 0.6,
                  height: GetScreenSize.screenHeight() * 0.15,
                  margin: EdgeInsets.only(
                    top: GetScreenSize.screenHeight() * 0.1,
                  ),
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      ref.watch(conversationImageProvider).optionTexts[2],
                      style: TextStyle(
                          fontSize: GetScreenSize.screenHeight() * 0.04),
                    ),
                  )),
            ),
          ],
        ));
  }
}

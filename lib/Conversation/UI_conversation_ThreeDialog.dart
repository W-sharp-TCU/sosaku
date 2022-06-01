///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Conversation/UI_conversation_ConversationScreen.dart';

import '../Wrapper/wrapper_AnimationButton.dart';

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
        color: Colors.black.withOpacity(0),

        ///debug
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: GetScreenSize.screenHeight() * 0.05,
            ),

            ///first
            AnimationButton(
              id: 'buttonOption0',
              onTap: () {
                conversationScreenController.goSelectedScene(0);
                abc.startZoomInOut('buttonOption0');
              },
              width: GetScreenSize.screenWidth() * 0.7,
              height: GetScreenSize.screenHeight() * 0.2,
              margin: GetScreenSize.screenHeight() * 0.015,
              opacity: 1,
              text: ref.watch(conversationImageProvider).optionTexts[0],
              textStyle: TextStyle(
                fontSize: GetScreenSize.screenHeight() * 0.04,
              ),
              ratio: 1.05,
            ),

            ///second
            AnimationButton(
              id: 'buttonOption1',
              onTap: () {
                conversationScreenController.goSelectedScene(1);
                abc.startZoomInOut('buttonOption1');
              },
              width: GetScreenSize.screenWidth() * 0.7,
              height: GetScreenSize.screenHeight() * 0.2,
              margin: GetScreenSize.screenHeight() * 0.015,
              opacity: 1,
              text: ref.watch(conversationImageProvider).optionTexts[1],
              textStyle: TextStyle(
                fontSize: GetScreenSize.screenHeight() * 0.04,
              ),
              ratio: 1.05,
            ),

            ///third
            AnimationButton(
              id: 'buttonOption2',
              onTap: () {
                conversationScreenController.goSelectedScene(2);
                abc.startZoomInOut('buttonOption2');
              },
              width: GetScreenSize.screenWidth() * 0.7,
              height: GetScreenSize.screenHeight() * 0.2,
              margin: GetScreenSize.screenHeight() * 0.015,
              opacity: 1,
              text: ref.watch(conversationImageProvider).optionTexts[2],
              textStyle: TextStyle(
                fontSize: GetScreenSize.screenHeight() * 0.04,
              ),
              ratio: 1.05,
            ),
          ],
        ));
  }
}

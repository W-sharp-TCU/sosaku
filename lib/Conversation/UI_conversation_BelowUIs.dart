///package
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bordered_text/bordered_text.dart';

import '../Wrapper/wrapper_AnimationWidget.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_conversation_ConversationScreen.dart';

class BelowUIs extends ConsumerWidget {
  const BelowUIs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    final animationProvider =
        animationController.createProvider('conversationTextAnimation', {
      'textLength': ref
          .watch(conversationTextProvider)
          .conversationText
          .length
          .toDouble(),
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///character name
        Container(
          height: GetScreenSize.screenHeight() * 0.08,
          width: GetScreenSize.screenWidth() * 0.15,
          color: const Color.fromRGBO(255, 201, 210, 0.1),
          padding: EdgeInsets.all(GetScreenSize.screenWidth() * 0.005),
          child: Align(
            alignment: const Alignment(-0.3, 0),
            child: BorderedText(
              strokeWidth: GetScreenSize.screenHeight() * 0.004,
              strokeColor: Colors.purple,
              child: Text(
                "[ " +
                    ref.watch(conversationImageProvider).characterName +
                    " ]",
                style: TextStyle(
                    fontSize: GetScreenSize.screenHeight() * 0.04,
                    color: Colors.white,
                    shadows: [
                      Shadow(blurRadius: GetScreenSize.screenHeight() * 0.005),
                    ]),
              ),
            ),
          ),
        ),

        ///text zone
        GestureDetector(
          onTap: () {},
          child: Container(
            height: GetScreenSize.screenHeight() * 0.25,
            width: GetScreenSize.screenWidth(),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: const [
                Color.fromRGBO(255, 201, 210, 0.7),
                Color.fromRGBO(255, 201, 210, 0.1)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
            padding: EdgeInsets.only(
              top: GetScreenSize.screenWidth() * 0.01,
              left: GetScreenSize.screenWidth() * 0.07,
              right: GetScreenSize.screenWidth() * 0.04,
              bottom: GetScreenSize.screenWidth() * 0.02,
            ),
            child: Align(
              alignment: const Alignment(-1, -1),
              child: BorderedText(
                strokeWidth: GetScreenSize.screenHeight() * 0.004,
                strokeColor: Colors.purple,
                child: Text(
                  ref
                      .watch(conversationTextProvider)
                      .conversationText
                      .substring(
                          0,
                          ref
                              .watch(animationProvider)
                              .stateDouble['textLength']!
                              .ceil()),
                  style: TextStyle(
                      fontSize: GetScreenSize.screenHeight() * 0.045,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            blurRadius: GetScreenSize.screenHeight() * 0.005),
                      ]),
                  maxLines: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

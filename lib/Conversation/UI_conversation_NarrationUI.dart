///package
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bordered_text/bordered_text.dart';

import '../Wrapper/wrapper_AnimationWidget.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_conversation_ConversationScreen.dart';

class NarrationUI extends ConsumerWidget {
  const NarrationUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    final animationProvider =
        animationController.createProvider('conversationNarration', {
      'opacity': 0,
    });

    return Align(
      alignment: Alignment(0, 0),
      child: Opacity(
        opacity: ref.watch(animationProvider).stateDouble['opacity']!,
        child: Container(
          width: GetScreenSize.screenWidth() * 0.6,
          height: GetScreenSize.screenHeight() * 0.15,
          color: Colors.white,
          child: Align(
            alignment: const Alignment(0, 0),
            child: Text(
              ref.watch(conversationTextProvider).narrationText,
              style: TextStyle(
                fontSize: GetScreenSize.screenHeight() * 0.06,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

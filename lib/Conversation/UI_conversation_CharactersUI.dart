import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../Wrapper/wrapper_AnimationWidget.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_conversation_ConversationScreen.dart';

class CharactersUI extends ConsumerWidget {
  const CharactersUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    final animationProvider =
        animationController.createProvider('conversationCharacter', {
      'height': 0,
    });

    return Positioned(
      height: GetScreenSize.screenHeight() * 1,
      width: GetScreenSize.screenWidth() * 0.5,
      top: GetScreenSize.screenHeight() *
          ref.watch(animationProvider).stateDouble['height']!,
      left: GetScreenSize.screenWidth() * 0.5 -
          GetScreenSize.screenWidth() * 0.25,
      child: Image(
        fit: BoxFit.fitHeight,
        image: AssetImage(
          ref.watch(conversationImageProvider).characterImagePath,
        ),
      ),
    );
  }
}

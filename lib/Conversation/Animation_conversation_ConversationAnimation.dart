import 'dart:math';

import 'package:sosaku/Conversation/Provider_conversation_ConversationImageProvider.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationLogProvider.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationTextProvider.dart';

import '../Wrapper/wrapper_AnimationWidget.dart';

class ConversationAnimation {
  static Future<void> triangle() async {
    await animationController.animate(
        'conversationScreen',
        'triangle',
        [
          Wave(0, 500, 1, 1.02, 1000, -0.5),
          Pause(500, 1000),
          Wave(1000, 1500, 1, 1.02, 1000, 0.5),
        ],
        -1);
    await animationController.animate('conversationScreen', 'angle',
        [Easing(0, 1500, 0, 4 * pi).inOutQuint(), Pause(1000, 1500)], -1);
  }

  static Future<void> selection(int length) async {
    for (int i = 0; i < length; i++) {
      await animationController.animate(
          'selections',
          'alignment' + i.toString(),
          [Easing(150 * i, 150 * i + 700, 2, 0).outElastic()]);
      await animationController.animate('selections', 'opacity' + i.toString(),
          [Easing(150 * i, 150 * i + 700, 0, 1).outQuint()]);
    }
  }

  static Future<void> characterDefault() async {
    await animationController.animate(
        'conversationCharacter',
        'height',
        [
          Wave(0, 2000, 1, 1.1, 2000, -0.5)
          // Linear(0, 2000, 1, 2)
        ],
        -1);
  }
}

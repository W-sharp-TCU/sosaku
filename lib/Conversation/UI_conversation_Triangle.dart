/// package
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';

/// other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

class Triangle extends ConsumerWidget {
  const Triangle({Key? key}) : super(key: key);
  Widget build(BuildContext context, WidgetRef ref) {
    final animationProvider =
        animationController.createProvider('conversationScreen', {
      'triangle': 1,
      'angle': 0,
    });
    return Align(
        alignment:
            Alignment(1, ref.watch(animationProvider).stateDouble['triangle']!),
        child: Container(
          margin: EdgeInsets.only(
            right: GetScreenSize.screenWidth() * 0.03,
          ),
          width: GetScreenSize.screenWidth() * 0.07,
          height: GetScreenSize.screenWidth() * 0.07,
          child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(ref.watch(animationProvider).stateDouble['angle']!),
              // ..rotateZ(0.5 * pi),
              alignment: Alignment.center,
              child: Icon(
                Icons.arrow_drop_down_outlined,
                size: GetScreenSize.screenWidth() * 0.07,
                color: (ref.watch(animationProvider).stateDouble['angle']! %
                                (2 * pi) <
                            0.5 * pi ||
                        1.5 * pi <
                            ref.watch(animationProvider).stateDouble['angle']! %
                                (2 * pi))
                    ? Colors.white
                    : Colors.purple,
              )
              // child: Text(
              //   '▼',
              //   style: TextStyle(
              //     fontSize: GetScreenSize.screenWidth() * 0.03,
              //     color: Colors.white,
              //   ),
              // )
              ),
        ));
  }
}

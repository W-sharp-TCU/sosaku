import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Common/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';
import 'package:sosaku/Wrapper/wrapper_SakuraTransition.dart';
import 'package:sosaku/Wrapper/wrapper_TapEffectScreen.dart';

import '../Wrapper/wrapper_GetScreenSize.dart';

class GameScreenBase extends ConsumerWidget {
  final Widget child;
  final LifecycleCallback lifecycleCallback;
  final bool opaque;
  const GameScreenBase(
      {this.lifecycleCallback = const CommonLifecycleCallback(),
      this.opaque = true,
      required this.child,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    return LifecycleManager(
      callback: lifecycleCallback,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: opaque ? Colors.black : Colors.transparent,
        child: Center(
          child: Container(
              height: GetScreenSize.screenHeight(),
              width: GetScreenSize.screenWidth(),
              color: opaque ? Colors.black : Colors.transparent,
              child: TapEffectScreen(
                child: SakuraTransition(
                  child: child,
                ),
              )),
        ),
      ),
    );
  }
}

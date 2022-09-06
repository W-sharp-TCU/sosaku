import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';

import '../Wrapper/wrapper_GetScreenSize.dart';

// ignore: must_be_immutable
class GameScreenBase extends ConsumerWidget {
  Widget child;
  LifecycleCallback lifecycleCallback;
  GameScreenBase(
      {required this.lifecycleCallback, required this.child, Key? key})
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
        color: Colors.black,
        child: Center(
          child: Container(
            height: GetScreenSize.screenHeight(),
            width: GetScreenSize.screenWidth(),
            color: Colors.black,
            child: child,
          ),
        ),
      ),
    );
  }
}

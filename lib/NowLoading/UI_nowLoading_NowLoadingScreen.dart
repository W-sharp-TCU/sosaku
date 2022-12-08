import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Common/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Common/Interface_common_GameScreenInterface.dart';
import 'package:sosaku/Common/UI_common_GameScreenBase.dart';
import 'package:sosaku/NowLoading/Manager_GameManager.dart';

import '../Wrapper/Functions_wrapper_TransitionBuilders.dart';

// ignore: must_be_immutable
class NowLoadingScreen extends HookConsumerWidget {
  /// Now Loading Screen will show in [_minDuration] milliseconds at least.
  static const int _minDuration = 3000; // [ms]

  final Function? process;
  final GameScreenInterface? goto;

  /// Show Now Loading Screen while processing.
  ///
  /// @param key (optional) : Flutter key.
  /// @param process : Specify processes you want to do while Now Loading Screen is appeared.
  ///                   ex) () async { await precacheImage(AssetImage("FILENAME"), context) }
  /// @param goto : Specify [Widget] you want to show after load processes finish.
  const NowLoadingScreen({Key? key, this.process, this.goto}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Prepare for next screen
    useEffect(() {
      _loadProcess(context);
      return null;
    });
    // Show widgets defined below until completion of loadProcess function.
    return Scaffold(
      body: GameScreenBase(
        lifecycleCallback: const CommonLifecycleCallback(),
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/drawable/NowLoading/LoadingAnimation.gif"))),
          child: const Center(
            child: Text(
              "Now Loading...",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loadProcess(BuildContext context) async {
    GameScreenInterface nextScreen;
    var startTime = DateTime.now().millisecondsSinceEpoch;

    // execute process if specified
    if (process != null) {
      await process!();
    } else {
      print("[info] NowLoadingScreen._loadProcess(): "
          "process == null.");
    }

    // execute prepare function if next screen is specified,
    // determine next screen and execute prepare function of it else.
    if (goto == null) {
      print("||||| goto ==> GameManager |||||");
      GameManager gameManager = GameManager();
      nextScreen = await gameManager.processing(context);
    } else {
      print("||||| goto ==> $goto |||||");
      nextScreen = goto!;
      await nextScreen.prepare(context);
    }

    // Now Loading Screen will show in [_minDuration] milliseconds at least.
    var diff = ((DateTime.now().millisecondsSinceEpoch) - (startTime));
    if (diff < _minDuration) {
      await Future.delayed(Duration(milliseconds: (_minDuration - diff)));
    }

    // Go to next screen from current (Now Loading) screen.
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (_, __, ___) => nextScreen as Widget,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              buildFadeTransition(
                  context, animation, secondaryAnimation, child)),
    );
  }
}

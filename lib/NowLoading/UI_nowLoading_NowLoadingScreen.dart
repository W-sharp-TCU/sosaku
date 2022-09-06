import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Common/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Common/Interface_common_GameScreenInterface.dart';
import 'package:sosaku/Common/UI_common_GameScreenBase.dart';
import 'package:sosaku/NowLoading/Manager_GameManager.dart';

import '../Wrapper/wrapper_TransitionBuilders.dart';

// ignore: must_be_immutable
class NowLoadingScreen extends ConsumerWidget {
  /// NowLoading Screen will show in [_minDuration] milliseconds at least.
  static const int _minDuration = 3000; // [ms]

  final Function? process;
  final GameScreenInterface? goto;

  /// Show NowLoading Screen while processing.
  ///
  /// @param key (optional) : Flutter key.
  /// @param process : Specify processes you want to do while Now Loading Screen is appeared.
  ///                   ex) () async { await precacheImage(AssetImage("FILENAME"), context) }
  /// @param goto : Specify [Widget] you want to show after load processes finish.
  const NowLoadingScreen({Key? key, this.process, this.goto}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /***** execute load process area *****/
    /*           DO NOT ERASE!           */
    useEffect(() {
      _loadProcess(context);
      return null;
    });
    /*************************************/
    // TODO: implement build
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
    if (process != null) {
      await process!();
    } else {
      print("[info] NowLoadingScreen._loadProcess(): "
          "process == null.");
    }
    if (goto == null) {
      print("||||| goto ==> GameManager |||||");
      GameManager gameManager = GameManager();
      nextScreen = await gameManager.processing(context);
    } else {
      print("||||| goto ==> $goto |||||");
      nextScreen = goto!;
      await nextScreen.prepare(context);
    }
    var diff = ((DateTime.now().millisecondsSinceEpoch) - (startTime));
    if (diff < _minDuration) {
      await Future.delayed(Duration(milliseconds: (_minDuration - diff)));
    }
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

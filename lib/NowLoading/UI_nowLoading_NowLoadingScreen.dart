import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/NowLoading/Manager_GameManager.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';

import '../Wrapper/wrapper_TransitionBuilders.dart';

class NowLoadingScreen extends ConsumerWidget {
  /// NowLoading Screen will show in [_minDuration] milliseconds at least.
  static const int _minDuration = 3000; // [ms]

  bool _isFirstBuild = true;
  late final Function? process;
  late final Widget? goto;

  /// Show NowLoading Screen while processing.
  ///
  /// @param key (optional) : Flutter key.
  /// @param process : Specify processes you want to do while Now Loading Screen is appeared.
  ///                   ex) () async { await precacheImage(AssetImage("FILENAME"), context) }
  /// @param goto : Specify [Widget] you want to show after load processes finish.
  NowLoadingScreen({Key? key, this.process, this.goto}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /***** execute load process area *****/
    /*           DO NOT ERASE!           */
    if (_isFirstBuild) {
      _loadProcess(context);
    }
    _isFirstBuild = false;
    /*************************************/
    // TODO: implement build
    return Scaffold(
      body: LifecycleManager(
        callback: CommonLifecycleCallback(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
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
      ),
    );
  }

  Future<void> _loadProcess(BuildContext context) async {
    Widget nextScreen;
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
    }
    var diff = ((DateTime.now().millisecondsSinceEpoch) - (startTime));
    if (diff < _minDuration) {
      await Future.delayed(Duration(milliseconds: (_minDuration - diff)));
    }
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (_, __, ___) => nextScreen,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              buildFadeTransition(
                  context, animation, secondaryAnimation, child)),
    );
  }
}

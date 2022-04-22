import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NowLoadingScreen extends ConsumerWidget {
  /// NowLoading Screen will show in [_minDuration] milliseconds at least.
  static const int _minDuration = 3000; // [ms]

  bool _firstBuild = true;
  late final Function _process;
  late final ConsumerWidget _goto;

  /// Show NowLoading Screen while processing.
  ///
  /// @param key (optional) : Flutter key.
  /// @param process : Specify processes you want to do while Now Loading Screen is appeared.
  ///                   ex) () async { await precacheImage(AssetImage("FILENAME"), context) }
  /// @param goto : Specify [ConsumerWidget] you want to show after load processes finish.
  NowLoadingScreen(
      {Key? key, required Function process, required ConsumerWidget goto})
      : super(key: key) {
    _process = process;
    _goto = goto;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /***** execute load process area *****/
    /*           DO NOT ERASE!           */
    if (_firstBuild) {
      _loadProcess(_process).then((value) => Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => _goto)));
    }
    _firstBuild = false;
    /*************************************/
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/drawable/NowLoading/LoadingAnimation.gif"))),
        child: Center(
          child: Container(
              color: Colors.white, child: const Text("Now Loading...")),
        ),
      ),
    );
  }

  Future<void> _loadProcess(Function process) async {
    var startTime = DateTime.now().millisecondsSinceEpoch;
    await process();
    var diff = ((DateTime.now().millisecondsSinceEpoch) - (startTime));
    if (diff < _minDuration) {
      await Future.delayed(Duration(milliseconds: (_minDuration - diff)));
    }
  }
}

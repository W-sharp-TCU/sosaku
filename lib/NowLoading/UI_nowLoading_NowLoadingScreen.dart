import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';

class NowLoadingScreen extends ConsumerWidget {
  /// NowLoading Screen will show in [_minDuration] milliseconds at least.
  static const int _minDuration = 3000; // [ms]

  bool _isFirstBuild = true;
  late final Function? _process;
  late final ConsumerWidget _goto;

  /// Show NowLoading Screen while processing.
  ///
  /// @param key (optional) : Flutter key.
  /// @param process : Specify processes you want to do while Now Loading Screen is appeared.
  ///                   ex) () async { await precacheImage(AssetImage("FILENAME"), context) }
  /// @param goto : Specify [Widget] you want to show after load processes finish.
  NowLoadingScreen({Key? key, Function? process, ConsumerWidget? goto})
      : super(key: key) {
    if (goto != null) {
      _process = process;
      _goto = goto;
    } else {
      // GameManger()
      // todo: Functionは実行されるようにする
      // ex) セーブデータ読み込み -> GameManager()など
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /***** execute load process area *****/
    /*           DO NOT ERASE!           */
    if (_isFirstBuild) {
      _loadProcess(_process).then((value) => Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => _goto)));
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

  Future<void> _loadProcess(Function? process) async {
    var startTime = DateTime.now().millisecondsSinceEpoch;
    if (process != null) {
      await process();
    } else {
      if (kDebugMode) {
        print(
            "[WARNING] NowLoadingScreen._loadProcess(): Do nothing because variant \"process\" is null.");
      }
    }
    var diff = ((DateTime.now().millisecondsSinceEpoch) - (startTime));
    if (diff < _minDuration) {
      await Future.delayed(Duration(milliseconds: (_minDuration - diff)));
    }
  }
}

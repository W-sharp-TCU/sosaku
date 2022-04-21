import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Title/UI_title_TitleScreen.dart';

class NowLoadingScreen extends ConsumerWidget {
  bool _firstBuild = true;
  late final Function _process;
  late final ConsumerWidget _goto;

  NowLoadingScreen(
      {Key? key, required Function process, required ConsumerWidget goto})
      : super(key: key) {
    _process = process;
    _goto = goto;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (_firstBuild) {
      loadProcess(_process).then((value) => Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => _goto)));
    }
    _firstBuild = false;
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text("Now Loading..."),
      ),
    );
  }

  Future<void> loadProcess(Function process) async {
    print("Start pressing.");
    await process();
    print("End processing.");
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Common/Interface_common_GameScreenInterface.dart';
import 'package:sosaku/Title/UI_title_TitleScreen.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';
import 'package:sosaku/Wrapper/wrapper_TransitionBuilders.dart';
import 'package:sosaku/l10n/l10n.dart';

/// class AttentionScreen.
// ignore: must_be_immutable
class AttentionScreen extends HookConsumerWidget {
  AttentionScreen({Key? key}) : super(key: key);
  bool _isReadyForNext = false;
  final TitleScreen _nextScreen = const TitleScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // called once
    useEffect(() {
      _preLoad(context, _nextScreen);
    });

    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (_isReadyForNext) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) =>
                      _nextScreen,
                  transitionDuration: const Duration(milliseconds: 3500),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          buildFlashTransition(Colors.black, context, animation,
                              secondaryAnimation, child),
                ),
              );
            }
          },
          child: Center(
            child: Container(
              width: GetScreenSize.screenWidth(),
              height: GetScreenSize.screenHeight(),
              child: Center(
                child: Text(
                  L10n.of(context)!.attentionMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: GetScreenSize.screenHeight() * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _preLoad(BuildContext context, GameScreenInterface nextScreen) async {
    await nextScreen.prepare(context);
    _isReadyForNext = true;
  }

  /// pre cache image on attention screen.
  Future<void> preLoad(BuildContext context) async {
    // todo: implement or delete.
  }
}

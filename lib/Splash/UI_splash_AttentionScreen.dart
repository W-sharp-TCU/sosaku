import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Title/UI_title_TitleScreen.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';
import 'package:sosaku/Wrapper/wrapper_TransitionBuilders.dart';
import 'package:sosaku/l10n/l10n.dart';

/// class AttentionScreen.
class AttentionScreen extends ConsumerWidget {
  AttentionScreen({Key? key}) : super(key: key);
  static const String _imagePath = "./assets/drawable/Title/Lion.jpg";
  bool _isFirstBuild = true;
  bool _isReadyForNext = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    if (_isFirstBuild) {
      _preLoad(context);
      _isFirstBuild = false;
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Center(
          child: GestureDetector(
            onTap: () {
              if (_isReadyForNext) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) =>
                        TitleScreen(),
                    transitionDuration: const Duration(milliseconds: 3500),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            buildFlashTransition(Colors.black, context,
                                animation, secondaryAnimation, child),
                  ),
                );
              }
            },
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

  void _preLoad(BuildContext context) async {
    await TitleScreen.prepare(context);
    _isReadyForNext = true;
  }

  /// pre cache image on attention screen.
  static Future<void> prepare(BuildContext context) async {
    await precacheImage(const AssetImage(_imagePath), context);
  }
}

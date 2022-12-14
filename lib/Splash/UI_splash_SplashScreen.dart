import 'package:flutter/material.dart';
import 'package:sosaku/Splash/UI_splash_AttentionScreen.dart';
import 'package:sosaku/Wrapper/Functions_wrapper_TransitionBuilders.dart';

import '../Wrapper/wrapper_GetScreenSize.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  static const String _imagePath = "assets/drawable/Splash/Wsharp.png";

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    super.initState();
    _jumpTimer(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    _controller.forward();
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: SizedBox(
            width: GetScreenSize.screenWidth() / 2.4,
            height: GetScreenSize.screenHeight() / 2.4,
            child: FadeTransition(
              opacity: _animation,
              child: const Image(
                image: AssetImage(_imagePath),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _jumpTimer(BuildContext context) async {
    final AttentionScreen attentionScreen = AttentionScreen();
    await attentionScreen.preLoad(context);
    await Future.delayed(const Duration(milliseconds: 5000));
    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => attentionScreen,
      transitionDuration: const Duration(milliseconds: 1500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          buildFlashTransition(
              Colors.black, context, animation, secondaryAnimation, child),
    ));
  }
}

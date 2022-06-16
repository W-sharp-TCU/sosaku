import 'package:flutter/material.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';

/// class AttentionScreen.
class AttentionScreen extends StatelessWidget {
  const AttentionScreen({Key? key}) : super(key: key);
  static String _imagePath = "./assets/drawable/Title/Lion.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Center(
          child: GestureDetector(
            child: Container(
              width: GetScreenSize.screenWidth(),
              height: GetScreenSize.screenHeight(),
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(
                  /// change image.
                  _imagePath,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// pre cache image on attention screen.
  static Future<void> prepare(BuildContext context) async {
    await precacheImage(AssetImage(_imagePath), context);
  }
}

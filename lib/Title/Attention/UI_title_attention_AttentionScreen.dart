import 'package:flutter/material.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';


/// class AttentionScreen.
class AttentionScreen extends StatelessWidget {
  const AttentionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height:double.infinity,
        color: Colors.black,
        child: Center(
          child: GestureDetector(
            child: Container(
              width: GetScreenSize.screenWidth(),
              height: GetScreenSize.screenHeight(),
              color: Colors.amber,
              child: const Image(
                fit: BoxFit.cover,
                image: AssetImage(
                  "./assets/drawable/Title/Lion.jpg",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
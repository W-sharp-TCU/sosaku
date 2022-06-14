import 'package:flutter/material.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';


/// class SelectActionScreen.
class SelectActionScreen extends StatelessWidget {
  const SelectActionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Center(
          child: Container(
            width: GetScreenSize.screenWidth(),
            height: GetScreenSize.screenHeight(),
            child: Stack(
              children: const <Widget>[
                Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    "./assets/drawable/Ttile/Lion.jpg",
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
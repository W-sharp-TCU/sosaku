import 'package:flutter/material.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';

class Button extends StatelessWidget {
  Button({Key? key, required this.buttonName}) : super(key: key);
  String buttonName;

  @override
  Widget build(BuildContext context) {
    GetScreenSize.setSize(
      MediaQuery.of(context).size.height, MediaQuery.of(context).size.width
    );

    return Container(
      color: Colors.white.withOpacity(0.5), //画像を用意したら消す
      width: GetScreenSize.screenWidth() * 0.3,
      height: GetScreenSize.screenHeight() * 0.1,
      child: Stack(
        children: <Widget>[
          /// asset background screen without image path.
          ///
          /// Image(
          ///   image: AssetImage(""),
          /// ),
          ///
          Center(
            child: Text(
              buttonName,
              style: TextStyle(
                fontSize: GetScreenSize.screenHeight() * 0.05,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

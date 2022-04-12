import 'package:flutter/material.dart';

/// wrapper import
import '../Wrapper/wrapper_GetScreenSize.dart';


class Button extends StatelessWidget {
  Button({Key? key, required this.buttonName}) : super(key: key);
  String buttonName;

  @override
  Widget build(BuildContext context) {
    GetScreenSize.setSize(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Container(
      color: Colors.red,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            /// asset background screen without image path.
            ///
            /// Image(
              /// image: AssetImage(""),
            /// ),
            ///
            Text(
              buttonName,
              style: TextStyle(
                fontSize: GetScreenSize.screenHeight() * 0.1,
              ),
            ),
          ],
        ),
        onTap: (){
          /// set function when pressed.
          print("pudhed");
        },
      ),
    );
  }
}
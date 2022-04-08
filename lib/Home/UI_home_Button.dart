import 'package:flutter/material.dart';


class Button extends StatelessWidget {
  Button({Key? key, required this.buttonName}) : super(key: key);
  String buttonName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            /* asset background screen without image path */
            /*
            Image(
              image: AssetImage(""),
            ),
            */
            Text(
              buttonName,
              style: TextStyle(
                fontSize: 90,
              ),
            ),
          ],
        ),
        onTap: (){
          /* set function when pressed */
          print("pudhed");
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';

/// wrapper import
import '../Wrapper/wrapper_GetScreenSize.dart';
/// widget files import
import 'UI_home_Button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetScreenSize.setSize(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Center(
          child: Container(
            height: GetScreenSize.screenHeight(),
            width: GetScreenSize.screenWidth(),
            color: Colors.grey, /* delete it when you set asset path */
            child: Stack(
              children: <Widget>[
                /// asset background screen without image path.
                ///
                /// Image(
                  /// image: AssetImage(""),
                /// ),
                ///

                /// widget button 1
                Align(
                  alignment: const Alignment(0.7, 0.20),
                  child: Button(buttonName: "button_1"),
                ),

                /// widget button 2
                Align(
                  alignment: const Alignment(0.7, 0.50),
                  child: Button(buttonName: "button_2"),
                ),

                /// widget button 3
                Align(
                  alignment: const Alignment(0.7, 0.80),
                  child: Button(buttonName: "button_3"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'wraper_GetScreenSize.dart';

class TitleScreen extends StatelessWidget{
  const TitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    GetScreenSize.setSize
      (MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Center(
          child: Container(
            height: GetScreenSize.screenHeight(),
            width: GetScreenSize.screenWidth(),
            color: Colors.green,
            child: Text("背景画像"),
          ),
        )
      )
    );
  }
}
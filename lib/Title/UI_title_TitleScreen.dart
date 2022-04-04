import 'package:flutter/material.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';

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
          child: GestureDetector(
            onTap: (){
              //画面遷移の処理を書く
              print("tap");//デバッグ用
            },
            child: Container(
              height: GetScreenSize.screenHeight(),
              width: GetScreenSize.screenWidth(),
              color: Colors.green,
              child: Stack(
                children: [
                  Align(
                    alignment: const Alignment(0, 0.8),
                    child: Container(
                      height: GetScreenSize.screenHeight() * 0.2,
                      width: GetScreenSize.screenWidth() * 0.8,
                      color: Colors.red,
                    ),
                  ),

                ],
              )
            ),
          ),
        )
      )
    );
  }
}
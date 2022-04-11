import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sosaku/Title/Provider_title_TitleScreenProvider.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';

class TitleScreen extends StatelessWidget{
  const TitleScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context){

    GetScreenSize.setSize
      (MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    var a = context.watch<TitleScreenProvider>();
    a.start(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: Center(
          child: GestureDetector(
            onTap: (){
              //画面遷移の処理を書く
              a.stop();
              //Provider.of<TitleScreenProvider>(context).setImage()
              //print("tap");//デバッグ用
            },
            child: Container(
              //height: GetScreenSize.screenHeight(),
              //width: GetScreenSize.screenWidth(),
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(a.mBGImagePath))),
                /*decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("drawable/Title/Ocean.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),*/
              //color: Colors.black,
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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import '../Home/UI_home_HomeScreen.dart';

class ConversationScreen extends StatelessWidget{
  const ConversationScreen({Key? key}) : super(key: key);

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
                color: Colors.black,
                child: Stack(
                  children: [

                    Image(
                    fit: BoxFit.cover,
                    image:AssetImage(),
                    ),

                    Align(
                      alignment: const Alignment(0, 1),
                      child: Container(
                        height: GetScreenSize.screenHeight() * 0.5,
                        child: Image(
                          fit: BoxFit.cover,
                          image:AssetImage(),
                        )
                      )
                    ),

                    Align(
                      alignment: const Alignment(0, 1),
                      child: GestureDetector(
                        onTap: (){
                          print("tap");
                        },
                        child: Container(
                          height: GetScreenSize.screenHeight() * 0.2,
                          child: Image(
                            fit: BoxFit.cover,
                            image:AssetImage(),
                            )
                        ),
                      )
                    )
                  ],
                )
              ),

            )
        )
    );
  }
}
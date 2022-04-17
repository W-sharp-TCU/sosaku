import 'package:flutter/material.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import '../Home/UI_home_HomeScreen.dart';
import 'UI_load_SelectLoadFile.dart';

class LoadScreen extends StatelessWidget{
  const LoadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GetScreenSize.setSize(
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width
    );

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
            child: Stack(
              children: [

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for(var i = 0; i < 10; i++)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            for(var j = 0; j < 2; j++)
                              SelectLoadFile(i, j)
                          ],
                        )
                    ],
                  )
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen())
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right:GetScreenSize.screenWidth() * 0.02,
                            top:GetScreenSize.screenWidth() * 0.02),
                        width: GetScreenSize.screenWidth() * 0.07,
                        height: GetScreenSize.screenWidth() * 0.1,
                        color: Colors.white,
                        child: const Center(
                          child: Text("back"),
                        )
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top:GetScreenSize.screenWidth() * 0.02),
                      width: GetScreenSize.screenWidth() * 0.3,
                      height: GetScreenSize.screenWidth() * 0.1,
                      color: Colors.white,
                      child: const Center(
                        child: Text("File Select Text"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
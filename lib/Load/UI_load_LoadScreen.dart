import 'package:flutter/material.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';

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

                Align(
                  alignment: const Alignment(0, 0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for(var i = 0; i < 10; i++)
                          Container(
                            height: GetScreenSize.screenHeight() * 0.3,
                            width: GetScreenSize.screenWidth() * 0.3,
                            color: i.isEven ? Colors.blue : Colors.pink,
                            padding: EdgeInsets.all(GetScreenSize.screenWidth() * 0.05),
                          )
                      ],
                    )
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

import 'package:flutter/material.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';

class SelectLoadFile extends StatelessWidget{
  const SelectLoadFile(this.i, this.j, {Key? key}) : super(key: key);
  final int i,j;

  @override
  Widget build(BuildContext context) {

    GetScreenSize.setSize(
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width
    );

    int fileNumber = i * 2 + j;

    return GestureDetector(
      onTap:(){
        print("you tapped File$fileNumber");
      },
      child: Container(
          height: GetScreenSize.screenHeight() * 0.3,
          width: GetScreenSize.screenWidth() * 0.35,
          color: Colors.white,
          margin: EdgeInsets.only(bottom:GetScreenSize.screenWidth() * 0.03,
              left: GetScreenSize.screenWidth() * 0.01, right: GetScreenSize.screenWidth() * 0.01),
          padding: EdgeInsets.all(GetScreenSize.screenWidth() * 0.005),

          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("File$fileNumber"),
            ],
          )
      ),
    );
  }
}
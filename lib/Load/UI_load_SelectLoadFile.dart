///package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_load_LoadScreen.dart';

class SelectLoadFile extends ConsumerWidget{
  const SelectLoadFile(this.i, this.j, {Key? key}) : super(key: key);
  final int i,j;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
          margin: EdgeInsets.only(
              bottom:GetScreenSize.screenWidth() * 0.03,
              left: GetScreenSize.screenWidth() * 0.01,
              right: GetScreenSize.screenWidth() * 0.01
          ),
          padding: EdgeInsets.all(
              GetScreenSize.screenWidth() * 0.005
          ),

          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("File$fileNumber"),
              Text(ref.watch(loadScreenProvider).fileImagePaths[i]),
              Text(ref.watch(loadScreenProvider).mBGImagePath)
            ],
          )
      ),
    );
  }
}
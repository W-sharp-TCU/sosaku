///package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_load_LoadScreen.dart';

class SelectLoadFile extends ConsumerWidget{
  const SelectLoadFile(this.i, {Key? key}) : super(key: key);
  final int i;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    GetScreenSize.setSize(
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width
    );

    int fileNumber = i;

    return GestureDetector(
      onTap:(){
        print("you tapped File$fileNumber");
      },
      child: Container(
        width: GetScreenSize.screenWidth() * 0.7,
        height: GetScreenSize.screenHeight() * 0.4,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
        ),
        margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.02),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(-0.95, 0),
              child: Container(
                width: GetScreenSize.screenWidth() * 0.35,
                height: GetScreenSize.screenHeight() * 0.35,
                color: Colors.white,
              ),
            ),

            Align(
              alignment: const Alignment(0.95, 0),
              child: Container(
                width: GetScreenSize.screenWidth() * 0.3,
                height: GetScreenSize.screenHeight() * 0.35,
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      "ファイル$fileNumber",
                      style: TextStyle(
                        fontSize: GetScreenSize.screenHeight() * 0.05,
                      ),
                    )
                  ],
                )

              )
            )
          ],
        )
      ),
    );
  }
}
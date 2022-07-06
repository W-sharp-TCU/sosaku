///package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ファイル$fileNumber",
                      style: TextStyle(
                        fontSize: GetScreenSize.screenHeight() * 0.05,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "chap3-1",
                          style: TextStyle(
                            fontSize: GetScreenSize.screenHeight() * 0.04,
                            color: Colors.lightBlue,
                          ),
                        ),

                        Text(
                          "2022/5/30 20:00",
                          style: TextStyle(
                            fontSize: GetScreenSize.screenHeight() * 0.045,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Text(
                      "~comments~",
                      style: TextStyle(
                        fontSize: GetScreenSize.screenHeight() * 0.04,
                      ),
                    ),

                    Text(
                      "昔々あるところにおじいさんとおばあさんが住んでおりました。野山に"
                          "混じりて",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: GetScreenSize.screenHeight() * 0.045,
                        color: Colors.lightGreen
                      ),
                    ),

                    const Spacer(),
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
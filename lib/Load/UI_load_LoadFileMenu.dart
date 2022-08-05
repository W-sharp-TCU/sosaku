///package
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sosaku/Load/UI_load_LoadScreen.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

class LoadFileMenu extends ConsumerWidget{
  const LoadFileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width
    );

    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            ref.read(loadUIProvider).changeFlagSaveMenu();
            print(ref.watch(loadScreenProvider).selectFileNumber);
          },
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: GetScreenSize.screenHeight() * 0.01,
                  sigmaY: GetScreenSize.screenHeight() * 0.01,
                ),
                child: Container(
                  width: GetScreenSize.screenWidth(),
                  height: GetScreenSize.screenHeight(),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
        ),

        Center(
          child: Container(
            width: GetScreenSize.screenWidth() * 0.9,
            height: GetScreenSize.screenHeight() * 0.9,
            decoration:const BoxDecoration(
              color: Colors.grey,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(-0.95, -0.95),
                  child: Container(
                    width: GetScreenSize.screenWidth() * 0.3,
                    height: GetScreenSize.screenHeight() * 0.3,
                    color: Colors.white,
                  ),
                ),

                Align(
                    alignment: const Alignment(-0.95, 0.3),
                    child: Container(
                        width: GetScreenSize.screenWidth() * 0.3,
                        height: GetScreenSize.screenHeight() * 0.35,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ファイル" + ref.watch(loadScreenProvider).
                              selectFileNumber.toString(),
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
                ),

                Align(
                  alignment: const Alignment(0.95, -1),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        ///save
                        GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            width: GetScreenSize.screenWidth() * 0.5,
                            height: GetScreenSize.screenHeight() * 0.2,
                            margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.03),
                            decoration: const BoxDecoration(
                              color: Colors.lightBlue,
                            ),
                            child: Center(
                              child: Text(
                                "save",
                                style: TextStyle(
                                  fontSize: GetScreenSize.screenHeight() * 0.1,
                                ),
                              ),
                            ),
                          )
                        ),

                        GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              width: GetScreenSize.screenWidth() * 0.5,
                              height: GetScreenSize.screenHeight() * 0.2,
                              margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.03),
                              decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                              ),
                              child: Center(
                                child: Text(
                                  "load",
                                  style: TextStyle(
                                    fontSize: GetScreenSize.screenHeight() * 0.1,
                                  ),
                                ),
                              ),
                            )
                        ),

                        GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              width: GetScreenSize.screenWidth() * 0.5,
                              height: GetScreenSize.screenHeight() * 0.2,
                              margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.03),
                              decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                              ),
                              child: Center(
                                child: Text(
                                  "copy",
                                  style: TextStyle(
                                    fontSize: GetScreenSize.screenHeight() * 0.1,
                                  ),
                                ),
                              ),
                            )
                        ),

                        GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              width: GetScreenSize.screenWidth() * 0.5,
                              height: GetScreenSize.screenHeight() * 0.2,
                              margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.03),
                              decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                              ),
                              child: Center(
                                child: Text(
                                  "delete",
                                  style: TextStyle(
                                    fontSize: GetScreenSize.screenHeight() * 0.1,
                                  ),
                                ),
                              ),
                            )
                        ),

                        GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              width: GetScreenSize.screenWidth() * 0.5,
                              height: GetScreenSize.screenHeight() * 0.2,
                              margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.03),
                              decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                              ),
                              child: Center(
                                child: Text(
                                  "import",
                                  style: TextStyle(
                                    fontSize: GetScreenSize.screenHeight() * 0.1,
                                  ),
                                ),
                              ),
                            )
                        ),

                        GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              width: GetScreenSize.screenWidth() * 0.5,
                              height: GetScreenSize.screenHeight() * 0.2,
                              margin: EdgeInsets.all(GetScreenSize.screenHeight() * 0.03),
                              decoration: const BoxDecoration(
                                color: Colors.lightBlue,
                              ),
                              child: Center(
                                child: Text(
                                  "export",
                                  style: TextStyle(
                                    fontSize: GetScreenSize.screenHeight() * 0.1,
                                  ),
                                ),
                              ),
                            )
                        ),


                      ],
                    ),
                  )
                )
              ],
            )
          ),
        ),
      ],
    );
  }
}
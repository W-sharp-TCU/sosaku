///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Load/UI_load_LoadScreen.dart';
///other dart file
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Provider_Dialog_DialogProvider.dart';

final dialogProvider =
    ChangeNotifierProvider.autoDispose((ref) => DialogProvider());

class DialogScreen extends ConsumerWidget{
  const DialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return SizedBox(
      width: GetScreenSize.screenWidth(),
      height: GetScreenSize.screenHeight(),
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              ref.read(loadUIProvider).changeFlag();  ///debug
            },
            child: Container(
              width: GetScreenSize.screenWidth(),
              height: GetScreenSize.screenHeight(),
              color: Colors.black.withOpacity(0.5),

            ),
          ),

          Center(
            child: Container(
                width: GetScreenSize.screenWidth() * 0.7,
                height: GetScreenSize.screenHeight() * 0.7,
                 decoration: BoxDecoration(
                   /*
                   image: DecorationImage(
                     image: AssetImage(""),
                     fit: BoxFit.cover
                   )
                   */
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(
                       GetScreenSize.screenWidth() * 0.03
                   ),
                 ),
              /// Stack以下は仕様が決まり次第改良
              child: Stack(
                children: [

                  Align(
                    ///表示メッセージ
                    alignment: const Alignment(0, -0.7),
                    child: Text(
                        "DialogScreen",
                      style: TextStyle(
                        fontSize: GetScreenSize.screenHeight() * 0.05
                      ),
                    ),
                  ),

                  ///YES
                  Align(
                      alignment: const Alignment(-0.7, 0.7),
                      child:GestureDetector(
                        onTap: (){
                          print("pushed yes");  ///debug
                          ref.read(dialogProvider).animatedButton();
                        },
                        child: Container(
                          width: GetScreenSize.screenWidth() * 0.2 ,
                          height: GetScreenSize.screenHeight() * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(
                                GetScreenSize.screenHeight() * 0.03
                            ),
                          ),
                          child: Center(
                            child: Text(
                                "YES",
                              style: TextStyle(
                                  fontSize: GetScreenSize.screenHeight() * 0.05
                              ),
                            ),
                          ),
                        ),
                      ),
                  ),


                  ///NO
                  Align(
                      alignment: const Alignment(0.7, 0.7),
                      child:GestureDetector(
                        onTap: (){
                          print("pushed no");  ///debug
                        },
                        child: Container(
                          width: GetScreenSize.screenWidth() * 0.2,
                          height: GetScreenSize.screenHeight() * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(
                                GetScreenSize.screenHeight() * 0.03
                            ),
                          ),
                          child: Center(
                            child: Text(
                                "NO",
                              style: TextStyle(
                                  fontSize: GetScreenSize.screenHeight() * 0.05
                              ),
                            ),
                          ),
                        ),
                      )
                  ),

                ],
              )
            ),
          )
        ],
      ),
    );
  }
}


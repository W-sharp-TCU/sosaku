///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Load/UI_load_LoadScreen.dart';
///other dart file
import '../Wrapper/wrapper_GetScreenSize.dart';

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
                color: Colors.white,  ///need to delete when ImagePaths are written
                /*イメージパスが来たときよう
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage(""),
                     fit: BoxFit.cover
                   )
                 ),
                 */
              /// Stack以下は仕様が決まり次第改良
              child: Stack(
                children: [

                  const Align(
                    ///表示メッセージ
                    alignment: Alignment(0, -0.7),
                    child: Text("DialogScreen"),
                  ),

                  ///YES
                  Align(
                      alignment: const Alignment(-0.7, 0.7),
                      child: Container(
                        width: GetScreenSize.screenWidth() * 0.2,
                        height: GetScreenSize.screenHeight() * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        //  borderRadius: BorderRadius.circular(GetScreenSize.screenWidth() * 0.1),
                          image: const DecorationImage(
                            image: AssetImage('assets/drawable/Title/Lion.jpg'),
                            fit: BoxFit.cover,
                          ),
                          
                        ),

                        child: Material(
                          color:Colors.transparent,
                          child: InkWell(
                            onTap: (){
                              print("yes tap");
                            },
                          ),
                        )

                      )
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
                          color: Colors.blueAccent,
                          child: const Center(
                            child: Text(
                                "NO"
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


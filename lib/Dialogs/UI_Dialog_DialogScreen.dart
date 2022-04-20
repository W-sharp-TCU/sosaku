///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Load/UI_load_LoadScreen.dart';
///other dart file
import '../Wrapper/wrapper_GetScreenSize.dart';
import '../Load/Provider_load_LoadUIProvider.dart';

class DialogScreen extends ConsumerWidget{
  const DialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: GetScreenSize.screenWidth(),
      height: GetScreenSize.screenHeight(),
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              ref.read(loadUIProvider).changeFlag();
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
                color: Colors.white,  ///image入れたら消す
                /*イメージパスが来たときよう
                 decoration: BoxDecoration(
                   image: DecorationImage(
                     image: AssetImage(""),
                     fit: BoxFit.cover
                   )
                 ),
                 */
              child: Stack(
                children: [

                  Align(
                      alignment: const Alignment(-0.7, 0.7),
                      child: Container(
                        width: GetScreenSize.screenWidth() * 0.2,
                        height: GetScreenSize.screenHeight() * 0.2,
                        color: Colors.redAccent,
                        child: const Center(
                          child: Text(
                              "yes"
                          ),
                        ),
                      )
                  ),

                  Align(
                      alignment: const Alignment(0.7, 0.7),
                      child: Container(
                        width: GetScreenSize.screenWidth() * 0.2,
                        height: GetScreenSize.screenHeight() * 0.2,
                        color: Colors.blueAccent,
                        child: const Center(
                          child: Text(
                              "no"
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


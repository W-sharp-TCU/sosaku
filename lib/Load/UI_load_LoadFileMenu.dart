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
          child: Container(
            width: GetScreenSize.screenWidth(),
            height: GetScreenSize.screenHeight(),
            color: Colors.transparent,
          ),
        ),

        Center(
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: GetScreenSize.screenHeight() * 0.01,
                sigmaY: GetScreenSize.screenHeight() * 0.01,
              ),
              child: Container(
                width: GetScreenSize.screenWidth() * 0.9,
                height: GetScreenSize.screenHeight() * 0.9,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.white,
                    width: GetScreenSize.screenWidth() * 0.003,
                  ),
                ),
                child: Stack(
                  children: [

                  ],
                )
              ),
            ),
          ),
        ),
      ],
    );
  }
}
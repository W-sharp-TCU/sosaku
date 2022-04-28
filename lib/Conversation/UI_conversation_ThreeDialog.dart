///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_conversation_ConversationScreen.dart';

class ThreeDialog extends ConsumerWidget{
  const ThreeDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Container(
      width: GetScreenSize.screenWidth(),
      height: GetScreenSize.screenHeight(),
      color: Colors.black.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          ///first
          GestureDetector(
            onTap:(){
              // ref.read(conversationScreenProvider).changeDialogFlag();
            },

            child: Container(
              width: GetScreenSize.screenWidth() * 0.6,
              height: GetScreenSize.screenHeight() * 0.15,
              margin: EdgeInsets.only(
                top: GetScreenSize.screenHeight() * 0.1,
              ),
              color: Colors.white,
              child: Center(
                child: Text(
                  "tentative",
                  style: TextStyle(
                    fontSize: GetScreenSize.screenHeight() * 0.04
                  ),
                ),
              )
            ),
          ),

          ///second
          GestureDetector(
            onTap:(){

            },

            child: Container(
              width: GetScreenSize.screenWidth() * 0.6,
              height: GetScreenSize.screenHeight() * 0.15,
              margin: EdgeInsets.only(
                top: GetScreenSize.screenHeight() * 0.1,
              ),
              color: Colors.white,
              child: Center(
                child: Text(
                  "tentative",
                  style: TextStyle(
                      fontSize: GetScreenSize.screenHeight() * 0.04
                  ),
                ),
              )
            ),
          ),

          ///third
          GestureDetector(
            onTap:(){

            },

            child: Container(
              width: GetScreenSize.screenWidth() * 0.6,
              height: GetScreenSize.screenHeight() * 0.15,
              margin: EdgeInsets.only(
                top: GetScreenSize.screenHeight() * 0.1,
              ),
              color: Colors.white,
              child: Center(
                child: Text(
                  "tentative",
                  style: TextStyle(
                      fontSize: GetScreenSize.screenHeight() * 0.04
                  ),
                ),
              )
            ),
          ),
        ],
      )
    );

  }
}
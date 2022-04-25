import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Conversation/Contoroller_conversation_ConversationScreen.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Provider_conversation_ConversationImage.dart';
import 'Provider_conversation_ConversationText.dart';

final conversationTextProvider =
    ChangeNotifierProvider.autoDispose((ref) => ConversationTextProvider());
final conversationImageProvider =
    ChangeNotifierProvider.autoDispose((ref) => ConversationImageProvider());
final ConversationScreenController conversationScreenController =
    ConversationScreenController();

class ConversationScreen extends ConsumerWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    ConversationImageProvider cip = ref.watch(conversationImageProvider);
    ConversationTextProvider ctp = ref.watch(conversationTextProvider);
    conversationScreenController.start(cip, ctp);
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: GestureDetector(
          onTap: () {
            conversationScreenController.nextScene();
          },
          child: Container(
            height: GetScreenSize.screenHeight(),
            width: GetScreenSize.screenWidth(),
            color: Colors.black,
            child: Stack(
              children: [
                //背景の画像が上がり次第利用　それまではcontainerで代用
                Image(
                  height: GetScreenSize.screenHeight(),
                  width: GetScreenSize.screenWidth(),
                  fit: BoxFit.cover,
                  image: AssetImage(
                      ref.watch(conversationImageProvider).mBGImagePath),
                ),

                //背景代用container
                // Container(
                //   height: GetScreenSize.screenHeight(),
                //   width: GetScreenSize.screenWidth(),
                //   color: Colors.green,
                // ),

                Align(
                    alignment: const Alignment(0, 1),
                    child: Container(
                        height: GetScreenSize.screenHeight() * 0.7,
                        width: GetScreenSize.screenWidth() * 0.5,
                        // color: Colors.pink, //画像を用意したら消す
                        child: Image(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(ref
                              .watch(conversationImageProvider)
                              .characterImagePath),
                        ))),

                Align(
                  alignment: const Alignment(0, 1),
                  child: GestureDetector(
                    onTap: () {
                      print("tap");
                    },
                    child: Container(
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white.withOpacity(0.5), //画像を用意したら消す
                      padding: EdgeInsets.all(
                        GetScreenSize.screenWidth() * 0.005,
                      ),
                      child: Stack(
                        children: [
                          /* ここでImage置くより上のContainerでdecorationしたほうがいいかもね
                          Image(
                            fit: BoxFit.cover,
                            image:AssetImage(),
                          ),
                          */

                          Align(
                            alignment: const Alignment(-1, -1),
                            child: Text(
                              ref
                                  .watch(conversationTextProvider)
                                  .conversationText,
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Contoroller_conversation_ConversationScreen.dart';
import 'Provider_conversation_ConversationImage.dart';
import 'Provider_conversation_ConversationText.dart';
import 'UI_conversation_ThreeDialog.dart';

final conversationImageProvider =
    ChangeNotifierProvider.autoDispose((ref) => ConversationImageProvider());
final conversationTextProvider =
    ChangeNotifierProvider.autoDispose((ref) => ConversationTextProvider());
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
        child: Container(
          height: GetScreenSize.screenHeight(),
          width: GetScreenSize.screenWidth(),
          color: Colors.black,
          child: Stack(
            children: [
              ///BGImage
              Container(
                width: GetScreenSize.screenWidth(),
                height: GetScreenSize.screenHeight(),
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      ref.watch(conversationImageProvider).mBGImagePath),
                ),
              ),

              ///character
              Align(
                  alignment: const Alignment(0, 1),
                  child: SizedBox(
                      height: GetScreenSize.screenHeight() * 0.7,
                      width: GetScreenSize.screenWidth() * 0.5,
                      child: Image(
                        fit: BoxFit.fitHeight,
                        image: AssetImage(
                          ref
                              .watch(conversationImageProvider)
                              .characterImagePath,
                        ),
                      ))),

              ///upper Widgets
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        width: GetScreenSize.screenWidth() * 0.05,
                        height: GetScreenSize.screenWidth() * 0.05,
                        margin:
                            EdgeInsets.all(GetScreenSize.screenHeight() * 0.02),
                        color: Colors.red.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            "UI",
                            style: TextStyle(
                              fontSize: GetScreenSize.screenHeight() * 0.04,
                            ),
                          ),
                        )),
                  ),
                ],
              ),

              ///3 choices dialog
              if (ref.watch(conversationImageProvider).dialogFlag)
                const Align(
                  alignment: Alignment(0, 0),
                  child: ThreeDialog(),
                ),

              ///below Widgets
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///character name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: GetScreenSize.screenHeight() * 0.05,
                        width: GetScreenSize.screenWidth() * 0.1,
                        color: Colors.white.withOpacity(0.5),
                        padding:
                            EdgeInsets.all(GetScreenSize.screenWidth() * 0.005),
                        child: Center(
                          child: Text(
                            ///initをproviderに書き換える
                            "init",
                            style: TextStyle(
                              fontSize: GetScreenSize.screenHeight() * 0.04,
                            ),
                          ),
                        ),
                      ),

                      ///auto button, log button
                      Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              height: GetScreenSize.screenHeight() * 0.05,
                              width: GetScreenSize.screenWidth() * 0.1,
                              color: Colors.red.withOpacity(0.5),
                              child: Center(
                                child: Text(
                                  "Auto",
                                  style: TextStyle(
                                    fontSize:
                                        GetScreenSize.screenHeight() * 0.04,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: GetScreenSize.screenWidth() * 0.05),
                              height: GetScreenSize.screenHeight() * 0.05,
                              width: GetScreenSize.screenWidth() * 0.1,
                              color: Colors.red.withOpacity(0.5),
                              child: Center(
                                child: Text(
                                  "Log",
                                  style: TextStyle(
                                    fontSize:
                                        GetScreenSize.screenHeight() * 0.04,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  ///text zone
                  GestureDetector(
                    onTap: () {
                      conversationScreenController.goNextScene();
                      print("tap");
                    },
                    child: Container(
                      height: GetScreenSize.screenHeight() * 0.2,
                      width: GetScreenSize.screenWidth(),
                      color: Colors.white.withOpacity(0.5), //画像を用意したら消す
                      padding: EdgeInsets.all(
                        GetScreenSize.screenWidth() * 0.005,
                      ),

                      child: Align(
                        alignment: const Alignment(-1, -1),
                        child: Text(
                          ref.watch(conversationTextProvider).conversationText,
                          style: TextStyle(
                            fontSize: GetScreenSize.screenHeight() * 0.04,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              ///unable text zone tap
              ///don't erase
              if (ref.watch(conversationImageProvider).dialogFlag)
                Align(
                  alignment: const Alignment(0, 1),
                  child: Container(
                    height: GetScreenSize.screenHeight() * 0.25,
                    width: GetScreenSize.screenWidth(),
                    color: Colors.white.withOpacity(0),

                    ///debug
                  ),
                )
            ],
          ),
        ),
      ),
    ));
  }
}

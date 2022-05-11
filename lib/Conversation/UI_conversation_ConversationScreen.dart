import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationLogProvider.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';
import '../Wrapper/wrapper_AnimationButton.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Contoroller_conversation_ConversationScreen.dart';
import 'Provider_conversation_ConversationImage.dart';
import 'Provider_conversation_ConversationText.dart';
import 'UI_conversation_ThreeDialog.dart';
import 'UI_conversation_LogUI.dart';

final conversationImageProvider =
    ChangeNotifierProvider.autoDispose((ref) => ConversationImageProvider());
final conversationTextProvider =
    ChangeNotifierProvider.autoDispose((ref) => ConversationTextProvider());
final conversationLogProvider =
    ChangeNotifierProvider.autoDispose((ref) => ConversationLogProvider());

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
    ConversationLogProvider clp = ref.watch(conversationLogProvider);
    conversationScreenController.start(cip, ctp, clp);

    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: LifecycleManager(
        callback: CommonLifecycleCallback(),
        child: Center(
          child: Container(
            height: GetScreenSize.screenHeight(),
            width: GetScreenSize.screenWidth(),
            color: Colors.black,
            child: Stack(
              children: [
                ///BGImage
                SizedBox(
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
                        height: GetScreenSize.screenHeight() * 1,
                        width: GetScreenSize.screenWidth() * 0.5,
                        child: Image(
                          fit: BoxFit.fitHeight,
                          image: AssetImage(
                            ref
                                .watch(conversationImageProvider)
                                .characterImagePath,
                          ),
                        ))),

                if (ref.watch(conversationImageProvider).isDim)
                  Container(
                    width: GetScreenSize.screenWidth(),
                    height: GetScreenSize.screenHeight(),
                    color: Colors.black.withOpacity(0.5),
                  ),

                ///below Widgets
                if (!ref.watch(conversationImageProvider).isHideUi)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///character name
                      Container(
                        height: GetScreenSize.screenHeight() * 0.08,
                        width: GetScreenSize.screenWidth() * 0.15,
                        color: Colors.white.withOpacity(0.5),
                        padding:
                            EdgeInsets.all(GetScreenSize.screenWidth() * 0.005),
                        child: Center(
                          child: Text(
                            ///initをproviderに書き換える
                            ref.watch(conversationImageProvider).characterName,
                            style: TextStyle(
                              fontSize: GetScreenSize.screenHeight() * 0.04,
                            ),
                          ),
                        ),
                      ),

                      ///text zone
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: GetScreenSize.screenHeight() * 0.25,
                          width: GetScreenSize.screenWidth(),
                          color: Colors.white.withOpacity(0.5), //画像を用意したら消す
                          padding: EdgeInsets.only(
                            top: GetScreenSize.screenWidth() * 0.01,
                            left: GetScreenSize.screenWidth() * 0.01,
                            right: GetScreenSize.screenWidth() * 0.01,
                            bottom: GetScreenSize.screenWidth() * 0.02,
                          ),

                          child: Align(
                            alignment: const Alignment(-1, -1),
                            child: Text(
                              ref
                                  .watch(conversationTextProvider)
                                  .conversationText,
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.045,
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ///tap to next screen
                GestureDetector(
                  onTap: () {
                    conversationScreenController.goNextScene();
                  },
                  child: Container(
                    width: GetScreenSize.screenWidth(),
                    height: GetScreenSize.screenHeight(),
                    color: Colors.blueAccent.withOpacity(0),
                  ),
                ),

                ///3 choices dialog
                if (ref.watch(conversationImageProvider).dialogFlag &&
                    !ref.watch(conversationImageProvider).isHideUi)
                  const Align(
                    alignment: Alignment(0, 0),
                    child: ThreeDialog(),
                  ),

                ///Log screen
                if (ref.watch(conversationImageProvider).isLog)
                  Align(
                    alignment: const Alignment(0, 0),
                    child: LogUI(),
                  ),

                ///side Widgets
                if (!ref.watch(conversationImageProvider).isHideUi)
                  SizedBox(
                    width: GetScreenSize.screenWidth(),
                    height: GetScreenSize.screenHeight(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ///menu
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              width: GetScreenSize.screenWidth() * 0.05,
                              height: GetScreenSize.screenWidth() * 0.05,
                              margin: EdgeInsets.all(
                                  GetScreenSize.screenHeight() * 0.02),
                              color: Colors.red.withOpacity(0.5),
                              child: Center(
                                child: Text(
                                  "三",
                                  style: TextStyle(
                                    fontSize:
                                        GetScreenSize.screenHeight() * 0.04,
                                  ),
                                ),
                              )),
                        ),

                        ///UI appear
                        GestureDetector(
                          onTap: () {
                            conversationScreenController.changeHideUi();
                          },
                          child: Container(
                              width: GetScreenSize.screenWidth() * 0.05,
                              height: GetScreenSize.screenWidth() * 0.05,
                              margin: EdgeInsets.all(
                                  GetScreenSize.screenHeight() * 0.02),
                              color: Colors.red.withOpacity(0.5),
                              child: Center(
                                child: Text(
                                  "UI",
                                  style: TextStyle(
                                    fontSize:
                                        GetScreenSize.screenHeight() * 0.04,
                                  ),
                                ),
                              )),
                        ),

                        AnimationButton(
                          id: "buttonAuto",
                          onTap: () {
                            conversationScreenController.changeAutoPlay();
                          },
                          width: GetScreenSize.screenWidth() * 0.07,
                          height: GetScreenSize.screenWidth() * 0.07,
                          margin: 0,
                          text: (ref.watch(conversationImageProvider).isAuto
                              ? '■'
                              : '▶'),
                          textStyle: TextStyle(
                              fontSize: GetScreenSize.screenWidth() * 0.04,
                              color: Colors.pinkAccent),
                          image:
                              "assets/drawable/Conversation/button_sample.png",
                          color: Colors.white,
                          opacity: 0,
                          ratio: 1.1,
                          duration: 64,
                        ),

                        const Spacer(),

                        ///auto button
                        GestureDetector(
                          onTap: () {
                            conversationScreenController.changeAutoPlay();
                          },
                          child: Container(
                            height: GetScreenSize.screenHeight() * 0.05,
                            width: GetScreenSize.screenWidth() * 0.1,
                            color: Colors.red.withOpacity(0.5),
                            margin: EdgeInsets.all(
                                GetScreenSize.screenHeight() * 0.02),
                            child: Center(
                              child: Text(
                                "Auto",
                                style: TextStyle(
                                  fontSize: GetScreenSize.screenHeight() * 0.02,
                                ),
                              ),
                            ),
                          ),
                        ),

                        ///Log button
                        GestureDetector(
                          onTap: () {
                            conversationScreenController.openLog();
                          },
                          child: Container(
                            height: GetScreenSize.screenHeight() * 0.05,
                            width: GetScreenSize.screenWidth() * 0.1,
                            color: Colors.red.withOpacity(0.5),
                            margin: EdgeInsets.all(
                                GetScreenSize.screenHeight() * 0.02),
                            child: Center(
                              child: Text(
                                "Log",
                                style: TextStyle(
                                  fontSize: GetScreenSize.screenHeight() * 0.02,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Spacer(),
                      ],
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

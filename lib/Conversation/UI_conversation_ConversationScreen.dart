import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationLogProvider.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Contoroller_conversation_ConversationScreenController.dart';
import 'Provider_conversation_ConversationImageProvider.dart';
import 'Provider_conversation_ConversationTextProvider.dart';
import 'UI_conversation_ThreeDialog.dart';
import 'UI_conversation_LogUI.dart';
import 'UI_conversation_MenuUI.dart';
import 'UI_conversation_BelowUIs.dart';
import 'UI_conversation_SideUIs.dart';

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
                      ),
                    ),
                  ),

                  if (ref.watch(conversationImageProvider).isDim)
                    Container(
                        width: GetScreenSize.screenWidth(),
                        height: GetScreenSize.screenHeight(),
                        color: Colors.black.withOpacity(0.5)),

                  ///below Widgets(text zone,chara name)
                  if (!ref.watch(conversationImageProvider).isHideUi)
                    const BelowUIs(),

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

                  ///Menu screen
                  //if文おねがいします
                  if (false)
                    const Align(
                      alignment: Alignment(0, 0),
                      child: MenuUI(),
                    ),

                  ///side Widgets
                  if (!ref.watch(conversationImageProvider).isHideUi)
                    const Align(
                      alignment: Alignment(1, 0),
                      child: SideUIs(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Common/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Common/Interface_common_GameScreenInterface.dart';
import 'package:sosaku/Common/UI_common_GameScreenBase.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationLogProvider.dart';
import 'package:sosaku/Conversation/UI_conversation_CharactersUI.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';
import '../Wrapper/wrapper_AnimationWidget.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Controller_conversation_ConversationScreenController.dart';
import 'Provider_conversation_ConversationImageProvider.dart';
import 'Provider_conversation_ConversationTextProvider.dart';
import 'UI_conversation_SelectionsUI.dart';
import 'UI_conversation_ThreeDialog.dart';
import 'UI_conversation_LogUI.dart';
import 'UI_conversation_MenuUI.dart';
import 'UI_conversation_BelowUIs.dart';
import 'UI_conversation_SideUIs.dart';
import 'UI_conversation_Triangle.dart';

final conversationImageProvider =
    ChangeNotifierProvider.autoDispose((ref) => ConversationImageProvider());
final conversationTextProvider =
    ChangeNotifierProvider.autoDispose((ref) => ConversationTextProvider());
final conversationLogProvider =
    ChangeNotifierProvider.autoDispose((ref) => ConversationLogProvider());

final ConversationScreenController conversationScreenController =
    ConversationScreenController();

class ConversationScreen extends HookConsumerWidget
    implements GameScreenInterface {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    ConversationImageProvider cip = ref.watch(conversationImageProvider);
    ConversationTextProvider ctp = ref.watch(conversationTextProvider);
    ConversationLogProvider clp = ref.watch(conversationLogProvider);
    conversationScreenController.start(cip, ctp, clp, context);
    final animationProvider =
        animationController.createProvider('conversationCharacter', {
      'height': 0,
    });

    return Scaffold(
      body: GameScreenBase(
        lifecycleCallback: const CommonLifecycleCallback(),
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
            const CharactersUI(),

            // ),

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
                conversationScreenController.tapScreen();
              },
              child: Container(
                width: GetScreenSize.screenWidth(),
                height: GetScreenSize.screenHeight(),
                color: Colors.blueAccent.withOpacity(0),
              ),
            ),

            ///3 choices dialog
            if (ref.watch(conversationImageProvider).isSelection &&
                !ref.watch(conversationImageProvider).isHideUi)
              const Align(
                alignment: Alignment(0, 0),
                // child: ThreeDialog(),
                child: SelectionsUI(),
              ),

            ///Log screen
            if (ref.watch(conversationImageProvider).isLog)
              Align(
                alignment: const Alignment(0, 0),
                child: LogUI(),
              ),

            ///Menu screen
            //if文おねがいします
            if (ref.watch(conversationImageProvider).isMenu)
              const Align(
                alignment: Alignment(0, 0),
                child: MenuUI(),
              ),

            ///side Widgets
            if (!ref.watch(conversationImageProvider).isHideUi)
              const Align(
                alignment: Alignment(1, -1),
                child: SideUIs(),
              ),

            /// triangle Animation
            if (ref.watch(conversationImageProvider).canNext &&
                !ref.watch(conversationImageProvider).isHideUi)
              const Triangle(),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> prepare(BuildContext context) async {
    // do nothing.
  }
}

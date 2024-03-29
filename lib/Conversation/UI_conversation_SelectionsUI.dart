import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Conversation/UI_conversation_ConversationScreen.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationButton.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';

class SelectionsUI extends ConsumerWidget {
  const SelectionsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    int listSize = ref.watch(conversationImageProvider).selections.length;
    final animationProvider =
        animationController.createProvider('selections', {});
    for (int i = 0; i < listSize; i++) {
      animationController.addNewStatesDouble('selections',
          {'alignment' + i.toString(): 2, 'opacity' + i.toString(): 0});
    }

    return Align(
      alignment: const Alignment(0, -0.25),
      // child: SizedBox(
      //   width: GetScreenSize.screenWidth() * 0.8,
      //   height: GetScreenSize.screenHeight() * 0.75,
      //   child: FittedBox(
      //     fit: BoxFit.none,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < listSize; i++)
            Align(
              alignment: Alignment(
                  ref
                      .watch(animationProvider)
                      .stateDouble['alignment' + i.toString()]!,
                  -1),
              child: AnimationButton(
                  key: Key('selectionButton${i.toString()}'),
                  onTap: () {
                    conversationScreenController.goSelectedScene(i);
                  },
                  width: GetScreenSize.screenWidth() * 0.6,
                  height: GetScreenSize.screenHeight() * 0.15,
                  margin:
                      EdgeInsets.only(top: GetScreenSize.screenHeight() * 0.07),
                  ratio: 1.05,
                  opacity: ref
                      .watch(animationProvider)
                      .stateDouble['opacity${i.toString()}']!,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: GetScreenSize.screenHeight() * 0.03),
                      child: Text(
                        ref.watch(conversationImageProvider).selections[i]
                            ['text'],
                      ),
                    ),
                  )),
            )
        ],
      ),
      // ),
      // )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Provider_conversation_ConversationScreen.dart';

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
                         ref.watch(conversationScreenProvider).mBGImagePath),
                   ),
                 ),

                 ///character
                 Align(
                   alignment: const Alignment(0, 1),
                   child: Container(
                     height: GetScreenSize.screenHeight() * 0.7,
                     width: GetScreenSize.screenWidth() * 0.5,
                     child: Image(
                       fit: BoxFit.fitHeight,
                       image: AssetImage(ref
                           .watch(conversationScreenProvider)
                           .characterImagePath),
                     )
                   )
                 ),

                 ///3 choices dialog
                 if(ref.watch(conversationScreenProvider).dialogFlag)
                   const Align(
                     alignment: Alignment(0, 0),
                     child: ThreeDialog(),
                   ),

                 ///text zone
                 Align(
                   alignment: const Alignment(0, 1),
                   child: Stack(
                     children: [
                       GestureDetector(
                         onTap: () {
                           provider.conversationScreenController.nextScene();
                           print("tap");
                           ref.read(conversationScreenProvider).changeDialogFlag();
                         },

                         child: Container(
                           height: GetScreenSize.screenHeight() * 0.2,
                           width: GetScreenSize.screenWidth(),
                           color: Colors.white.withOpacity(0.5), //画像を用意したら消す
                           padding: EdgeInsets.all(
                             GetScreenSize.screenWidth() * 0.005,
                           ),
                           child: Stack(
                             children: [

                               ///text
                               Align(
                                 alignment: const Alignment(-1, -1),
                                 child: Text(
                                   ref.watch(conversationScreenProvider).conversationText,
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

                     ],
                   ),
                 ),

                 ///unable text zone tap
                 ///don't erase
                 if(ref.watch(conversationScreenProvider).dialogFlag)
                   Align(
                     alignment: const Alignment(0, 1),
                     child: Container(
                       height: GetScreenSize.screenHeight() * 0.2,
                       width: GetScreenSize.screenWidth(),
                       color: Colors.white.withOpacity(0),
                     ),
                   )

               ],
             ),
            ),
        ),
      )
    );
  }
}
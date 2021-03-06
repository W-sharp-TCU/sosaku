///package
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Conversation/UI_conversation_ConversationScreen.dart';
import 'package:sosaku/Menu/Provider_menu_MenuScreenProvider.dart';

import '../Menu/Controller_menu_MenuController.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

final menuScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => MenuScreenProvider());
final MenuScreenController menuScreenController = MenuScreenController();

class MenuUI extends ConsumerWidget {
  const MenuUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    MenuScreenProvider msp = ref.watch(menuScreenProvider);
    menuScreenController.start(msp, context);

    return SizedBox(
      width: GetScreenSize.screenWidth(),
      height: GetScreenSize.screenHeight(),
      child: Center(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: GetScreenSize.screenHeight() * 0.01,
              sigmaY: GetScreenSize.screenHeight() * 0.01,
            ),
            child: Container(
              width: GetScreenSize.screenWidth(),
              height: GetScreenSize.screenHeight(),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: Stack(
                children: [
                  ///close button
                  Align(
                    alignment: const Alignment(1, -1),
                    child: GestureDetector(
                      onTap: () {
                        conversationScreenController.openMenu();
                      },
                      child: Container(
                        width: GetScreenSize.screenWidth() * 0.05,
                        height: GetScreenSize.screenWidth() * 0.05,
                        margin:
                            EdgeInsets.all(GetScreenSize.screenHeight() * 0.02),
                        color: Colors.red.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            "??",
                            style: TextStyle(
                              fontSize: GetScreenSize.screenHeight() * 0.04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  ///right 4buttons
                  Align(
                    alignment: const Alignment(1, 1),
                    child: SizedBox(
                      width: GetScreenSize.screenWidth() * 0.4,
                      height: GetScreenSize.screenHeight() * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: GetScreenSize.screenWidth() * 0.3,
                              height: GetScreenSize.screenHeight() * 0.1,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Center(
                                child: Text(
                                  "?????????",
                                  style: TextStyle(
                                      fontSize:
                                          GetScreenSize.screenHeight() * 0.04),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              menuScreenController.openOption();
                            },
                            child: Container(
                              width: GetScreenSize.screenWidth() * 0.3,
                              height: GetScreenSize.screenHeight() * 0.1,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Center(
                                child: Text(
                                  "???????????????",
                                  style: TextStyle(
                                      fontSize:
                                          GetScreenSize.screenHeight() * 0.04),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: GetScreenSize.screenWidth() * 0.3,
                              height: GetScreenSize.screenHeight() * 0.1,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Center(
                                child: Text(
                                  "?????????",
                                  style: TextStyle(
                                      fontSize:
                                          GetScreenSize.screenHeight() * 0.04),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: GetScreenSize.screenWidth() * 0.3,
                              height: GetScreenSize.screenHeight() * 0.1,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Center(
                                child: Text(
                                  "?????????????????????",
                                  style: TextStyle(
                                      fontSize:
                                          GetScreenSize.screenHeight() * 0.04),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),

                  ///status window(???)
                  Align(
                    alignment: const Alignment(-1, 0),
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.5,
                      height: GetScreenSize.screenHeight() * 0.9,
                      margin: EdgeInsets.only(
                        left: GetScreenSize.screenWidth() * 0.03,
                      ),
                      decoration: const BoxDecoration(color: Colors.white),
                    ),
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

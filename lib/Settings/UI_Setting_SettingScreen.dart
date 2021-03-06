///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Conversation/UI_conversation_ConversationScreen.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';

///import other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import '../Home/UI_home_HomeScreen.dart';
import 'UI_Setting_SettingContents.dart';
import 'Provider_Setting_otameshi.dart';

final otameshi = ChangeNotifierProvider.autoDispose((ref) => Otameshi());

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Scaffold(
      body: LifecycleManager(
        callback: CommonLifecycleCallback(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Center(
            child: Container(
              width: GetScreenSize.screenWidth(),
              height: GetScreenSize.screenHeight(),
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Stack(
                children: [
                  ///upper widgets
                  Align(
                    alignment: const Alignment(0, -1),
                    child: SizedBox(
                      width: GetScreenSize.screenWidth(),
                      height: GetScreenSize.screenHeight() * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///back button
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ConversationScreen()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: GetScreenSize.screenWidth() * 0.02,
                                  top: GetScreenSize.screenWidth() * 0.01),
                              width: GetScreenSize.screenWidth() * 0.07,
                              height: GetScreenSize.screenWidth() * 0.07,
                              color: Colors.white,
                              child: const Center(
                                child: Text("back"),
                              ),
                            ),
                          ),

                          ///Setting text
                          Container(
                            margin: EdgeInsets.only(
                                top: GetScreenSize.screenWidth() * 0.01),
                            width: GetScreenSize.screenWidth() * 0.3,
                            height: GetScreenSize.screenWidth() * 0.07,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "Setting",
                                style: TextStyle(
                                  fontSize: GetScreenSize.screenHeight() * 0.04,
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),

                          ///reset to init
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: GetScreenSize.screenWidth() * 0.1,
                              height: GetScreenSize.screenWidth() * 0.07,
                              margin: EdgeInsets.only(
                                top: GetScreenSize.screenWidth() * 0.01,
                                right: GetScreenSize.screenWidth() * 0.1,
                              ),
                              color: Colors.white,
                              child: const Text(
                                "resetButton",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///scroll widget(UI_Setting_SettingContexts.dart)
                  const Align(
                    alignment: Alignment(0, 1),
                    child: SettingContents(),
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

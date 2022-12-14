///package
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Common/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Common/Interface_common_GameScreenInterface.dart';
import 'package:sosaku/Common/UI_common_GameScreenBase.dart';

///import other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_settings_SettingContents.dart';
import 'Provider_settings_SettingsProvider.dart';

final settingsProvider =
    ChangeNotifierProvider.autoDispose((ref) => SettingsProvider());

class SettingScreen extends HookConsumerWidget implements GameScreenInterface {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GameScreenBase(
        opaque: false,
        lifecycleCallback: const CommonLifecycleCallback(),
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
                color: Colors.black.withOpacity(0.5),
                child: Stack(
                  children: [
                    ///upper widgets
                    Align(
                      alignment: const Alignment(0, -1),
                      child: Container(
                        width: GetScreenSize.screenWidth(),
                        height: GetScreenSize.screenHeight() * 0.3,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///back button
                            GestureDetector(
                              onTap: () {
                                // Close the settings screen.
                                Navigator.pop(context);
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
                                    fontSize:
                                        GetScreenSize.screenHeight() * 0.04,
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
      ),
    );
  }

  @override
  Future<void> prepare(BuildContext context) async {
    // do nothing.
  }
}

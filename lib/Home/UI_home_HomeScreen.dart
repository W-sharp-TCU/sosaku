import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Common/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Common/Interface_common_GameScreenInterface.dart';
import 'package:sosaku/Conversation/UI_conversation_ConversationScreen.dart';
import 'package:sosaku/Home/Provider_home_HomeScreenProvider.dart';
import 'package:sosaku/NowLoading/UI_nowLoading_NowLoadingScreen.dart';
import 'package:sosaku/SelectAction/UI_selectAction_SelectActionScreen.dart';
import 'package:sosaku/Settings/UI_Setting_SettingScreen.dart';
import 'package:sosaku/Title/Controller_title_SlideShowController.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';
import 'package:sosaku/Wrapper/wrapper_TransitionBuilders.dart';
import 'package:sosaku/l10n/l10n.dart';

import '../Wrapper/wrapper_SoundPlayer.dart';

/// wrapper import
import '../Wrapper/wrapper_GetScreenSize.dart';

/// widget files import
import 'UI_home_Button.dart';

import '../Load/UI_load_LoadScreen.dart';

final homeScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => HomeScreenProvider());

class HomeScreen extends HookConsumerWidget implements GameScreenInterface {
  const HomeScreen({Key? key, SlideShowController? slideShowController})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Scaffold(
      body: LifecycleManager(
        callback: CommonLifecycleCallback(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: Center(
            child: Container(
              height: GetScreenSize.screenHeight(),
              width: GetScreenSize.screenWidth(),
              color: Colors.grey,
              /* delete it when you set asset path */
              child: Stack(
                children: <Widget>[
                  /// asset background screen without image path.
                  ///
                  Image(
                    image:
                        AssetImage(ref.watch(homeScreenProvider).mBGImagePath),
                  ),

                  /// widget button 1
                  Align(
                    alignment: const Alignment(0.7, -0.40),
                    child: GestureDetector(
                      child: Button(buttonName: L10n.of(context)!.newGame),
                      onTap: () async {
                        print("pushed button 1");
                        // _slideShowController.stop();
                        SoundPlayer().playUI("assets/sound/UI/next.mp3");
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const ConversationScreen(),
                            transitionDuration:
                                const Duration(milliseconds: 1000),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                buildFlashTransition(Colors.black, context,
                                    animation, secondaryAnimation, child),
                          ),
                        );
                      },
                    ),
                  ),

                  /// widget button 2
                  Align(
                    alignment: const Alignment(0.7, -0.10),
                    child: GestureDetector(
                      child: Button(buttonName: L10n.of(context)!.continueGame),
                      onTap: () {
                        SoundPlayer().playUI("assets/sound/UI/next.mp3");
                        print("pushed button 2");
                        // _slideShowController.stop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoadScreen()),
                        );
                      },
                    ),
                  ),

                  /// widget button 3
                  Align(
                    alignment: const Alignment(0.7, 0.20),
                    child: GestureDetector(
                      child: Button(buttonName: L10n.of(context)!.settings),
                      onTap: () {
                        SoundPlayer().playUI("assets/sound/UI/pushButton.mp3");
                        print("pushed button 3");
                        // _slideShowController.stop();
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  const SettingScreen(),
                              transitionDuration:
                                  const Duration(milliseconds: 10)),
                        );
                      },
                    ),
                  ),

                  /// widget button 4
                  Align(
                    alignment: const Alignment(0.7, 0.50),
                    child: GestureDetector(
                      child: Button(buttonName: L10n.of(context)!.gallery),
                      onTap: () {
                        print("pushed button 4");
                        // _slideShowController.stop();
                        SoundPlayer().playUI("assets/sound/UI/next.mp3");
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                const SelectActionScreen(),
                            transitionDuration:
                                const Duration(milliseconds: 1000),
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
                                buildFadeTransition(context, animation,
                                    secondaryAnimation, child),
                          ),
                        );
                      },
                    ),
                  ),

                  /// widget button 5
                  Align(
                    alignment: const Alignment(0.7, 0.80),
                    child: GestureDetector(
                      child: Button(buttonName: L10n.of(context)!.documents),
                      onTap: () {
                        /// call methods when button pushed 5.
                        /// print("pushed button 4"); delete.
                        print("pushed button 5");
                      },
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

  @override
  Future<void> prepare(BuildContext context) async {
    // do nothing.
  }
}

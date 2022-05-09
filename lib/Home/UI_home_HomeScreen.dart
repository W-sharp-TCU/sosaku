import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Home/Provider_home_HomeScreenProvider.dart';
import 'package:sosaku/NowLoading/UI_nowLoading_NowLoadingScreen.dart';
import 'package:sosaku/Settings/UI_Setting_SettingScreen.dart';
import 'package:sosaku/Title/Controller_title_SlideShowController.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';
import 'package:sosaku/l10n/l10n.dart';

import '../Wrapper/wrapper_SoundPlayer.dart';

/// wrapper import
import '../Wrapper/wrapper_GetScreenSize.dart';

/// widget files import
import 'UI_home_Button.dart';

/// widget files import when tested.
import '../Conversation/UI_conversation_ConversationScreen.dart';
import '../Load/UI_load_LoadScreen.dart';

final homeScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => HomeScreenProvider());

class HomeScreen extends ConsumerWidget {
  late final SlideShowController _slideShowController;

  HomeScreen({Key? key, SlideShowController? slideShowController})
      : super(key: key) {
    if (slideShowController == null) {
      _slideShowController = SlideShowController([
        "assets/drawable/Title/Ocean.jpg",
        "assets/drawable/Title/Lion.jpg",
        "assets/drawable/Title/default.jpg"
      ]);
    } else {
      _slideShowController = slideShowController;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    _slideShowController.start(context, ref.read(homeScreenProvider));

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

                  ///

                  /// widget button 1
                  Align(
                    alignment: const Alignment(0.7, 0.20),
                    child: GestureDetector(
                      child: Button(buttonName: L10n.of(context)!.newGame),
                      onTap: () async {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  const SettingScreen(),
                              transitionDuration:
                                  const Duration(milliseconds: 10)),
                        );
                        print("pushed button 1");
                        _slideShowController.stop();
                        SoundPlayer.playUI("assets/sound/pushButton.mp3");
                      },
                    ),
                  ),

                  /// widget button 2
                  Align(
                    alignment: const Alignment(0.7, 0.50),
                    child: GestureDetector(
                      child: Button(buttonName: L10n.of(context)!.continueGame),
                      onTap: () {
                        SoundPlayer.playUI("assets/sound/pushButton.mp3");
                        print("pushed button 2");
                        _slideShowController.stop();
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
                    alignment: const Alignment(0.7, 0.80),
                    child: GestureDetector(
                      child: Button(buttonName: L10n.of(context)!.settings),
                      onTap: () {
                        SoundPlayer.playUI("assets/sound/next.mp3");
                        print("pushed button 3");
                        _slideShowController.stop();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NowLoadingScreen(
                                  process: () async {
                                    await precacheImage(
                                        const AssetImage(
                                            "assets/drawable/Conversation/4k.jpg"),
                                        context);
                                  },
                                  goto: const ConversationScreen())),
                        );
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
}

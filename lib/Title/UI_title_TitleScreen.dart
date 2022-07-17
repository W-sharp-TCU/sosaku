import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Title/Controller_title_SlideShowController.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';
import 'package:sosaku/Wrapper/wrapper_TransitionBuilders.dart';
import 'package:sosaku/l10n/l10n.dart';
import '../Wrapper/wrapper_SoundPlayer.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Provider_title_TitleScreenProvider.dart';
import '../Home/UI_home_HomeScreen.dart';

final titleScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => TitleScreenProvider());

class TitleScreen extends ConsumerWidget {
  // late final SlideShowController _slideShowController;
  static const _backgroundImages = [
    "assets/drawable/Title/Ocean.jpg",
    "assets/drawable/Title/Lion.jpg",
    "assets/drawable/Title/default.jpg"
  ];

  TitleScreen({Key? key, SlideShowController? slideShowController})
      : super(key: key) {
    /* if (slideShowController == null) {
      _slideShowController = SlideShowController(_backgroundImages);
    } else {
      _slideShowController = slideShowController;
    }*/
    SoundPlayer().playBGM("assets/sound/BGM/Full-bloomer.mp3",
        loop: true, fadeOut: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    // _slideShowController.start(ref.read(titleScreenProvider));

    return ProviderScope(
      child: Scaffold(
        body: LifecycleManager(
          callback: CommonLifecycleCallback(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // _slideShowController.stop();
                  SoundPlayer().playUI("assets/sound/UI/next.mp3");
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: const Duration(milliseconds: 500),
                        transitionsBuilder: (context, animation,
                                secondaryAnimation, child) =>
                            buildFadeTransition(
                                context, animation, secondaryAnimation, child)),
                  );
                },
                child: Container(
                    height: GetScreenSize.screenHeight(),
                    width: GetScreenSize.screenWidth(),
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              ref.watch(titleScreenProvider).mBGImagePath),
                        ),
                        Align(
                          alignment: const Alignment(0, 0.8),
                          child: Text(
                            L10n.of(context)!.tapToStart,
                            style: TextStyle(
                              fontSize: GetScreenSize.screenHeight() * 0.1,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> prepare(BuildContext context) async {
    SoundPlayer().precacheSounds(filePaths: [
      "assets/sound/UI/pushButton.mp3",
      "assets/sound/UI/next.mp3"
    ], audioType: SoundPlayer.ui);
    SoundPlayer().precacheSounds(
        filePaths: ["assets/sound/BGM/Full-bloomer.mp3"],
        audioType: SoundPlayer.bgm);
    for (var e in _backgroundImages) {
      await precacheImage(AssetImage(e), context);
    }
  }
}

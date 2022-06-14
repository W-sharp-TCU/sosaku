import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Title/Controller_title_SlideShowController.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';
import 'package:sosaku/l10n/l10n.dart';
import 'package:sosaku/main.dart';
import '../Conversation/UI_conversation_ConversationScreen.dart';
import '../Wrapper/wrapper_SoundPlayer.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Provider_title_TitleScreenProvider.dart';
import '../Home/UI_home_HomeScreen.dart';

final titleScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => TitleScreenProvider());

class TitleScreen extends ConsumerWidget {
  late final SlideShowController _slideShowController;
  bool isFirstBuild = true; // 突貫工事部品
  bool isReady = false; // 突貫工事部品

  TitleScreen({Key? key, SlideShowController? slideShowController})
      : super(key: key) {
    if (slideShowController == null) {
      _slideShowController = SlideShowController(
          ["assets/drawable/Title/wsharp_banner_expanded.png"]);
    } else {
      _slideShowController = slideShowController;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    //_slideShowController.start(context, ref.read(titleScreenProvider));

    // デモ用突貫工事
    // pre-load conversation assets
    if (isFirstBuild) {
      preLoad(context).then((value) => isReady = true);
    }

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
                  print("tap"); //デバッグ用
                  //_slideShowController.stop();
                  if (isReady) {
                    SoundPlayer.playBGM("assets/sound/BGM/Full-bloomer.mp3",
                        loop: true, fadeOut: true);
                    SoundPlayer.playUI("assets/sound/UISound/next.mp3");
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          // TODO : for demo
                          // pageBuilder: (_, __, ___) => HomeScreen(),
                          pageBuilder: (_, __, ___) =>
                              const ConversationScreen(),
                          transitionDuration: const Duration(milliseconds: 10)),

                      ///old page transition code
                      //MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
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
                        alignment: const Alignment(-0.98, -0.98),
                        child: Text(
                          "Package name : ${packageInfo.packageName},  Version : ${packageInfo.version}",
                          style: TextStyle(
                            fontSize: GetScreenSize.screenHeight() * 0.025,
                            color: Colors.white,
                          ),
                        ),
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> prepare() async {
    /*SoundPlayer.loadSE(
        ["assets/sound/pushButton.mp3", "assets/sound/next.mp3"]);*/
    SoundPlayer.init();
    SoundPlayer.loadAll(filePaths: [
      "assets/sound/UISound/pushButton.mp3",
      "assets/sound/UISound/next.mp3"
    ], audioType: SoundPlayer.UI);
    SoundPlayer.loadAll(
        filePaths: ["assets/sound/BGM/Full-bloomer.mp3"],
        audioType: SoundPlayer.BGM);
  }

  // 突貫工事用
  Future<void> preLoad(BuildContext context) async {
    List<String> images = [
      "assets/drawable/CharacterImage/Ayana/angry(eyeOpend).png", //
      "assets/drawable/CharacterImage/Ayana/flat(eyeClosed-mouthOpend).png", //
      "assets/drawable/CharacterImage/Ayana/flat(eyeOpend-mouthClosed).png", //
      "assets/drawable/CharacterImage/Ayana/puzzled(eyeOpend).png", //
      "assets/drawable/Conversation/black_screen.png",
      "assets/drawable/Conversation/002_classroomBB.png",
      "assets/drawable/Conversation/button_sample.png",
      "assets/drawable/Conversation/icon_ayana.png",
      "assets/drawable/Conversation/icon_sakaki.png",
      "assets/drawable/Conversation/icon_unknown.png",
      "assets/drawable/Conversation/no_character.png"
    ];
    List<String> cvs = [];
    for (var e in images) {
      await precacheImage(AssetImage(e), context);
    }
    if (cvs.isNotEmpty) {
      SoundPlayer.loadAll(filePaths: cvs, audioType: SoundPlayer.CV);
    }
  }
}

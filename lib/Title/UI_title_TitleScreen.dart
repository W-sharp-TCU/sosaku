import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Common/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Common/Interface_common_GameScreenInterface.dart';
import 'package:sosaku/Common/UI_common_GameScreenBase.dart';
import 'package:sosaku/Help/UI_help_HelpPopUp.dart';
import 'package:sosaku/Title/Controller_title_SlideShowController.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';
import 'package:sosaku/Wrapper/Functions_wrapper_TransitionBuilders.dart';
import 'package:sosaku/main.dart';
import '../Wrapper/wrapper_SharedPref.dart';
import '../Wrapper/wrapper_SoundPlayer.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Provider_title_TitleScreenProvider.dart';
import '../Home/UI_home_HomeScreen.dart';

final titleScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => TitleScreenProvider());

class TitleScreen extends HookConsumerWidget implements GameScreenInterface {
  // late final SlideShowController _slideShowController;
  static const _backgroundImages = [
    "assets/drawable/Title/wsharp_banner_expanded.png"
  ];

  static const List<String> _uiAudioPaths = [
    "assets/sound/UI/pushButton.mp3",
    "assets/sound/UI/next.mp3"
  ];
  static const List<String> _bgmPaths = ["assets/sound/BGM/Full-bloomer.wav"];

  const TitleScreen({Key? key, SlideShowController? slideShowController})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('animate');
    // called once
    useEffect(() {
      SoundPlayer().playBGM(_bgmPaths[0], delay: 2000);
      SharedPref.getBool("read_welcome_to_alpha", false).then((value) async {
        if (!value) {
          await Future.delayed(const Duration(seconds: 2));
          SharedPref.setBool("read_welcome_to_alpha", true);
          Navigator.push(
            context,
            PageRouteBuilder(
                opaque: false,
                pageBuilder: (_, __, ___) => HelpPopUp(
                    contentsFilePath:
                        "assets/text/HelpContents/welcome_to_test.json"),
                transitionDuration: const Duration(milliseconds: 100)),
          ).then(
              (value) => animationController.animate('tapToStart', 'opacity', [
                    Wave(0, 100000, 0, 1, 2000, 0),
                  ]));
        } else {
          animationController.animate('tapToStart', 'opacity', [
            Wave(0, 100000, 0, 1, 2000, 0),
          ]);
        }
        print("Done");
      });
      return null;
    }, []);

    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    // _slideShowController.start(ref.read(titleScreenProvider));
    final animationProvider = animationController.createProvider('tapToStart', {
      'opacity': 0,
    });

    return Scaffold(
      body: GameScreenBase(
        lifecycleCallback: const CommonLifecycleCallback(),
        child: Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanUpdate: (detail) {
              print('aaaa');
            },
            onTap: () {
              // _slideShowController.stop();
              SoundPlayer().playUI("assets/sound/UI/next.mp3");
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const HomeScreen(),
                    transitionDuration: const Duration(milliseconds: 500),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
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
                    // Align(
                    //   alignment: const Alignment(0, 0.8),
                    //   child: Text(
                    //     L10n.of(context)!.tapToStart,
                    //     style: TextStyle(
                    //       fontSize: GetScreenSize.screenHeight() * 0.1,
                    //       color: Colors.white.withOpacity(ref
                    //           .watch(animationProvider)
                    //           .stateDouble['opacity']!),
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    Align(
                      alignment: const Alignment(-0.95, -0.95),
                      child: Text(
                        "Package: ${packageInfo.packageName},  \n"
                        "Version: ${packageInfo.version},  "
                        "Build: ${packageInfo.buildNumber}\n"
                        "Screen Height: ${GetScreenSize.screenHeight()}, \n"
                        "Width: ${GetScreenSize.screenWidth()}",
                        style: TextStyle(
                          fontSize: GetScreenSize.screenHeight() * 0.04,
                          color: Colors.blue,
                        ),
                      ),
                    ),

                    Consumer(
                      builder:
                          (BuildContext context, WidgetRef ref, Widget? child) {
                        return Opacity(
                          opacity: ref
                              .watch(animationProvider)
                              .stateDouble['opacity']!,
                          child: const Image(
                            image: AssetImage(
                                'assets/drawable/Title/titlestart.png'),
                          ),
                        );
                      },
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> prepare(BuildContext context) async {
    await SoundPlayer()
        .precacheSounds(filePaths: _uiAudioPaths, audioType: SoundPlayer.ui);
    await SoundPlayer()
        .precacheSounds(filePaths: _bgmPaths, audioType: SoundPlayer.bgm);
    for (var e in _backgroundImages) {
      await precacheImage(AssetImage(e), context);
    }
  }
}

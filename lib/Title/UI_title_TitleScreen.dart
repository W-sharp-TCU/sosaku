import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Title/Controller_title_SlideShowController.dart';
import 'package:sosaku/l10n/l10n.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Provider_title_TitleScreenProvider.dart';
import '../Home/UI_home_HomeScreen.dart';

final titleScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => TitleScreenProvider());

class TitleScreen extends ConsumerWidget {
  late final SlideShowController _slideShowController;

  TitleScreen({Key? key, SlideShowController? slideShowController})
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
    _slideShowController.start(context, ref.read(titleScreenProvider));

    return ProviderScope(
      child: Scaffold(
          body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _slideShowController.stop();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );

                    print("tap"); //デバッグ用
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
                                fontSize: GetScreenSize.screenHeight() * 0.2,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ))),
    );
  }
}

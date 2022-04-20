import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'Provider_title_TitleScreenProvider.dart';
import '../Home/UI_home_HomeScreen.dart';

final titleScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => TitleScreenProvider());

class TitleScreen extends ConsumerWidget {
  const TitleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    /*var slideshow = ref.watch(titleScreenProvider);
    slideshow.start(context);*/

    return ProviderScope(
      child: Scaffold(
          body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    //slideshow.stop();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
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
                              'Tap to Start',
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

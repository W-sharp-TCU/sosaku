///package
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import '../Home/UI_home_HomeScreen.dart';
import 'UI_load_SelectLoadFile.dart';
import 'Provider_load_LoadUIProvider.dart';
import '../Dialogs/UI_Dialog_DialogScreen.dart';
import 'Provider_load_LoadScreenProvider.dart';

final loadUIProvider =
    ChangeNotifierProvider.autoDispose((ref) => LoadUIProvider());
final loadScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => LoadScreenProvider());

class LoadScreen extends ConsumerWidget {
  const LoadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return ProviderScope(
      child: Scaffold(
        body: LifecycleManager(
          callback: CommonLifecycleCallback(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Center(
              child: Container(
                height: GetScreenSize.screenHeight(),
                width: GetScreenSize.screenWidth(),
                color: Colors.green,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var i = 0; i < 10; i++)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  for (var j = 0; j < 2; j++)
                                    SelectLoadFile(i, j)
                                ],
                              )
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  right: GetScreenSize.screenWidth() * 0.02,
                                  top: GetScreenSize.screenWidth() * 0.02),
                              width: GetScreenSize.screenWidth() * 0.07,
                              height: GetScreenSize.screenWidth() * 0.1,
                              color: Colors.white,
                              child: const Center(
                                child: Text("back"),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            ref.read(loadUIProvider).changeFlag();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                top: GetScreenSize.screenWidth() * 0.02),
                            width: GetScreenSize.screenWidth() * 0.3,
                            height: GetScreenSize.screenWidth() * 0.1,
                            color: Colors.white,
                            child: const Center(
                              child: Text("File Select Text"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (ref.watch(loadUIProvider).popFlag)
                      Align(
                        alignment: Alignment(0, 0),
                        child: const DialogScreen(),
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
}

class PopScreen extends StatelessWidget {
  const PopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Container(
      width: GetScreenSize.screenWidth(),
      height: GetScreenSize.screenHeight(),
      color: Colors.black.withOpacity(0.5),
    );
  }
}

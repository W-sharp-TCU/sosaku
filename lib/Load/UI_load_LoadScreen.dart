///package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Common/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Common/Interface_common_GameScreenInterface.dart';
import 'package:sosaku/Common/UI_common_GameScreenBase.dart';
import 'package:sosaku/Load/UI_load_LoadFileMenu.dart';

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

class LoadScreen extends GameScreen {
  LoadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Scaffold(
      body: GameScreenBase(
        lifecycleCallback: const CommonLifecycleCallback(),
        child: Center(
          child: Container(
            height: GetScreenSize.screenHeight(),
            width: GetScreenSize.screenWidth(),
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/drawable/Load/background.png"),
            )),
            child: Stack(
              children: [
                SizedBox(
                  height: GetScreenSize.screenHeight(),
                  width: GetScreenSize.screenWidth(),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (var i = 0; i < 10; i++) SelectLoadFile(i)
                      ],
                    ),
                  ),
                ),
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
                        ref.read(loadUIProvider).changeFlagDialog();
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
                if (ref.watch(loadUIProvider).popFlagDialog)
                  const Align(
                    alignment: Alignment(0, 0),
                    child: DialogScreen(),
                  ),
                if (ref.watch(loadUIProvider).popFlagSaveMenu)
                  const Align(
                    alignment: Alignment(0, 0),
                    child: LoadFileMenu(),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> prepare(BuildContext context) async {
    drawableAssets.addAll(["assets/drawable/Load/background.png"]);
    return super.prepare(context);
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

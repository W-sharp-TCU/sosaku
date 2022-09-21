import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/SelectAction/Controller_selectAction_SelectActionController.dart';
import 'package:sosaku/SelectAction/Provider_selectAction_SelectActionScreenProvider.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';

import '../Common/Interface_common_GameScreenInterface.dart';
import '../Common/UI_common_GameScreenBase.dart';
import '../Wrapper/wrapper_AnimationWidget.dart';

final selectActionScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => SelectActionScreenProvider());

final SelectActionScreenController selectActionScreenController =
    SelectActionScreenController();

class SelectActionScreen extends HookConsumerWidget
    implements GameScreenInterface {
  const SelectActionScreen({Key? key}) : super(key: key);
  static const String _screenImagePath =
      "./assets/drawable/Conversation/004_corridorBB.png";
  static const String _characterImagePath =
      "./assets/drawable/CharacterImage/Ayana/normal.png";
  static const String _buttonImagePath = "";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SelectActionScreenProvider sasp = ref.watch(selectActionScreenProvider);
    selectActionScreenController.start(sasp, context);
    final animationProvider = animationController.createProvider('statusUp',
        {'arrow': GetScreenSize.screenHeight() * 0.6, 'opacity': 0});
    return Scaffold(
        body: GameScreenBase(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Center(
          child: SizedBox(
            width: GetScreenSize.screenWidth(),
            height: GetScreenSize.screenHeight(),
            child: Stack(
              children: <Widget>[
                const Image(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    _screenImagePath,
                  ),
                ),
                const Align(
                  alignment: Alignment(0.7, 0),
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      _characterImagePath,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.85, -0.75),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: const <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          Center(
                            child: Text("バイトに行く"),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      selectActionScreenController.selectWork();
                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.85, 0),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: const <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          Center(
                            child: Text("のののと過ごす"),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      selectActionScreenController.selectNonono();
                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.85, 0.75),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          const Center(
                            child: Text("あやなと過ごす"),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      selectActionScreenController.selectAyana();
                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.30, -0.75),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          const Center(
                            child: Text("1人で執筆"),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.30, 0),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          const Center(
                            child: Text("授業に行く"),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      selectActionScreenController.selectWriting();
                    },
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.30, 0.75),
                  child: GestureDetector(
                    child: Container(
                      width: GetScreenSize.screenWidth() * 0.2,
                      height: GetScreenSize.screenHeight() * 0.2,
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              _buttonImagePath,
                            ),
                          ),
                          const Center(
                            child: Text("川本習に電話"),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
                if (ref.watch(selectActionScreenProvider).isStatusUp)
                  Align(
                    alignment: const Alignment(1, 1),
                    child: Container(
                        margin: EdgeInsets.only(
                          bottom: ref
                              .watch(animationProvider)
                              .stateDouble['arrow']!,
                          right: GetScreenSize.screenWidth() * 0.0,
                        ),
                        width: GetScreenSize.screenWidth() * 0.2,
                        height: GetScreenSize.screenWidth() * 0.06,
                        child: Opacity(
                            opacity: ref
                                    .watch(animationProvider)
                                    .stateDouble['opacity'] ??
                                1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BorderedText(
                                  strokeWidth:
                                      GetScreenSize.screenHeight() * 0.01,
                                  strokeColor: Colors.purple,
                                  child: Text(
                                    ref
                                        .watch(selectActionScreenProvider)
                                        .statusUpName,
                                    style: TextStyle(
                                      fontSize:
                                          GetScreenSize.screenWidth() * 0.04,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                if (ref
                                        .watch(selectActionScreenProvider)
                                        .statusUpValue >
                                    0)
                                  Icon(
                                    Icons.arrow_upward,
                                    color: Colors.orange,
                                    size: GetScreenSize.screenWidth() * 0.04,
                                  ),
                                if (ref
                                        .watch(selectActionScreenProvider)
                                        .statusUpValue <
                                    0)
                                  Icon(
                                    Icons.arrow_downward,
                                    color: Colors.blue,
                                    size: GetScreenSize.screenWidth() * 0.04,
                                  )
                              ],
                            ))
                        // child: Text(
                        //   '⇧',
                        //   style: TextStyle(
                        //     fontSize: GetScreenSize.screenWidth() * 0.03,
                        //     color: Colors.orange,
                        //   ),
                        // )
                        ),
                  )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  @override
  Future<void> prepare(BuildContext context) async {
    await precacheImage(AssetImage(_screenImagePath), context);
    await precacheImage(AssetImage(_characterImagePath), context);
  }
}

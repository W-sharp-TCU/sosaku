import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Common/UI_common_GameScreenBase.dart';
import 'package:sosaku/Menu/Provider_menu_MenuScreenProvider.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';

import '../Wrapper/wrapper_AnimationButton.dart';
import 'Controller_menu_MenuController.dart';

final menuScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => MenuScreenProvider());

class MenuScreen extends ConsumerWidget {
  static const sideButtonImage =
      'assets/drawable/Conversation/button_sample.png';
  final Function? onTapClose;
  final Function? onTapSave;
  final Function? onTapOption;
  final Function? onTapHelp;
  final Function? onTapGoTitle;
  final AnimationButton? closeMenuButton;
  const MenuScreen(
      {this.onTapClose,
      this.onTapSave,
      this.onTapOption,
      this.onTapHelp,
      this.onTapGoTitle,
      this.closeMenuButton,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    return Scaffold(
      body: GameScreenBase(
        child: SizedBox(
            width: GetScreenSize.screenWidth(),
            height: GetScreenSize.screenHeight(),
            child: Center(
                child: ClipRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: GetScreenSize.screenHeight() * 0.01,
                          sigmaY: GetScreenSize.screenHeight() * 0.01,
                        ),
                        child: Container(
                            width: GetScreenSize.screenWidth(),
                            height: GetScreenSize.screenHeight(),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: Stack(children: [
                              /// close button
                              closeMenuButton ??
                                  Align(
                                    alignment: const Alignment(1, -1),
                                    child: AnimationButton(
                                        key: const Key('menuClose'),
                                        onTap: () {
                                          onTapClose?.call();
                                          MenuScreenController
                                              .onTapCloseDefault(context);
                                        },
                                        width:
                                            GetScreenSize.screenWidth() * 0.06,
                                        height:
                                            GetScreenSize.screenWidth() * 0.06,
                                        margin: EdgeInsets.all(
                                            GetScreenSize.screenWidth() * 0.02),
                                        child: const FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text('×'))),
                                  ),

                              /// right 4 buttons
                              Align(
                                  alignment: const Alignment(1, 1),
                                  child: Container(
                                      width: GetScreenSize.screenWidth() * 0.4,
                                      height:
                                          GetScreenSize.screenHeight() * 0.6,
                                      margin: EdgeInsets.only(
                                          bottom: GetScreenSize.screenHeight() *
                                              0.05),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AnimationButton(
                                              key: const Key('menuSave'),
                                              width:
                                                  GetScreenSize.screenWidth() *
                                                      0.35,
                                              height:
                                                  GetScreenSize.screenHeight() *
                                                      0.12,
                                              image: sideButtonImage,
                                              onTap: () {
                                                onTapSave?.call();
                                                MenuScreenController
                                                    .onTapSaveDefault();
                                              },
                                              child: const FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text('セーブ')),
                                            ),
                                            const Spacer(),
                                            AnimationButton(
                                              key: const Key('menuOption'),
                                              width:
                                                  GetScreenSize.screenWidth() *
                                                      0.35,
                                              height:
                                                  GetScreenSize.screenHeight() *
                                                      0.12,
                                              image: sideButtonImage,
                                              onTap: () {
                                                onTapOption?.call();
                                                MenuScreenController
                                                    .onTapOptionDefault(
                                                        context);
                                              },
                                              child: const FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text('オプション')),
                                            ),
                                            const Spacer(),
                                            AnimationButton(
                                              key: const Key('menuHelp'),
                                              width:
                                                  GetScreenSize.screenWidth() *
                                                      0.35,
                                              height:
                                                  GetScreenSize.screenHeight() *
                                                      0.12,
                                              image: sideButtonImage,
                                              onTap: () {
                                                onTapHelp?.call();
                                                MenuScreenController
                                                    .onTapHelpDefault();
                                              },
                                              child: const FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text('ヘルプ')),
                                            ),
                                            const Spacer(),
                                            AnimationButton(
                                              key: const Key('menuGoTitle'),
                                              width:
                                                  GetScreenSize.screenWidth() *
                                                      0.35,
                                              height:
                                                  GetScreenSize.screenHeight() *
                                                      0.12,
                                              image: sideButtonImage,
                                              onTap: () {
                                                onTapGoTitle?.call();
                                                MenuScreenController
                                                    .onTapGoTitleDefault(
                                                        context);
                                              },
                                              child: const FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text('タイトルへ戻る')),
                                            )
                                          ]))),

                              /// status window
                              Align(
                                alignment: const Alignment(-1, 0),
                                child: Container(
                                  width: GetScreenSize.screenWidth() * 0.5,
                                  height: GetScreenSize.screenHeight() * 0.9,
                                  margin: EdgeInsets.only(
                                    left: GetScreenSize.screenWidth() * 0.03,
                                  ),
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                ),
                              ),
                            ])))))),
      ),
    );
  }
}
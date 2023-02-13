import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sosaku/Common/Callback_common_CommonLifecycleCallback.dart';
import 'package:sosaku/Common/Interface_common_GameScreenInterface.dart';
import 'package:sosaku/Common/UI_common_GameScreenBase.dart';
import 'package:sosaku/Help/Provider_help_HelpPopUpProvider.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationButton.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';

final helpPopUpProvider =
    ChangeNotifierProvider.autoDispose((ref) => HelpPopUpProvider());

class HelpPopUp extends GameScreen {
  HelpPopUp({Key? key, required this.contentsFilePath}) : super(key: key);

  final String contentsFilePath;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(helpPopUpProvider).loadContents(contentsFilePath);
      return null;
    }, []);
    GetScreenSize.follow(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GameScreenBase(
        opaque: opaque,
        lifecycleCallback: const CommonLifecycleCallback(),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: GetScreenSize.screenHeight() * 0.01,
              sigmaY: GetScreenSize.screenHeight() * 0.01,
            ),
            child: Container(
              width: GetScreenSize.screenWidth(),
              height: GetScreenSize.screenHeight(),
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: Container(
                  height: GetScreenSize.screenHeight() * 0.85,
                  width: GetScreenSize.screenWidth() * 0.85,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(10)),
                  child: FractionallySizedBox(
                    alignment: const Alignment(0, 0),
                    widthFactor: 0.97,
                    heightFactor: 0.97,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Container(
                                    height: double.infinity,
                                    alignment: Alignment.center,
                                    child: Text(
                                      ref.watch(helpPopUpProvider).title,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ),
                                AnimationButton(
                                  onTap: () => Navigator.pop(context),
                                  image:
                                      "assets/drawable/Conversation/batsu.png",
                                  height: GetScreenSize.screenWidth() * 0.07,
                                  width: GetScreenSize.screenWidth() * 0.07,
                                )
                              ],
                            )),
                        Expanded(
                          flex: 7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (!ref.watch(helpPopUpProvider).ready)
                                Expanded(
                                  child: SkeletonAnimation(
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              if (ref.watch(helpPopUpProvider).ready)
                                Expanded(
                                  flex: 6,
                                  child: SizedBox(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: SingleChildScrollView(
                                      child: Text(
                                          ref.watch(helpPopUpProvider).text),
                                    ),
                                  ),
                                ),
                              if (ref.watch(helpPopUpProvider).ready &&
                                  ref.watch(helpPopUpProvider).hasImage)
                                Expanded(
                                  flex: 4,
                                  child: Image(
                                    image: AssetImage(
                                        ref.watch(helpPopUpProvider).imagePath),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimationButton(
                                width: GetScreenSize.screenWidth() * 0.02,
                                height: GetScreenSize.screenWidth() * 0.02,
                                onTap: () {
                                  ref.read(helpPopUpProvider).prev();
                                },
                              ),
                              Text(
                                  "${ref.watch(helpPopUpProvider).currentPageNo} / ${ref.watch(helpPopUpProvider).totalPages}"),
                              AnimationButton(
                                width: GetScreenSize.screenWidth() * 0.02,
                                height: GetScreenSize.screenWidth() * 0.02,
                                onTap: () {
                                  ref.read(helpPopUpProvider).next();
                                },
                              ),
                            ],
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
      ),
    );
  }
}

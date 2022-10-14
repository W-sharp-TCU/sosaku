///package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Conversation/UI_conversation_ConversationScreen.dart';
import 'package:sosaku/Settings/UI_Setting_SettingScreen.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_Setting_SettingScreen.dart';

class SettingContents extends ConsumerWidget {
  const SettingContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Container(
      width: GetScreenSize.screenWidth() * 0.95,
      height: GetScreenSize.screenHeight() * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///text speed
              Container(
                width: GetScreenSize.screenWidth(),
                height: GetScreenSize.screenHeight() * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "テキスト送り速度",
                      style: TextStyle(
                        fontSize: GetScreenSize.screenHeight() * 0.04,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.7,
                          height: GetScreenSize.screenHeight() * 0.2,
                          child: Slider(
                            value: ref.watch(settingsProvider).textSliderValue,
                            min: 1,
                            max: 5,
                            divisions: 4,
                            onChanged: (double value) {
                              ref
                                  .read(settingsProvider)
                                  .setTextSliderValue(value);
                              conversationScreenController.setSettings(
                                  textSpeed: value);
                            },
                          ),
                        ),
                        Text(
                            ref
                              .watch(settingsProvider)
                              .textSliderValue
                              .toInt()
                              .toString(),
                          style: TextStyle(
                            fontSize: GetScreenSize.screenHeight() * 0.04,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              ///sounds setting
              Container(
                width: GetScreenSize.screenWidth(),
                height: GetScreenSize.screenHeight() * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "サウンド",
                      style: TextStyle(
                        fontSize: GetScreenSize.screenHeight() * 0.04,
                      ),
                    ),

                    ///voice
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.1,
                          child: Center(
                            child: Text(
                              "Voice",
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.7,
                          height: GetScreenSize.screenHeight() * 0.1,
                          child: Slider(
                            value: ref.watch(settingsProvider).voiceSliderValue,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            onChanged: (double value) {
                              ref
                                  .read(settingsProvider)
                                  .setVoiceSliderValue(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.05,
                          child: Center(
                            child: Text(
                                ref
                                  .watch(settingsProvider)
                                  .voiceSliderValue
                                  .toInt()
                                  .toString(),
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///BGM
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.1,
                          child: Center(
                            child: Text(
                              "BGM",
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.7,
                          height: GetScreenSize.screenHeight() * 0.1,
                          child: Slider(
                            value: ref.watch(settingsProvider).bgmSliderValue,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            onChanged: (double value) {
                              ref
                                  .read(settingsProvider)
                                  .setBGMSliderValue(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.05,
                          child: Center(
                            child: Text(
                                ref
                                  .watch(settingsProvider)
                                  .bgmSliderValue
                                  .toInt()
                                  .toString(),
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///UI
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.1,
                          child: Center(
                            child: Text(
                              "UI",
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.7,
                          height: GetScreenSize.screenHeight() * 0.1,
                          child: Slider(
                            value: ref.watch(settingsProvider).uiSliderValue,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            onChanged: (double value) {
                              ref
                                  .read(settingsProvider)
                                  .setUiSliderValue(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.05,
                          child: Center(
                            child: Text(
                                ref
                                  .watch(settingsProvider)
                                  .uiSliderValue
                                  .toInt()
                                  .toString(),
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// As
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.1,
                          child: Center(
                            child: Text(
                              "AS",
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.7,
                          height: GetScreenSize.screenHeight() * 0.1,
                          child: Slider(
                            value: ref.watch(settingsProvider).asSliderValue,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            onChanged: (double value) {
                              ref
                                  .read(settingsProvider)
                                  .setAsSliderValue(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.05,
                          child: Center(
                            child: Text(
                                ref
                                  .watch(settingsProvider)
                                  .asSliderValue
                                  .toInt()
                                  .toString(),
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

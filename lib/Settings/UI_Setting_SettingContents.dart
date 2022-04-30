///package
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Settings/UI_Setting_SettingScreen.dart';
///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_Setting_SettingScreen.dart';

class SettingContents extends ConsumerWidget{
  const SettingContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
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

              Container(
                width: GetScreenSize.screenWidth(),
                height: GetScreenSize.screenHeight() * 0.3,
                color: Colors.red,
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
                            value: ref.watch(otameshi).textSliderValue,
                            min: 1,
                            max: 5,
                            divisions: 4,
                            onChanged: (double value){
                              ref.read(otameshi).setTextSliderValue(value);
                            },
                          ),
                        ),
                        Text(
                          ref.watch(otameshi).textSliderValue.toString(),
                          style: TextStyle(
                            fontSize: GetScreenSize.screenHeight() * 0.04,
                          ),
                        ),
                      ],
                    )
                  ],
                ),

              ),


              Container(
                width: GetScreenSize.screenWidth(),
                height: GetScreenSize.screenHeight() * 0.4,
                color: Colors.pink,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "サウンド",
                      style: TextStyle(
                        fontSize: GetScreenSize.screenHeight() * 0.04,
                      ),
                    ),

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
                            value: ref.watch(otameshi).voiceSliderValue,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            onChanged: (double value){
                              ref.read(otameshi).setVoiceSliderValue(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.05,
                          child: Center(
                            child: Text(
                              ref.watch(otameshi).voiceSliderValue.toString(),
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

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
                            value: ref.watch(otameshi).bgmSliderValue,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            onChanged: (double value){
                              ref.read(otameshi).setBGMSliderValue(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.05,
                          child: Center(
                            child: Text(
                              ref.watch(otameshi).bgmSliderValue.toString(),
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.1,
                          child: Center(
                            child: Text(
                              "SE",
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
                            value: ref.watch(otameshi).seSliderValue,
                            min: 0,
                            max: 10,
                            divisions: 10,
                            onChanged: (double value){
                              ref.read(otameshi).setSESliderValue(value);
                            },
                          ),
                        ),
                        SizedBox(
                          width: GetScreenSize.screenWidth() * 0.05,
                          child: Center(
                            child: Text(
                              ref.watch(otameshi).seSliderValue.toString(),
                              style: TextStyle(
                                fontSize: GetScreenSize.screenHeight() * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

              ),

            ],
          )
      ),


    );
  }
}
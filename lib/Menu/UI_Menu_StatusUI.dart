import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Menu/Controller_menu_MenuController.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';

import '../Wrapper/wrapper_AnimationButton.dart';
import '../Wrapper/wrapper_GetScreenSize.dart';
import 'UI_Menu_MenuScreen.dart';

class StatusUI extends ConsumerWidget {
  StatusUI({Key? key}) : super(key: key);
  final ap = animationController.createProvider(
      'statusUI', {'money': 0, 'ayanaSkill': 0, 'nononoSkill': 0});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
        width: GetScreenSize.screenWidth() * 0.5,
        height: GetScreenSize.screenHeight() * 0.9,
        child: Stack(
          /// gauge image
          children: [
            const Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/drawable/Menu/status_bar_sample.png'),
            ),

            /// ayana skill gauge
            Align(
                alignment: const Alignment(0.75, -0.3),
                child: SizedBox(
                  width: GetScreenSize.screenWidth() * 0.28,
                  height: GetScreenSize.screenHeight() * 0.25,
                  child: Align(
                    alignment: const Alignment(1, 0),
                    child: Container(
                      width: GetScreenSize.screenWidth() *
                          0.28 *
                          1 /
                          (ref.watch(ap).stateDouble['ayanaSkill']! + 1),
                      height: GetScreenSize.screenHeight() * 0.25,
                      color: Colors.white.withOpacity(1),
                    ),
                  ),
                )),

            /// nonono skill gauge
            Align(
                alignment: const Alignment(0.75, 0.8),
                child: SizedBox(
                  width: GetScreenSize.screenWidth() * 0.28,
                  height: GetScreenSize.screenHeight() * 0.25,
                  child: Align(
                    alignment: const Alignment(1, 0),
                    child: Container(
                      width: GetScreenSize.screenWidth() *
                          0.28 *
                          1 /
                          (ref.watch(ap).stateDouble['nononoSkill']! + 1),
                      height: GetScreenSize.screenHeight() * 0.25,
                      color: Colors.white.withOpacity(1),
                    ),
                  ),
                )),

            /// back ground image
            const Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/drawable/Menu/status_sample.png'),
            ),

            /// money
            Align(
              alignment: Alignment(0, -0.89),
              child: Text(
                '￥${ref.watch(ap).stateDouble['money']!.ceil().toString()}',
                style: TextStyle(
                    fontSize: GetScreenSize.screenHeight() * 0.05,
                    color: Colors.white),
              ),
            ),

            /// TODO : remove
            /// test button
            Align(
              alignment: Alignment(1, -1),
              child: AnimationButton(
                key: const Key('menuStatusUI'),
                width: GetScreenSize.screenWidth() * 0.1,
                height: GetScreenSize.screenWidth() * 0.1,
                onTap: () {
                  double money =
                      animationController.getStateDouble('statusUI', 'money');
                  double ayanaSkill = animationController.getStateDouble(
                      'statusUI', 'ayanaSkill');
                  double nononoSkill = animationController.getStateDouble(
                      'statusUI', 'nononoSkill');
                  animationController.animate('statusUI', 'money',
                      [Linear(0, 1100, money, money + 10000)]);
                  animationController.animate('statusUI', 'ayanaSkill',
                      [Linear(0, 1100, ayanaSkill, ayanaSkill + 1)]);
                  animationController.animate('statusUI', 'nononoSkill',
                      [Linear(0, 1100, nononoSkill, nononoSkill + 3)]);
                },
                child: const FittedBox(
                    fit: BoxFit.contain, child: Icon(Icons.add)),
              ),
            )
          ],
        ));
  }
}

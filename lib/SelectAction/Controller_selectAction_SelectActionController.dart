import 'dart:math';

import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:sosaku/Conversation/UI_conversation_ConversationScreen.dart';
import 'package:sosaku/SelectAction/Provider_selectAction_SelectActionScreenProvider.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';

import '../Home/UI_home_HomeScreen.dart';
import '../Settings/UI_Setting_SettingScreen.dart';
import '../Wrapper/wrapper_AnimationWidget.dart';
import '../Wrapper/wrapper_TransitionBuilders.dart';
=======
import 'package:sosaku/SelectAction/Provider_selectAction_SelectActionScreenProvider.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';

import '../Wrapper/wrapper_AnimationWidget.dart';
>>>>>>> develop

/// @Fields
///
/// @Methods
/// [start], [selectAyana],[selectNonono],[selectKawamoto],[selectWriting],
/// [selectDrawing],[selectWork]
class SelectActionScreenController {
  SelectActionScreenProvider? _selectActionScreenProvider;
  late BuildContext _context;

  /// TODO : PlayerStateからステータスを取得して代入する
  final Map<String, double> _playerState = {
    'week': 4,
    'money': 50000,
    'Ayana': 20,
    'Nonono': 10,
    'writing': 30,
    'drawing': 15,
  };
  SelectActionScreenController();

  void start(SelectActionScreenProvider selectActionScreenProvider,
      BuildContext context) {
    _selectActionScreenProvider ??= selectActionScreenProvider;
    _context = context;
  }

  void selectWork() {
    double diff = Random().nextInt(3000).toDouble();
    _playerState['money'] = _playerState['money']! + diff;
<<<<<<< HEAD
    statusUp('所持金', diff);
=======
    statusUp({'所持金': diff});
>>>>>>> develop
    // TODO : ステータスアップ
    // TODO : ゲームマネージャーに返す
  }

  void selectAyana() {
    double diff = (Random().nextInt(100) - 50).toDouble();
    _playerState['Ayana'] = _playerState['Ayana']! + diff;
<<<<<<< HEAD
    statusUp('あやな', diff);
=======
    statusUp({'あやな': diff});
>>>>>>> develop
    // TODO : ステータスアップ
    // TODO : ゲームマネージャーに返す
  }

  void selectNonono() {
    double diff = (Random().nextInt(100) - 50).toDouble();
    _playerState['Nonono'] = _playerState['Nonono']! + diff;
<<<<<<< HEAD
    statusUp('ののの', diff);
=======
    statusUp({'ののの': diff});
>>>>>>> develop
    // TODO : ステータスアップ
    // TODO : ゲームマネージャーに返す
  }

  void selectKawamoto() {
    // TODO : 川本との会話へ飛ぶ？
    if (_selectActionScreenProvider != null) {
      if (_selectActionScreenProvider!.isStatus) {
        _selectActionScreenProvider?.setIsStatus(false);
        // TODO : ゲームマネージャーに返す
      } else {
        // ステータス確認画面を表示
        _selectActionScreenProvider?.setPlayerState(_playerState);
        _selectActionScreenProvider?.setIsStatus(true);
      }
    }
  }

  void selectWriting() async {
<<<<<<< HEAD
    double diff = (Random().nextInt(100) - 50).toDouble();
    _playerState['Ayana'] = _playerState['Ayana']! + diff;
    await statusUp('あやな', diff);
    diff = (Random().nextInt(100) - 50).toDouble();
    _playerState['Nonono'] = _playerState['Nonono']! + diff;
    statusUp('ののの', diff);
=======
    double diffAyana = (Random().nextInt(100) - 50).toDouble();
    double diffNonono = (Random().nextInt(100) - 50).toDouble();
    _playerState['Ayana'] = _playerState['Ayana']! + diffAyana;
    _playerState['Nonono'] = _playerState['Nonono']! + diffNonono;
    statusUp({'あやな': diffAyana, 'ののの': diffNonono});
>>>>>>> develop
    // TODO : ステータスアップ
    // TODO : ゲームマネージャーに返す
  }

  void selectDrawing() {
    // TODO : ステータスアップ
    // TODO : ゲームマネージャーに返す
  }

<<<<<<< HEAD
  Future<void> statusUp(String statusName, double value) async {
    print('statusup');
    if (_selectActionScreenProvider != null) {
      _selectActionScreenProvider!.setStatusUpName(statusName);
      _selectActionScreenProvider!.setStatusUpValue(value);
      _selectActionScreenProvider!.setIsStatusUp(true);
    }
    if (value > 0) {
=======
  void statusUp(Map<String, double> statusUps) async {
    String statusName = statusUps.keys.toList()[0];
    _selectActionScreenProvider?.setStatusUpName(statusName);
    _selectActionScreenProvider?.setStatusUpValue(statusUps[statusName]!);
    _selectActionScreenProvider?.setIsStatusUp(true);
    // TODO : if文ビルド待機用遅延
    await Future.delayed(const Duration(milliseconds: 1));
    if (statusUps[statusName]! > 0) {
>>>>>>> develop
      animationController.animate('statusUp', 'arrow', [
        Linear(
            0,
            600,
            GetScreenSize.screenHeight() * 0.6,
            GetScreenSize.screenHeight() * 0.6 +
<<<<<<< HEAD
                GetScreenSize.screenHeight() * 0.05),
      ]);
    } else if (value < 0) {
=======
                GetScreenSize.screenHeight() * 0.05)
      ]);
    } else if (statusUps[statusName]! < 0) {
>>>>>>> develop
      animationController.animate('statusUp', 'arrow', [
        Linear(
          0,
          600,
          GetScreenSize.screenHeight() * 0.6 +
              GetScreenSize.screenHeight() * 0.05,
          GetScreenSize.screenHeight() * 0.6,
<<<<<<< HEAD
        ),
=======
        )
>>>>>>> develop
      ]);
    }

    animationController.animate(
        'statusUp', 'opacity', [Linear(0, 100, 0, 1), Linear(700, 1000, 1, 0)]);
<<<<<<< HEAD
    await Future.delayed(const Duration(milliseconds: 1000));
    _selectActionScreenProvider!.setIsStatusUp(false);
=======

    animationController.setCallbacks('statusUp', {
      'opacity': () {
        _selectActionScreenProvider!.setIsStatusUp(false);
        statusUps.remove(statusName);
        if (statusUps.isNotEmpty) {
          statusUp(statusUps);
        }
      }
    });
    // await Future.delayed(const Duration(milliseconds: 1000));
>>>>>>> develop
  }
}

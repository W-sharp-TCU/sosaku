import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sosaku/Wrapper/wrapper_SoundPlayer.dart';

class GameManager {
  // note: json読み込んで、imageとcv, bgm, seの項目からpre-loadする項目を抽出する
  // note: 次になんの画面を表示するかをSaveDataと他のクラスからのnotifyで決定する
  // note: 読み込むイベントをPlayerDataクラスとランダム発生やべた書きの条件から決定する

  void goNextScreen(BuildContext context) {
    // todo: implement
    throw UnimplementedError();
  }

  Future<Map<String, dynamic>> _loadJson(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);

    // replace <Player> to player's name // todo: 下を書き換える
    jsonString = jsonString.replaceAll('<Player>', "playerName");
    Map<String, dynamic> jsonData = json.decode(jsonString);
    return jsonData;
  }

  Future<void> _preloadAssets(
      BuildContext context,
      List<String> bgImagePaths,
      List<String> characterImagePaths,
      List<String> bgmPaths,
      List<String> cvPaths,
      List<String> sePaths) async {
    // pre-cache sound sources
    // todo: 重複を抜く
    SoundPlayer.loadAll(filePaths: bgmPaths, audioType: SoundPlayer.BGM);
    SoundPlayer.loadAll(filePaths: sePaths, audioType: SoundPlayer.SE);
    SoundPlayer.loadAll(filePaths: cvPaths, audioType: SoundPlayer.CV);

    // pre-cache image sources
    // todo: 重複を抜く
    for (var e in bgImagePaths) {
      await precacheImage(AssetImage(e), context);
    }
    for (var e in characterImagePaths) {
      await precacheImage(AssetImage(e), context);
    }
  }

  void getEventCode() {
    // note: SaveDataクラスから既出のイベントを取得する
    // note: この関数内で条件文をべた書き?
  }
}

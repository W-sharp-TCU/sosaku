import 'package:flutter/cupertino.dart';
import 'package:sosaku/Common/Enum_common_ScreenType.dart';

import '../../Wrapper/wrapper_SharedPref.dart';
import 'Data_common_SaveSlot.dart';
import 'dart:convert';
import 'dart:async';

class SaveManager {
  //int _playingSlotNum = -1;
  late SaveSlot _playingSlot;
  late final List<SaveSlot> _saveSlots;
  static const String _nullValue = "";
  static const String _keyOfSaveData = "saveData";
  //int _timer = 0;
  //bool _isAutoSaveScheduled = false;
  static const int _autoSaveDuration = 180; // sec.
  static const int _saveSlotsLength = 19;
  late Timer _timer;
  static const Map<String, dynamic> _initialSaveData = {
    "lastModified": null,
    "thumbnailPath": null,
    "playerName": null,
    "status": {
      "money": 10000,
      "ayanaLove": 1,
      "ayanaSkill": 1,
      "nononoLove": 1,
      "nononoSkill": 1
    },
    "lastEvent": 1000,
    "conversationControllerInfo": null,
    "lastScreenType": ScreenType.initialLaunch,
    "visitedEventList": [],
    "actionHistory": [],
    "kawamotoAppeared": false
  };

  /// Singleton constructor
  static final SaveManager _myInstance = SaveManager._internalConstructor();
  SaveManager._internalConstructor();
  factory SaveManager() => _myInstance;

  /// "_playingSlot" getter
  SaveSlot get playingSlot => _playingSlot;

  /// "SaveSlots" getter
  List<SaveSlot> get saveSlots => _saveSlots;

  /// Select saveSlot that will be played
  ///
  /// @param [slotNum] : sava slot number of playing data
  void selectSlot(int slotNum) {
    _playingSlot = _saveSlots[slotNum];
  }

  /// Load save data of all slots.
  /// This method should be called before Load Screen appear.
  Future<void> loadAll() async {
    /*
    int numOfSlot = await SharedPref.getInt("numOfSlot", 0);
    for (int i = 0; i < numOfSlot; i++) {
      String jsonData =
          await SharedPref.getString("slot" + i.toString(), _nullValue);
      _saveSlots.add(SaveSlot(this, jsonData));
    }
    */
    String jsonData = await SharedPref.getString(_keyOfSaveData, _nullValue);
    if (jsonData == _nullValue) {
      /*for (int i = 0; i < _saveSlotsLength; i++) {
        _saveSlots[i] = SaveSlot(this, _initialSaveData);
      }*/
      _saveSlots =
          List.filled(_saveSlotsLength, SaveSlot(this, {..._initialSaveData}));
    } else {
      var saveData = jsonDecode(jsonData);
      for (int i = 0; i < _saveSlotsLength; i++) {
        _saveSlots[i] = SaveSlot(this, saveData[i]);
      }
    }
  }

  /// Commit save data stored in "SaveSlot"
  ///
  /// **This method should only be called from SaveSlot.**
  ///
  /// @param [slotNum] : save to save slot of this number
  ///
  /// @param [saveData] : save data that this SaveSlot has. if this value is not passed, this function save "_playingSaveSlot".
  void saveToSlot(int slotNum, [SaveSlot? saveData]) {
    saveData ??= _playingSlot;
    _saveSlots[slotNum] = saveData;
    String jsonData = jsonEncode(_saveSlots);
    SharedPref.setString(_keyOfSaveData, jsonData);
  }

  /// Start auto save timer
  void startSaveTimer() async {
    _timer =
        Timer.periodic(const Duration(seconds: _autoSaveDuration), _onTimer);
  }

  void _onTimer(Timer timer) {
    saveToSlot(0);
  }

  /// Stop auto save timer
  void stopSaveTimer() {
    _timer.cancel();
  }

  /// Copy save data
  ///
  /// @param [from] : copy from save slot of this number
  ///
  /// @param [to] : copy to save slot of this number
  void dataCopy(int from, int to) async {
    /*
    String dataFrom =
        await SharedPref.getString("slot" + from.toString(), _nullValue);
    saveToSlot(dataFrom, to);
     */
    saveToSlot(to, _saveSlots[from]);
  }

  /// Delete save data
  ///
  /// @param [slotNum] : delete save data saved save slot of this number
  void deleteData(int slotNum) {
    _saveSlots[slotNum] = SaveSlot(this, _initialSaveData);
  }

  /// TODO create exportData function
  void exportData(int slotNum) {}

  /// TODO create importData function
  void importData(int slotNum) {}
}

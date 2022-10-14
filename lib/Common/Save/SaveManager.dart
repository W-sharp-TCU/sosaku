//import 'dart:convert';

import 'package:sosaku/Wrapper/wrapper_SharedPref.dart';

class SaveManager{

  late SaveSlot _playingSlot;
  //late int _playingSlotNum;
  late String _jsonData;
  static String _nullData = "";
  int _timer = 0;
  bool _timerSwitch = false;
  static int _autoSaveCycle = 300;//sec


  ///Singleton constructor
  static final SaveManager _myInstance = SaveManager._internalConstructor();
  SaveManager._internalConstructor();
  factory SaveManager() => _myInstance;

  ///"_playingSlot" getter
  SaveSlot get playingSlot=> _playingSlot;

  ///select saveSlot that will be played
  ///
  /// @param slotNum: sava slot number of playing data
  selectSlot(int slotNum)async{
    _jsonData = await SharedPref.getString("slot"+slotNum.toString(), _nullData);
    _playingSlot = SaveSlot(this, _jsonData);
    //_playingSlotNum  = slotNum;
  }

  ///save playing data
  ///
  /// @param data: data of status, event history, and more
  /// @param slotNum: save to save slot of this number
  saveToSlot(String data, int slotNum){
    //slotNum ?? _playingSlotNum;
    SharedPref.setString("slot"+slotNum.toString(), data);
  }

  ///start auto save timer
  void startSaveTimer()async {
    _timer = 0;
    _timerSwitch = true;
    while(_timerSwitch) {
      await Future.delayed(Duration(milliseconds: 10), ()=>_timer+=10);
      if(_autoSaveCycle*1000 <= _timer){
        saveToSlot(_playingSlot._data, 0);
        _timer = 0;
      }
    }
  }

  ///stop auto save timer
  void stopSaveTimer(){
    _timerSwitch = false;
  }

  ///copy save data
  ///
  /// @param from: copy from save slot of this number
  /// @param to: copy to save slot of this number
  void dataCopy(int from, int to)async{
    String dataFrom = await SharedPref.getString("slot"+from.toString(), _nullData);
    saveToSlot(dataFrom, to);
  }

  ///delete save data
  ///
  /// @param slotNum: delete save data saved save slot of this number
  void deleteData(int slotNum){
    saveToSlot(_nullData, slotNum);
  }

  ///TODO create exportData function
  void exportData(int slotNum){

  }

  ///TODO create importData function
  void importData(int slotNum){

  }

}



//it was made provisionally to test.
class SaveSlot{

  SaveManager _saveManager;
  String _data;
  //int _slotNum;

  SaveSlot(this._saveManager, this._data);

  String get data => _data;
  set data(String s) => _data = s;

  void commit(int saveSlotNum){
    //saveSlotNum ??= _slotNum;
    _saveManager.saveToSlot(_data, saveSlotNum);
  }

}
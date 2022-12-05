import '../../Wrapper/wrapper_SharedPref.dart';
import 'SaveSlot.dart';

class SaveManager {
  int _playingSlotNum = -1;
  final List<SaveSlot> _saveSlots = [];
  static const String _nullValue = "";
  int _timer = 0;
  bool _timerSwitch = false;
  static const int _autoSaveDuration = 300; // sec.

  ///Singleton constructor
  static final SaveManager _myInstance = SaveManager._internalConstructor();
  SaveManager._internalConstructor();
  factory SaveManager() => _myInstance;

  ///"_playingSlot" getter
  SaveSlot get playingSlot => _saveSlots[_playingSlotNum];

  ///select saveSlot that will be played
  ///
  /// @param slotNum: sava slot number of playing data
  void selectSlot(int slotNum) {
    _playingSlotNum = slotNum;
  }

  /// Load save data of all slots.
  /// This method is called before Load Screen appear.
  void loadAll() async {
    int numOfSlot = await SharedPref.getInt("numOfSlot", 0);
    for (int i = 0; i < numOfSlot; i++) {
      String jsonData =
          await SharedPref.getString("slot" + i.toString(), _nullValue);
      _saveSlots.add(SaveSlot(this, jsonData));
    }
  }

  ///save playing data
  ///
  /// @param data: data of status, event history, and more
  /// @param slotNum: save to save slot of this number
  void saveToSlot(String data, int slotNum) {
    //slotNum ?? _playingSlotNum;
    SharedPref.setString("slot" + slotNum.toString(), data);
  }

  ///start auto save timer
  void startSaveTimer() async {
    _timer = 0;
    _timerSwitch = true;
    while (_timerSwitch) {
      await Future.delayed(
          const Duration(milliseconds: 10), () => _timer += 10);
      if (_autoSaveDuration * 1000 <= _timer) {
        // saveToSlot(_playingSlot._data, 0);
        playingSlot.commit(0);
        _timer = 0;
      }
    }
  }

  ///stop auto save timer
  void stopSaveTimer() {
    _timerSwitch = false;
  }

  ///copy save data
  ///
  /// @param from: copy from save slot of this number
  /// @param to: copy to save slot of this number
  void dataCopy(int from, int to) async {
    String dataFrom =
        await SharedPref.getString("slot" + from.toString(), _nullValue);
    saveToSlot(dataFrom, to);
  }

  ///delete save data
  ///
  /// @param slotNum: delete save data saved save slot of this number
  void deleteData(int slotNum) {
    saveToSlot(_nullValue, slotNum);
  }

  ///TODO create exportData function
  void exportData(int slotNum) {}

  ///TODO create importData function
  void importData(int slotNum) {}
}

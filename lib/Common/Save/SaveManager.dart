import '../../Wrapper/wrapper_SharedPref.dart';
import 'SaveSlot.dart';

class SaveManager {
  int _playingSlotNum = -1;
  final List<SaveSlot> _saveSlots = [];
  static const String _nullValue = "";
  int _timer = 0;
  bool _isAutoSaveScheduled = false;
  static const int _autoSaveDuration = 180; // sec.

  /// Singleton constructor
  static final SaveManager _myInstance = SaveManager._internalConstructor();
  SaveManager._internalConstructor();
  factory SaveManager() => _myInstance;

  /// "_playingSlot" getter
  SaveSlot get playingSlot => _saveSlots[_playingSlotNum];

  /// Select saveSlot that will be played
  ///
  /// @param [slotNum] : sava slot number of playing data
  void selectSlot(int slotNum) {
    _playingSlotNum = slotNum;
  }

  /// Load save data of all slots.
  /// This method should be called before Load Screen appear.
  void loadAll() async {
    int numOfSlot = await SharedPref.getInt("numOfSlot", 0);
    for (int i = 0; i < numOfSlot; i++) {
      String jsonData =
          await SharedPref.getString("slot" + i.toString(), _nullValue);
      _saveSlots.add(SaveSlot(this, jsonData));
    }
  }

  /// Save current playing data
  ///
  /// **This method should only be called from SaveSlot.**
  ///
  /// @param [data] : Save data such as current status, event history, and more.
  ///    The value must be JSON encoded.
  ///
  /// @param [slotNum] : save to save slot of this number
  void saveToSlot(String data, int slotNum) {
    //slotNum ?? _playingSlotNum;
    SharedPref.setString("slot" + slotNum.toString(), data);
  }

  /// Start auto save timer
  void startSaveTimer() async {
    // todo: 書き換えお願いします To: Kentaro.T
    // --- 以下説明 ---
    // _isAutoSaveScheduledがtrueのとき、playingSlot.commit(0) が一定時間ごとに実行される。
    // オートセーブする周期は_autoSaveDurationで定義されている(10行目参照)
    // _timerは、前回のセーブから何ミリ秒経ったかを記録しているだけなので、消しても大丈夫かと
    // 消すときは8行目の定義も消しといてくれると助かります m(._.)m
    // startSaveTimer()とstopSaveTimer()は、まだどこのクラスでも呼び出されていないので関数消したり、ガッツリ変えて大丈夫です。
    _timer = 0;
    _isAutoSaveScheduled = true;
    while (_isAutoSaveScheduled) {
      await Future.delayed(
          const Duration(milliseconds: 10), () => _timer += 10);
      if (_autoSaveDuration * 1000 <= _timer) {
        playingSlot.commit(0);
        _timer = 0;
      }
    }
  }

  /// Stop auto save timer
  void stopSaveTimer() {
    _isAutoSaveScheduled = false;
  }

  /// Copy save data
  ///
  /// @param [from] : copy from save slot of this number
  ///
  /// @param [to] : copy to save slot of this number
  void dataCopy(int from, int to) async {
    String dataFrom =
        await SharedPref.getString("slot" + from.toString(), _nullValue);
    saveToSlot(dataFrom, to);
  }

  /// Delete save data
  ///
  /// @param [slotNum] : delete save data saved save slot of this number
  void deleteData(int slotNum) {
    saveToSlot(_nullValue, slotNum);
  }

  /// TODO create exportData function
  void exportData(int slotNum) {}

  /// TODO create importData function
  void importData(int slotNum) {}
}

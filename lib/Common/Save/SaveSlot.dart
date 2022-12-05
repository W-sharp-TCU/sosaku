import 'dart:convert';
import 'SaveManager.dart';

class SaveSlot {
  late SaveManager _saveManager;
  Map<String, dynamic> _data = {};
  SaveSlot(SaveManager managerInstance, String jsonData) {
    _saveManager = managerInstance;
    _data = jsonDecode(jsonData);
  }

  void commit(int dataNum) {
    String jsonData = jsonEncode(_data);
    _saveManager.saveToSlot(jsonData, dataNum);
  }

  String get lastModified {
    if (_data.containsKey("lastModified")) {
      return _data["lastModified"];
    } else {
      return "";
    }
  }

  set lastModified(String lastModified) => _data["lastModified"] = lastModified;

  String get thumbnailPath => _data["thumbnailPath"];
  set thumbnailPath(String thumbnailPath) =>
      _data["thumbnailPath"] = thumbnailPath;

  String get playerName => _data["playerName"];
  set playerName(String playerName) => _data["playerName"] = playerName;

  List<int> get status => _data["status"];
  set status(List<int> status) => _data["status"] = status;

  int get lastChapter => _data["lastChapter"];
  set lastChapter(int chapterNumber) => _data["lastChapter"] = chapterNumber;

  int get lastWeek => _data["lastWeek"];
  set lastWeek(int lastWeek) => _data["lastWeek"] = lastWeek;

  Type get lastScreenType => _data["lastScreenType"];
  set lastScreenType(Type lastScreenType) =>
      _data["lastScreenType"] = lastScreenType;

  Set get visitedEventList => _data["localVisitedEventList"];
  void addVisitedEventList(List<int> eventList) {
    List originalList = visitedEventList.toList();
    originalList.addAll(eventList);
    _data["localVisitedEventList"] = originalList.toSet();
  }

  Set get actionHistory => _data["actionHistory"];
  void setActionHistory(List<int> actionHistory) {
    List originalList = actionHistory.toList();
    originalList.addAll(actionHistory);
    _data["actionHistory"] = originalList.toSet();
  }
}

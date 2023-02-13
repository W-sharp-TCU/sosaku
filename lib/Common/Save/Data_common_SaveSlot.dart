import 'dart:convert';
import 'Data_common_SaveManager.dart';

class SaveSlot {
  late SaveManager _saveManager;
  Map<String, dynamic> _data = {};
  SaveSlot(SaveManager managerInstance, String jsonData) {
    _saveManager = managerInstance;
    _data = jsonDecode(jsonData);
  }

  /*
  void commit(int dataNum) {
    String jsonData = jsonEncode(_data);
    _saveManager.saveToSlot(jsonData, dataNum);
  }
*/
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

  /*******************************************************************/

  int get money => _data["money"];
  set money(int money) => _data["money"] = money;

  double get ayanaLove => _data["ayanaLove"];
  void addAyanaLove(double ayanaLove){
    ayanaLove = ayanaLove * ayanaLove; // 数値変換の式はこちら
    _data["ayanaLove"] = ayanaLove;
  }

  double get nononoLove => _data["nononoLove"];
  void addNononoLove(double nononoLove, double paintingSkills){
    nononoLove = paintingSkills + nononoLove * nononoLove; // 数値変換の式はこちら
    _data["nononoLove"] = nononoLove;
  }

  double get writingSkills => _data["writingSkills"];
  void addWritingSkills(double writingSkills){
    writingSkills = writingSkills * writingSkills; // 数値変換の式はこちら
    _data["writingSkills"] = writingSkills;
  }

  double get paintingSkills => _data["paintingSkills"];
  void addPaintingSkills(double paintingSkills){
    paintingSkills = paintingSkills * paintingSkills; // 数値変換の式はこちら
    _data["paintingSkills"] = paintingSkills;
  }
  /***************************************************************************/


  //int get lastChapter => _data["lastChapter"];
  //set lastChapter(int chapterNumber) => _data["lastChapter"] = chapterNumber;
  int get lastEvent => _data["lastEvent"];
  set lastEvent(int lastEvent) => _data["lastEvent"] = lastEvent;

  //int get lastCode => _data["lastCode"];
  //set lastCode(int lastCode) => _data["lastCode"] = lastCode;

  int get lastWeek => _data["lastWeek"];
  set lastWeek(int lastWeek) => _data["lastWeek"] = lastWeek;

  bool get isHelp => _data["isHelp"];
  set isHelp(bool isHelp) => _data["isHelp"] = isHelp;

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
  void addActionHistory(List<int> actionHistory) {
    List originalList = actionHistory.toList();
    originalList.addAll(actionHistory);
    _data["actionHistory"] = originalList.toSet();
  }

  Map<String, dynamic> get conversationControllerInfo => _data["conversationControllerInfo"];
  set conversationControllerInfo(Map<String,dynamic> conversationControllerInfo) => _data["conversationControllerInfo"] = conversationControllerInfo;


}

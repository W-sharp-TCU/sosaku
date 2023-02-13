import 'package:sosaku/Common/Save/Data_common_SaveManager.dart';
import 'package:sosaku/Common/Save/Data_common_SaveSlot.dart';

class StatusCalculator{
  /*
  /// Singleton constructor
  static final StatusCalculator _myInstance = StatusCalculator._internalConstructor();
  StatusCalculator._internalConstructor();
  factory StatusCalculator() => _myInstance;
  */

  final SaveSlot _saveSlot = SaveManager().playingSlot;

  void addAyanaLove(int ayanaLove){
    //ayanaLove = ayanaLove * ayanaLove; // 数値変換の式はこちら
    _saveSlot.ayanaLove = ayanaLove;
  }

  void addNononoLove(int nononoLove){
    //nononoLove = nononoLove * nononoLove; // 数値変換の式はこちら
    _saveSlot.nononoLove = nononoLove;
  }

  void addWritingSkills(int writingSkills){
    //writingSkills = writingSkills * writingSkills; // 数値変換の式はこちら
    _saveSlot.writingSkills = writingSkills;
  }

  void addPaintingSkills(int paintingSkills){
    //paintingSkills = paintingSkills * paintingSkills; // 数値変換の式はこちら
    _saveSlot.paintingSkills = paintingSkills;
  }

}


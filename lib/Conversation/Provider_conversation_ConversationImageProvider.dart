import 'package:flutter/cupertino.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';

import '../Wrapper/wrapper_AnimationWidget.dart';
import 'Animation_conversation_ConversationAnimation.dart';

class ConversationImageProvider extends ChangeNotifier {
  String _mBGImagePath = 'drawable/Conversation/black_screen.png';
  String _characterImagePath = 'drawable/Conversation/no_character.png';
  String? _voicePath;
  String _characterName = '';

  /// {text, goto}
  List<Map> _selections = [];
  bool _isAuto = false;
  bool _isSelection = false;
  bool _isMenu = false;
  bool _isLog = false;
  bool _isHideUi = false;
  bool _isDim = false;
  bool _canNext = false;
  bool _isSleep = false;

  String get mBGImagePath => _mBGImagePath;
  String get characterImagePath => _characterImagePath;
  String? get voicePath => _voicePath;
  String get characterName => _characterName;
  List<Map> get selections => _selections;
  bool get isAuto => _isAuto;
  bool get isSelection => _isSelection;
  bool get isMenu => _isMenu;
  bool get isLog => _isLog;
  bool get isHideUi => _isHideUi;
  bool get isDim => _isDim;
  bool get canNext => _canNext;
  bool get isSleep => _isSleep;

  /// Set character image.
  /// This function is for Controller.
  void setBGImage(String path) {
    _mBGImagePath = path;
    notifyListeners();
  }

  /// Set character image.
  /// This function is for Controller.
  void setCharacterImage(String path) {
    _characterImagePath = path;
    notifyListeners();
  }

  /// Set character voice.
  /// This function is for Controller.
  void setVoicePath(String? path) {
    _voicePath = path;
  }

  /// Set character image.
  /// This function is for Controller.
  void setCharacterName(String characterName) {
    _characterName = characterName;
    notifyListeners();
  }

  /// Set a list of optionTexts.
  /// This function is for Controller.
  ///
  /// @param optionTexts : list of text to be displayed in the options.
  void setSelections(List<Map> selections) {
    _selections = selections;
    notifyListeners();
  }

  void addSelections(Map selections) {
    _selections.add(selections);
    notifyListeners();
  }

  /// Change auto play.
  /// This function is for Controller.
  void setIsAuto(bool isAuto) {
    _isAuto = isAuto;
    notifyListeners();
  }

  /// Change the display of the option dialog.
  /// This function is for Controller.
  void setIsSelection(bool isSelection) {
    _isSelection = isSelection;
    _isDim = _isSelection || _isMenu || _isLog;
    notifyListeners();
  }

  /// Change the display of the menu dialog.
  /// This function is for Controller.
  void setIsMenu(bool isMenu) {
    _isMenu = isMenu;
    _isDim = _isSelection || _isMenu || _isLog;
    notifyListeners();
  }

  /// Change the log screen display.
  /// This function is for Controller and UI.
  void setIsLog(bool isLog) {
    _isLog = isLog;
    _isDim = _isSelection || _isMenu || _isLog;
    notifyListeners();
  }

  /// Change the UI display.
  /// This function is for Controller and UI.
  void setIsHideUi(bool isHideUi) {
    if (_isHideUi != isHideUi && isHideUi == false) {
      ConversationAnimation.triangle();
      ConversationAnimation.selection(selections.length);
    }
    _isHideUi = isHideUi;
    _isDim = (_isSelection && !_isHideUi) || _isMenu || _isLog;
    notifyListeners();
  }

  /// set the dim of screen.
  /// This function is for Controller.
  void setDim(bool isDim) {
    _isDim = isDim;
    notifyListeners();
  }

  void setCanNext(bool canNext) {
    if (_canNext != canNext && canNext == true) {
      ConversationAnimation.triangle();
    }
    _canNext = canNext;
    notifyListeners();
  }

  void setIsSleep(bool isSleep) {
    _isSleep = isSleep;
    notifyListeners();
  }
}

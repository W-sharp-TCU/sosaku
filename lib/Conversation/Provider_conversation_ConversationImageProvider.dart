import 'package:flutter/cupertino.dart';

class ConversationImageProvider extends ChangeNotifier {
  String _mBGImagePath = "drawable/Conversation/black_screen.png";
  String _characterImagePath = "drawable/Conversation/no_character.png";
  String _characterName = "";
  List<String> _optionTexts = [];
  bool _isAuto = false;
  bool _dialogFlag = false;
  bool _isMenu = false;
  bool _isLog = false;
  bool _isHideUi = false;
  bool _isDim = false;

  String get mBGImagePath => _mBGImagePath;
  String get characterImagePath => _characterImagePath;
  String get characterName => _characterName;
  List<String> get optionTexts => _optionTexts;
  bool get isAuto => _isAuto;
  bool get dialogFlag => _dialogFlag;
  bool get isMenu => _isMenu;
  bool get isLog => _isLog;
  bool get isHideUi => _isHideUi;
  bool get isDim => _isDim;

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
  void setOptionTexts(List<String> optionTexts) {
    _optionTexts = optionTexts;
    notifyListeners();
  }

  /// Change auto play.
  /// This function is for Controller.
  void changeAuto() {
    _isAuto = !_isAuto;
    notifyListeners();
  }

  /// Change the display of the option dialog.
  /// This function is for Controller.
  void changeDialogFlag() {
    _dialogFlag = !_dialogFlag;
    _isDim = _dialogFlag || _isMenu || _isLog;
    notifyListeners();
  }

  /// Change the display of the menu dialog.
  /// This function is for Controller.
  void changeMenuDisplay() {
    _isMenu = !_isMenu;
    _isDim = _dialogFlag || _isMenu || _isLog;
    notifyListeners();
  }

  /// Change the log screen display.
  /// This function is for Controller and UI.
  void changeLogDisplay() {
    _isLog = !_isLog;
    _isDim = _dialogFlag || _isMenu || _isLog;
    notifyListeners();
  }

  /// Change the UI display.
  /// This function is for Controller and UI.
  void changeHideUi() {
    _isHideUi = !_isHideUi;
    _isDim = (_dialogFlag && !_isHideUi) || _isMenu || _isLog;
    notifyListeners();
  }

  /// set the dim of screen.
  /// This function is for Controller.
  void setDim(bool isDim) {
    _isDim = isDim;
    notifyListeners();
  }
}

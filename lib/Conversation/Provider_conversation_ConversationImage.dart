import 'package:flutter/cupertino.dart';
import 'package:sosaku/Conversation/Contoroller_conversation_ConversationScreen.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationText.dart';

class ConversationImageProvider extends ChangeNotifier {
  String _mBGImagePath = "drawable/Load/default.jpg";
  String _characterImagePath = "drawable/Load/default.jpg";
  String _characterName = "";
  List<String> _optionTexts = [];
  bool _dialogFlag = false;
  bool _isHideUi = false;
  bool _isLogDisplay = false;

  String get mBGImagePath => _mBGImagePath;
  String get characterImagePath => _characterImagePath;
  String get characterName => _characterName;
  List<String> get optionTexts => _optionTexts;
  bool get dialogFlag => _dialogFlag;
  bool get isHideUi => _isHideUi;
  bool get isLogDisplay => _isLogDisplay;

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
  ///  This function is for Controller.
  void setCharacterName(String characterName) {
    _characterName = characterName;
    notifyListeners();
  }

  ///　Set a list of optionTexts.
  /// This function is for Controller.
  ///
  /// @param optionTexts : list of text to be displayed in the options.
  void setOptionTexts(List<String> optionTexts) {
    _optionTexts = optionTexts;
    notifyListeners();
  }

  /// Change the display of the option dialog.
  /// This function is for Controller.
  void changeDialogFlag() {
    _dialogFlag = !_dialogFlag;
    notifyListeners();
  }

  /// Change the UI display.
  /// This function is for Controller and UI.
  void changeHideUi() {
    _isHideUi = !_isHideUi;
    notifyListeners();
  }

  /// Change the log screen display.
  /// This function is for Controller and UI.
  void changeLogDisplay() {
    _isLogDisplay = !_isLogDisplay;
    notifyListeners();
  }
}

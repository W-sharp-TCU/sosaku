import 'package:flutter/cupertino.dart';

class ConversationLogProvider extends ChangeNotifier {
  // List<int> _codes = [];
  List<String> _names = [];
  List<String> _iconPaths = [];
  List<String> _texts = [];
  List<String?> _voicePaths = [];
  List<bool> _isPlaying = [];

  // List<int> get codes => _codes;
  List<String> get names => _names;
  List<String> get iconPaths => _iconPaths;
  List<String> get texts => _texts;
  List<String?> get voicePaths => _voicePaths;
  List<bool> get isPlaying => _isPlaying;

  // /// Set the codes for log management.
  // /// This function is for Controller.
  // ///
  // /// @param codes : The codes to for log management.
  // void setCodes(List<int> codes) {
  //   // _codes = codes;
  //   notifyListeners();
  // }

  /// Set the names to be displayed in the log.
  /// This function is for Controller.
  ///
  /// @param names : The names to be displayed in the log.
  void setNames(List<String> names) {
    _names = names;
    notifyListeners();
  }

  /// Set the paths of character icon to be displayed in the log.
  /// This function is for Controller.
  ///
  /// @param iconPaths : The paths of character icon to be displayed in the log.
  void setIconPaths(List<String> iconPaths) {
    _iconPaths = iconPaths;
    notifyListeners();
  }

  /// Set the texts to be displayed in the log.
  /// This function is for Controller.
  ///
  /// @param texts : The texts to be displayed in the log.
  void setTexts(List<String> texts) {
    _texts = texts;
    notifyListeners();
  }

  void setVoicePaths(List<String?> voicePaths) {
    _voicePaths = voicePaths;
    notifyListeners();
  }

  /// Set the playback states of character voice for log.
  /// This function is for Controller.
  ///
  /// @param playingStates : The playback states of character voice.
  void setIsPlaying(List<bool> playingStates) {
    _isPlaying = playingStates;
    notifyListeners();
  }

  Map<String, dynamic> save() {
    Map<String, dynamic> saveData = {};
    saveData['names'] = _names;
    saveData['iconPaths'] = _iconPaths;
    saveData['texts'] = _texts;
    saveData['voicePaths'] = _voicePaths;
    return saveData;
  }

  void load(Map<String, dynamic> saveData) {
    _names = saveData['names'];
    _iconPaths = saveData['iconPaths'];
    _texts = saveData['texts'];
    _voicePaths = saveData['voicePaths'];
    notifyListeners();
  }

  void reset() {
    _names = [];
    _iconPaths = [];
    _texts = [];
    _voicePaths = [];
    _isPlaying = [];
  }
}

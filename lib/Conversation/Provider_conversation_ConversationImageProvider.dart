import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Conversation/Provider_conversation_ConversationImageLayerProvider.dart';
import 'package:sosaku/Wrapper/wrapper_GetScreenSize.dart';
import 'Animation_conversation_ConversationAnimation.dart';

class ConversationImageProvider extends ChangeNotifier {
  String _characterImagePath = 'assets/drawable/Conversation/no_character.png';
  String? _voicePath;
  String _characterName = '';

  List<ConversationBGLayerProvider> bgLayers = [];
  List<ConversationCharacterLayerProvider> characterLayers = [];
  List<ConversationImageLayerProvider> imageLayers = [];

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
  bool _isNarration = false;

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
  bool get isNarration => _isNarration;
  bool get isAnimation =>
      characterLayers.any((element) => element.isAnimation) ||
      bgLayers.any((element) => element.isAnimation) ||
      imageLayers.any((element) => element.isAnimation);

  ConversationCharacterLayerProvider? characterLayer(String layerId) {
    for (var layer in characterLayers) {
      if (layer.layerId == layerId) {
        return layer;
      }
    }
    return null;
  }

  ConversationBGLayerProvider? bgLayer(String layerId) {
    for (var layer in bgLayers) {
      if (layer.layerId == layerId) {
        return layer;
      }
    }
    return null;
  }

  ConversationImageLayerProvider? imageLayer(String layerId) {
    for (var layer in imageLayers) {
      if (layer.layerId == layerId) {
        return layer;
      }
    }
    return null;
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

  void setIsNarration(bool isNarration) {
    _isNarration = isNarration;
    notifyListeners();
  }

  void reset() {
    _characterImagePath = 'assets/drawable/Conversation/no_character.png';
    _voicePath;
    _characterName = '';

    bgLayers = [];
    characterLayers = [];
    imageLayers = [];

    /// {text, goto}
    _selections = [];
    _isAuto = false;
    _isSelection = false;
    _isMenu = false;
    _isLog = false;
    _isHideUi = false;
    _isDim = false;
    _canNext = false;
    _isSleep = false;
    _isNarration = false;
  }
}

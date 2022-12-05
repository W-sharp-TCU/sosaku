import 'package:flutter/widgets.dart';
import 'Controller_Settings_SettingsController.dart';

SettingsController settingsController = SettingsController();

class SettingsProvider extends ChangeNotifier {
  SettingsProvider() : super() {
    this.setAllValue();
  }
  double _textSliderValue = settingsController.textSpeed;
  double _voiceSliderValue = settingsController.CvVolume;
  double _bgmSliderValue = settingsController.BgmVolume;
  double _uiSliderValue = settingsController.UiVolume;
  double _asSliderValue = settingsController.AsVolume;
  double get textSliderValue => _textSliderValue;
  double get voiceSliderValue => _voiceSliderValue;
  double get bgmSliderValue => _bgmSliderValue;
  double get uiSliderValue => _uiSliderValue;
  double get asSliderValue => _asSliderValue;

  void setAllValue() async {
    _textSliderValue = await settingsController.getTextSpeedValue();
    _voiceSliderValue = await settingsController.getVoiceVolumeValue();
    _bgmSliderValue = await settingsController.getBgmVolumeValue();
    _uiSliderValue = await settingsController.getUiVolumeValue();
    _asSliderValue = await settingsController.getAsVolumeValue();
    notifyListeners();
  }

  void setTextSliderValue(double value) {
    _textSliderValue = value;
    settingsController.setTextSpeedValue(value);
    notifyListeners();
  }

  void setBGMSliderValue(double value) {
    _bgmSliderValue = value;
    settingsController.setBgmVolumeValue(value);
    notifyListeners();
  }

  void setVoiceSliderValue(double value) {
    _voiceSliderValue = value;
    settingsController.setVoiceVolumeValue(value);
    notifyListeners();
  }

  void setUiSliderValue(double value) {
    _uiSliderValue = value;
    settingsController.setUiVolumeValue(value);
    notifyListeners();
  }

  void setAsSliderValue(double value) {
    _asSliderValue = value;
    settingsController.setAsVolumeValue(value);
    notifyListeners();
  }
}

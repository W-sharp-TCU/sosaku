import 'package:sosaku/Wrapper/wrapper_SharedPref.dart';
import '../Wrapper/wrapper_SoundPlayer.dart';

class SettingsController {
  double textSpeed = 1.0;
  double BgmVolume = 5.0;
  double CvVolume = 5.0;
  double UiVolume = 5.0;
  double AsVolume = 5.0;

  Future<double> getTextSpeedValue() async {
    double _textSpeedValue = await SharedPref.getDouble('textSpeed', 1.0);
    textSpeed = _textSpeedValue;
    return _textSpeedValue;
  }

  Future<double> getVoiceVolumeValue() async {
    double _voiceVolumeValue = await SharedPref.getDouble('voiceVolume', 5.0);
    SoundPlayer().cvVolume = _voiceVolumeValue / 10;
    CvVolume = _voiceVolumeValue;
    return _voiceVolumeValue;
  }

  Future<double> getBgmVolumeValue() async {
    double _bgmVolumeValue = await SharedPref.getDouble('bgmVolume', 5.0);
    SoundPlayer().bgmVolume = _bgmVolumeValue / 10;
    BgmVolume = _bgmVolumeValue;
    return _bgmVolumeValue;
  }

  Future<double> getAsVolumeValue() async {
    double _asVolumeValue = await SharedPref.getDouble('asVolume', 5.0);
    SoundPlayer().asVolume = _asVolumeValue / 10;
    AsVolume = _asVolumeValue;
    return _asVolumeValue;
  }

  Future<double> getUiVolumeValue() async {
    double _uiVolumeValue = await SharedPref.getDouble('uiVolume', 5.0);
    SoundPlayer().uiVolume = _uiVolumeValue / 10;
    UiVolume = _uiVolumeValue;
    return _uiVolumeValue;
  }

  Future<double> getSeVolumeValue() async {
    getAsVolumeValue();
    return getBgmVolumeValue();
  }

  void setTextSpeedValue(double value) {
    SharedPref.setDouble('textSpeed', value);
    textSpeed = value;
  }

  void setVoiceVolumeValue(double value) {
    SharedPref.setDouble('voiceVolume', value);
    SoundPlayer().cvVolume = value / 10;
    CvVolume = value;
  }

  void setBgmVolumeValue(double value) {
    SharedPref.setDouble('bgmVolume', value);
    SoundPlayer().bgmVolume = value / 10;
    BgmVolume = value;
  }

  void setAsVolumeValue(double value) {
    SharedPref.setDouble('asVolume', value);
    SoundPlayer().asVolume = value / 10;
    AsVolume = value;
  }

  void setUiVolumeValue(double value) {
    SharedPref.setDouble('uiVolume', value);
    SoundPlayer().uiVolume = value / 10;
    UiVolume = value;
  }

  void setSeVolumeValue(double value) {
    setBgmVolumeValue(value);
    setAsVolumeValue(value);
  }
}

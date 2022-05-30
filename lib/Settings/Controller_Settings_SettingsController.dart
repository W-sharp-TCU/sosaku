import 'package:sosaku/Wrapper/wrapper_SharedPref.dart';

import '../Wrapper/wrapper_SoundPlayer.dart';

class SettingsController {
  //int volume;
  //set volume() {}

  Future<double> getTextSpeedValue() async {
    double _textSpeedValue = await SharedPref.getDouble('textSpeed', 1);
    return _textSpeedValue;
  }

  Future<double> getVoiceVolumeValue() async {
    double _voiceVolumeValue = await SharedPref.getDouble('voiceVolume', 5);
    SoundPlayer.cvVolume = _voiceVolumeValue / 10;
    return _voiceVolumeValue;
  }

  Future<double> getBgmVolumeValue() async {
    double _bgmVolumeValue = await SharedPref.getDouble('bgmVolume', 5);
    SoundPlayer.bgmVolume = _bgmVolumeValue / 10;
    SoundPlayer.seVolume = _bgmVolumeValue / 10;
    return _bgmVolumeValue;
  }

  Future<double> getSeVolumeValue() async {
    double _seVolumeValue = await SharedPref.getDouble('seVolume', 5);
    SoundPlayer.uiVolume = _seVolumeValue / 10;
    return _seVolumeValue;
  }

  void setTextSpeedValue(double value) {
    SharedPref.setDouble('textSpeed', value);
  }

  void setVoiceVolumeValue(double value) {
    SharedPref.setDouble('voiceVolume', value);
    SoundPlayer.cvVolume = value / 10;
  }

  void setBgmVolumeValue(double value) {
    SharedPref.setDouble('bgmVolume', value);
    SoundPlayer.bgmVolume = value / 10;
    SoundPlayer.seVolume = value / 10;
  }

  void setSeVolumeValue(double value) {
    SharedPref.setDouble('seVolume', value);
    SoundPlayer.uiVolume = value / 10;
  }
}

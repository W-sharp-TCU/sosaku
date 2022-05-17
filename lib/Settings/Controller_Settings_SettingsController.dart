import 'package:sosaku/Wrapper/wrapper_SharedPref.dart';

class SettingsController {
  double _textSliderValue = 1;
  double _voiceSliderValue = 5;
  double _bgmSliderValue = 5;
  double _seSliderValue = 5;
  double _textSpeedValue = SharedPref.getDouble('textSpeed', 1) as double;
  double _voiceVolumeValue = SharedPref.getDouble('voiceVolume', 5) as double;
  double _bgmVolumeValue = SharedPref.getDouble('bgmVolume', 5) as double;
  double _seVolumeValue = SharedPref.getDouble('seVolume', 5) as double;
}

import 'package:audioplayers/audioplayers.dart';

class AudioMixer {
  /* interface */
  static const int UI = 0; // UI audio (e.g sound played when button is pushed.)
  static const int BGM = 1; // Back Ground Music audio
  static const int SE = 2; // Sound Effect audio
  static const int CV = 3; // Character Voice audio

  /* config */
  static List<double> _volumes = [1.0, 1.0, 1.0, 1.0];

  /// Fade-in or fade-out effect takes [_fadeDuration] milli seconds.
  /// So, fade transition (fade-out then fade-in) takes [_fadeDuration]*2 milli seconds.
  static const int _fadeDuration = 1500; // [ms]

  static AudioMixer? _instance; // reference to the instance of this class.

  /* instance variances */
  AudioCache _ui = AudioCache(
      prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
  AudioCache _bgm = AudioCache(
      prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
  List<AudioCache> _se = [];
  List<String> _seFilePath = [];
  List<AudioCache> _cv = [];
  List<String> _cvFilePath = [];

  // todo: bgm, se, as, cvの実装
  // todo: state
  // todo: フェード
  // todo: load改善
  // todo: pause(), resume()

  /// Make instance of this class.
  /// This function must be called first.
  static void init() => _instance ??= AudioMixer._makeInstance();

  /// Dispose instance of this class.
  static void dispose() => _instance = null;

  /// Load audio files to [AudioCache] class.
  ///
  /// @param filePaths : Specify list of audio file path you want to load.
  /// @param audioType : Specify any one of below options depends on files you load.
  ///        Option : AudioMixer.UI, AudioMixer.BGM, AudioMixer.SE, AudioMixer.CV
  static void loadAll(
      {required List<String> filePaths, required int audioType}) {
    _instanceExistenceCheck();
    switch (audioType) {
      case UI:
        _instance!._ui = AudioCache(
            prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
        _instance!._ui.loadAll(filePaths);
        break;
      case BGM:
        _instance!._bgm = AudioCache(
            prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
        _instance!._bgm.loadAll(filePaths);
        break;
      case SE:
        for (int i = 0; i < filePaths.length; i++) {
          _instance!._se.add(AudioCache(
              prefix: '',
              fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY)));
          _instance!._se[i].load(filePaths[i]);
          _instance!._seFilePath.add(filePaths[i]);
        }
        break;
      case CV:
        for (int i = 0; i < filePaths.length; i++) {
          _instance!._cv.add(AudioCache(
              prefix: '',
              fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY)));
          _instance!._cv[i].load(filePaths[i]);
          _instance!._cvFilePath.add(filePaths[i]);
        }
        break;
      default:
        throw AssertionError("AudioMixer: unexpected audioType.\n"
            "Specify 'UI', 'BGM', 'SE' or 'CV' to audioType.");
    }
  }

  /// Play UI audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.UI].
  ///
  /// @param filePath : Specify audio file path you want to play.
  static void playUI(String filePath) {
    _instanceExistenceCheck();
    var a = _instance!._ui.play(filePath);
  }

  /// Play BGM audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.BGM].
  ///
  /// @param filePath : Specify audio file path you want to play.
  static void playBGM(String filePath, {bool loop = false}) {
    _instanceExistenceCheck();
    if (loop) {
      _instance!._bgm.loop(filePath);
    } else {
      _instance!._bgm.play(filePath);
    }
  }

  /// Play SE audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.SE].
  ///
  /// @param filePath : Specify audio file path you want to play.
  static void playSE(String filePath) {
    _instanceExistenceCheck();
    int index = _instance!._seFilePath.indexOf(filePath);
    _instance!._se[index].play(filePath);
  }

  /// Play CV audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.CV].
  ///
  /// @param filePath : Specify audio file path you want to play.
  static void playCV(String filePath) {
    _instanceExistenceCheck();
    int index = _instance!._cvFilePath.indexOf(filePath);
    _instance!._cv[index].play(filePath);
  }

  Future<void> _fadeOut(AudioPlayer audioPlayer, int audioType) async {
    double originalVolume = _volumes[audioType];
  }

  static void _instanceExistenceCheck() {
    if (_instance == null) {
      throw AssertionError("AudioMixer: Instance does not exist.\n"
          "Call AudioMixer.getInstance() first to make instance.");
    }
  }

  /* getters & setters */
  static double get uiVolume => _volumes[UI];
  static double get bgmVolume => _volumes[BGM];
  static double get seVolume => _volumes[SE];
  static double get cvVolume => _volumes[CV];

  static set uiVolume(double value) {
    if (value > 1.0) {
      _volumes[UI] = 1.0;
    } else if (value < 0) {
      _volumes[UI] = 0.0;
    } else {
      _volumes[UI] = value;
    }
  }

  static set bgmVolume(double value) {
    _volumes[BGM] = value;
  }

  static set seVolume(double value) {
    _volumes[SE] = value;
  }

  static set cvVolume(double value) {
    _volumes[CV] = value;
  }

  /// private named constructor.
  /// DO NOT MAKE INSTANCE FROM OTHER CLASS DIRECTLY.
  AudioMixer._makeInstance();
}

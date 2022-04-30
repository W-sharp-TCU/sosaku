import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class AudioMixer {
  /* interface */
  static const int UI = 0; // UI audio
  static const int BGM = 1; // Back Ground Music audio
  static const int SE = 2; // Sound Effect audio
  static const int CV = 3; // Character Voice audio

  /* config */
  /// Fade-in or fade-out effect takes [_fadeDuration] milli seconds.
  /// So, fade transition (fade-out then fade-in) takes [_fadeDuration]*2 milli seconds.
  static const int _fadeDuration = 1700; // [ms]
  static const int _fadeStep = 17; // process will execute [_fadeStep] times.
  // recommend configure : _fadeDuration / _fadeStep > 100 [ms/step]

  /* static variances */
  static AudioMixer? _instance; // reference to the instance of this class.
  static List<PlayerState> _playersState = [
    PlayerState.STOPPED,
    PlayerState.STOPPED,
    PlayerState.STOPPED,
    PlayerState.STOPPED
  ];
  static AudioPlayer? _uiController;
  static AudioPlayer? _bgmController;
  static List<AudioPlayer> _seControllers = [];
  static List<AudioPlayer> _cvControllers = [];
  static List<double> _volumes = [1.0, 1.0, 1.0, 1.0]; // 0.0 <= _volumes <= 1.0

  /* instance variances */
  AudioCache _ui = AudioCache(
      prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
  AudioCache _bgm = AudioCache(
      prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.MEDIA_PLAYER));
  AudioCache _se = AudioCache(
      prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
  AudioCache _cv = AudioCache(
      prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));

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
            prefix: '',
            fixedPlayer: AudioPlayer(mode: PlayerMode.MEDIA_PLAYER));
        _instance!._bgm.loadAll(filePaths);
        break;
      case SE:
        _instance!._se = AudioCache(
            prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
        _instance!._se.loadAll(filePaths);
        break;
      case CV:
        _instance!._cv = AudioCache(
            prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
        _instance!._cv.loadAll(filePaths);
        break;
      default:
        throw AssertionError("AudioMixer: unexpected audioType.\n"
            "Specify 'UI', 'BGM', 'SE' or 'CV' to audioType.");
    }
  }

  /* play functions */
  /// Play UI audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.UI] type.
  ///
  /// @param filePath : Specify audio file path you want to play.
  static Future<void> playUI(String filePath) async {
    _instanceExistenceCheck();
    _uiController = await _instance!._ui.play(filePath);
    _uiController!.onPlayerStateChanged.listen((event) {
      print("UI: $event");
      _playersState[UI] = event;
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        print("BGM => null");
        _uiController = null;
      }
    });
    _playersState[UI] = _uiController!.state;
  }

  /// Play BGM audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.BGM] type.
  ///
  /// @param filePath : Specify audio file path you want to play.
  static Future<void> playBGM(String filePath,
      {bool loop = false, bool fadeOut = true, bool fadeIn = false}) async {
    print("start : $_bgmController, $uiState");
    _instanceExistenceCheck();
    if (_bgmController != null) {
      if (fadeOut) {
        await _instance!._fadeOut(_bgmController!, AudioMixer.BGM);
      }
      stopBGM();
    }
    double startVolume = bgmVolume;
    if (fadeIn) {
      startVolume = 0.0;
    }
    if (loop) {
      _bgmController =
          await _instance!._bgm.loop(filePath, volume: startVolume);
    } else {
      _bgmController =
          await _instance!._bgm.play(filePath, volume: startVolume);
    }
    if (fadeIn) {
      _instance!._fadeIn(_bgmController!, AudioMixer.BGM);
    }
    _bgmController!.onPlayerStateChanged.listen((event) {
      _playersState[BGM] = event;
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        print("BGM => null");
        _bgmController = null;
      }
    });
    _playersState[BGM] = _bgmController!.state;
  }

  /// Play SE audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.SE] type.
  ///
  /// @param filePath : Specify audio file path you want to play.
  static Future<void> playSE(List<String> filePaths,
      {bool loop = false, bool fadeOut = false, bool fadeIn = true}) async {
    _instanceExistenceCheck();
    if (_bgmController != null) {
      if (fadeOut) {
        await _instance!._fadeOut(_bgmController!, AudioMixer.SE);
      }
      stopSEAll();
    }
    List<AudioPlayer> players = [];
    double volume = seVolume;
    if (fadeIn) {
      volume = 0.0;
    }
    for (String element in filePaths) {
      if (loop) {
        players.add(await _instance!._se.loop(element, volume: volume));
      } else {
        players.add(await _instance!._se.play(element, volume: volume));
      }
      if (fadeIn) {
        _instance!._fadeIn(players.last, AudioMixer.SE);
      }
    }
    players[0].onPlayerStateChanged.listen((event) {
      _playersState[SE] = event;
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        print("SE => null");
        _seControllers = [];
      }
    });
    _playersState[SE] = players[0].state;
  }

  /// Play CV audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.CV] type.
  ///
  /// @param filePath : Specify audio file path you want to play.
  static Future<void> playCV(List<String> filePaths) async {
    _instanceExistenceCheck();
    List<AudioPlayer> players = [];
    for (String element in filePaths) {
      players.add(await _instance!._cv.play(element));
    }
    players[0].onPlayerStateChanged.listen((event) {
      _playersState[CV] = event;
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        print("CV => null");
        _cvControllers = [];
      }
    });
    _playersState[CV] = players[0].state;
  }

  /* pause functions */
  static Future<void> pauseBGM() async {
    await _bgmController?.pause();
  }

  static Future<void> pauseSE() async {
    for (AudioPlayer element in _seControllers) {
      await element.pause();
    }
  }

  static Future<void> pauseCV() async {
    for (AudioPlayer element in _cvControllers) {
      await element.pause();
    }
  }

  static void pauseALL() {
    pauseBGM();
    pauseSE();
    pauseCV();
  }

  /* resume functions */
  static Future<void> resumeBGM() async {
    await _bgmController?.resume();
  }

  static Future<void> resumeSE() async {
    for (AudioPlayer element in _seControllers) {
      await element.resume();
    }
  }

  static Future<void> resumeCV() async {
    for (AudioPlayer element in _cvControllers) {
      await element.resume();
    }
  }

  static void resumeALL() async {
    resumeBGM();
    resumeSE();
    resumeCV();
  }

  /* stop functions */
  static Future<void> stopUI() async {
    await _uiController?.stop();
    _uiController = null;
  }

  static Future<void> stopBGM() async {
    await _bgmController?.stop();
    _bgmController = null;
  }

  static Future<void> stopSEAll() async {
    for (AudioPlayer element in _seControllers) {
      await element.stop();
    }
  }

  static Future<void> stopCVAll() async {
    for (AudioPlayer element in _cvControllers) {
      await element.stop();
    }
  }

  static void stopALL() async {
    stopUI();
    stopBGM();
    stopSEAll();
    stopCVAll();
  }

  Future<void> _fadeOut(AudioPlayer audioPlayer, int audioType) async {
    double volume = _volumes[audioType];
    while (volume > 0) {
      print(volume);
      volume = volume - (_volumes[audioType] / _fadeStep);
      if (volume <= 0) {
        volume = 0;
      }
      await audioPlayer.setVolume(volume);
      await Future.delayed(
          const Duration(milliseconds: (_fadeDuration ~/ _fadeStep)));
    }
  }

  Future<void> _fadeIn(AudioPlayer audioPlayer, int audioType) async {
    double goal = _volumes[audioType];
    double volume = 0;
    int start = DateTime.now().millisecondsSinceEpoch;
    while (volume < goal) {
      volume = volume + (goal / _fadeStep);
      if (volume >= goal) {
        volume = goal;
      }
      await audioPlayer.setVolume(volume);
      await Future.delayed(
          const Duration(milliseconds: (_fadeDuration ~/ _fadeStep)));
    }
    print("AudioMixer: "
            "FadeIn transition took " +
        (DateTime.now().millisecondsSinceEpoch - start).toString() +
        " milli seconds.");
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
    if (value > 1.0) {
      _volumes[BGM] = 1.0;
    } else if (value < 0) {
      _volumes[BGM] = 0.0;
    } else {
      _volumes[BGM] = value;
    }
  }

  static set seVolume(double value) {
    if (value > 1.0) {
      _volumes[SE] = 1.0;
    } else if (value < 0) {
      _volumes[SE] = 0.0;
    } else {
      _volumes[SE] = value;
    }
  }

  static set cvVolume(double value) {
    if (value > 1.0) {
      _volumes[CV] = 1.0;
    } else if (value < 0) {
      _volumes[CV] = 0.0;
    } else {
      _volumes[CV] = value;
    }
  }

  static PlayerState get uiState => _playersState[UI];
  static PlayerState get bgmState => _playersState[BGM];
  static PlayerState get seState => _playersState[SE];
  static PlayerState get cvState => _playersState[CV];

  /// private named constructor.
  /// DO NOT MAKE INSTANCE FROM OTHER CLASS DIRECTLY.
  AudioMixer._makeInstance();
}

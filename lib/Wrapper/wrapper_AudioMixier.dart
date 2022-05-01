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
        clearUIAll();
        _instance!._ui = AudioCache(
            prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
        _instance!._ui.loadAll(filePaths);
        break;
      case BGM:
        clearBGMAll();
        _instance!._bgm = AudioCache(
            prefix: '',
            fixedPlayer: AudioPlayer(mode: PlayerMode.MEDIA_PLAYER));
        _instance!._bgm.loadAll(filePaths);
        break;
      case SE:
        clearSEAll();
        _instance!._se = AudioCache(
            prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
        _instance!._se.loadAll(filePaths);
        break;
      case CV:
        clearCVAll();
        _instance!._cv = AudioCache(
            prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
        _instance!._cv.loadAll(filePaths);
        break;
      default:
        throw AssertionError("AudioMixer: unexpected audioType error\n"
            "Specify 'UI', 'BGM', 'SE' or 'CV' to audioType.");
    }
  }

  /* clear functions*/
  /// Release all UI audio caches.
  static Future<void> clearUIAll() async {
    _instanceExistenceCheck();
    await stopUI(fadeOut: false);
    await _instance!._ui.clearAll();
    _uiController = null;
  }

  /// Release all BGM caches.
  static Future<void> clearBGMAll() async {
    _instanceExistenceCheck();
    await stopBGM(fadeOut: false);
    await _instance!._bgm.clearAll();
    _bgmController = null;
  }

  /// Release all SE caches.
  static Future<void> clearSEAll() async {
    _instanceExistenceCheck();
    await stopSEAll(fadeOut: false);
    await _instance!._bgm.clearAll();
    _seControllers.clear();
  }

  /// Release all CV caches.
  static Future<void> clearCVAll() async {
    _instanceExistenceCheck();
    await stopCVAll(fadeOut: false);
    await _instance!._se.clearAll();
    _cvControllers.clear();
  }

  /// Release all UI audio, BGM, SE, CV caches.
  static void clearAll() {
    clearUIAll();
    clearBGMAll();
    clearSEAll();
    clearCVAll();
  }

  /* play functions */
  /// Play UI audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.UI] type.
  ///
  /// @param filePath : Specify audio file path you want to play.
  static Future<void> playUI(String filePath) async {
    _instanceExistenceCheck();
    /*_uiController = await _instance!._ui.play(filePath);
    */ /*_uiController!.onPlayerStateChanged.listen((event) {
      _playersState[UI] = event;
      print("UI State : " + _playersState[UI].toString());
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        print("UI => null");
        _uiController = null;
      }
    });*/ /*
    _playersState[UI] = _uiController!.state;*/
  }

  /// Play BGM audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.BGM] type.
  ///
  /// @param filePath : Specify audio file path you want to play.
  /// @param loop : if "true", BGM starts looping until you call stopBGM().
  /// @param fadeOut : if "true", BGM playing now will be applied fade-out
  ///                  effect and then stop before new audio file start playing.
  /// @param fadeIn : if "true", new audio file start playing with fade-in effect.
  static Future<void> playBGM(String filePath,
      {bool loop = false, bool fadeOut = true, bool fadeIn = false}) async {
    _instanceExistenceCheck();
    if (_bgmController != null) {
      await stopBGM(fadeOut: fadeOut);
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
      print("BGM State : " + _playersState[BGM].toString());
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        print("BGM => null");
        _bgmController = null;
      }
    });
    /*_bgmController!.onPlayerCompletion.listen((event) =>
        print("=======================Complete!============================"));
    _playersState[BGM] = _bgmController!.state;*/
    print(await _bgmController!.getDuration());
    await Future.delayed(
        Duration(milliseconds: await _bgmController!.getDuration()));
    print("=======================Complete!============================");
  }

  /// Play SE audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.SE] type.
  ///
  /// @param filePaths : Specify the list of audio file paths you want to play.
  /// @param loop : if "true", BGM starts looping until you call stopBGM().
  /// @param fadeOut : if "true", BGM playing now will be applied fade-out
  ///                  effect and then stop before new audio file start playing.
  /// @param fadeIn : if "true", new audio file start playing with fade-in effect.
  static Future<void> playSE(List<String> filePaths,
      {bool loop = false, bool fadeOut = false, bool fadeIn = true}) async {
    _instanceExistenceCheck();
    if (_seControllers.isNotEmpty) {
      await stopSEAll(fadeOut: fadeOut);
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
      print("SE State : " + _playersState[SE].toString());
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        print("SE => null");
        _seControllers.clear();
      }
    });
    _playersState[SE] = players[0].state;
  }

  /// Play CV audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.CV] type.
  ///
  /// @param filePaths : Specify the list of  audio file paths you want to play.
  static Future<void> playCV(List<String> filePaths) async {
    _instanceExistenceCheck();
    if (_cvControllers.isNotEmpty) {
      stopCVAll(fadeOut: false);
    }
    List<AudioPlayer> players = [];
    for (String element in filePaths) {
      players.add(await _instance!._cv.play(element));
    }
    print("playCV() : $players");
    players.first.onPlayerStateChanged.listen((event) {
      _playersState[CV] = event;
      print(event);
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        print("CV => null");
        _cvControllers.clear();
      }
    });
    _playersState[CV] = players.first.state;
  }

  /* pause functions */
  /// Pause BGM.
  static Future<void> pauseBGM() async {
    await _bgmController?.pause();
  }

  /// Pause SE.
  static Future<void> pauseSE() async {
    for (AudioPlayer element in _seControllers) {
      await element.pause();
    }
  }

  /// Pause CV.
  static Future<void> pauseCV() async {
    for (AudioPlayer element in _cvControllers) {
      await element.pause();
    }
  }

  /// Pause BGM, SE & CV.
  static void pauseALL() {
    pauseBGM();
    pauseSE();
    pauseCV();
  }

  /* resume functions */
  /// Resume BGM paused.
  static Future<void> resumeBGM() async {
    await _bgmController?.resume();
  }

  /// Resume SE paused.
  static Future<void> resumeSE() async {
    for (AudioPlayer element in _seControllers) {
      await element.resume();
    }
  }

  /// Resume CV paused.
  static Future<void> resumeCV() async {
    for (AudioPlayer element in _cvControllers) {
      await element.resume();
    }
  }

  /// Resume BGM, SE & CV paused.
  static void resumeALL() async {
    resumeBGM();
    resumeSE();
    resumeCV();
  }

  /* stop functions */
  /// Stop UI audio playing now.
  static Future<void> stopUI({bool fadeOut = true}) async {
    _instanceExistenceCheck();
    if (_uiController != null) {
      if (fadeOut) {
        await _instance!._fadeOut(_uiController!, AudioMixer.UI);
      }
      await _uiController?.stop();
      _uiController = null;
    }
  }

  /// Stop BGM playing now.
  static Future<void> stopBGM({bool fadeOut = true}) async {
    _instanceExistenceCheck();
    if (_bgmController != null) {
      if (fadeOut) {
        await _instance!._fadeOut(_bgmController!, AudioMixer.BGM);
      }
      await _bgmController?.stop();
      _bgmController = null;
    }
  }

  /// Stop all SE playing now.
  static Future<void> stopSEAll({bool fadeOut = true}) async {
    _instanceExistenceCheck();
    for (AudioPlayer element in _seControllers) {
      if (fadeOut) {
        await _instance!._fadeOut(element, AudioMixer.SE);
      }
      await element.stop();
    }
    _seControllers.clear();
  }

  /// Stop all CV playing now.
  static Future<void> stopCVAll({bool fadeOut = true}) async {
    _instanceExistenceCheck();
    for (AudioPlayer element in _cvControllers) {
      if (fadeOut) {
        await _instance!._fadeOut(element, AudioMixer.CV);
      }
      await element.stop();
    }
    _cvControllers.clear();
  }

  /// Stop all UI audio, BGM, SE, CV playing now.
  static void stopALL() async {
    stopUI();
    stopBGM();
    stopSEAll();
    stopCVAll();
  }

  /* private functions */
  Future<void> _fadeOut(AudioPlayer audioPlayer, int audioType) async {
    double volume = _volumes[audioType];
    while (volume > 0) {
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
    while (volume < goal) {
      volume = volume + (goal / _fadeStep);
      if (volume >= goal) {
        volume = goal;
      }
      await audioPlayer.setVolume(volume);
      await Future.delayed(
          const Duration(milliseconds: (_fadeDuration ~/ _fadeStep)));
    }
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
    _uiController?.setVolume(_volumes[UI]);
  }

  static set bgmVolume(double value) {
    if (value > 1.0) {
      _volumes[BGM] = 1.0;
    } else if (value < 0) {
      _volumes[BGM] = 0.0;
    } else {
      _volumes[BGM] = value;
    }
    _bgmController?.setVolume(_volumes[BGM]);
  }

  static set seVolume(double value) {
    if (value > 1.0) {
      _volumes[SE] = 1.0;
    } else if (value < 0) {
      _volumes[SE] = 0.0;
    } else {
      _volumes[SE] = value;
    }
    if (_cvControllers.isNotEmpty) {
      for (AudioPlayer element in _cvControllers) {
        element.setVolume(_volumes[SE]);
      }
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
    if (_cvControllers.isNotEmpty) {
      for (AudioPlayer element in _cvControllers) {
        element.setVolume(_volumes[CV]);
      }
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

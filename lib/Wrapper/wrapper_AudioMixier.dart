import 'dart:html';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioMixer {
  /* interface */
  static const int UI = 0; // UI audio
  static const int BGM = 1; // Back Ground Music audio
  static const int SE = 2; // Sound Effect audio
  static const int CV = 3; // Character Voice audio

  /* config */
  /// Fade-in or fade-out effect takes [_fadeDuration] milli seconds.
  /// So, fade transition (fade-out then fade-in) takes [_fadeDuration]*2 milli seconds.
  static const int _fadeDuration = 1500; // [ms]
  static const int _fadeStep = 10; // process will execute [_fadeStep] times.
  static List<double> _volumes = [1.0, 1.0, 1.0, 1.0]; // 0.0 <= _volumes <= 1.0

  /* static variances */
  static AudioMixer? _instance; // reference to the instance of this class.
  static PlayerState _uiState = PlayerState.STOPPED;
  static PlayerState _bgmState = PlayerState.STOPPED;
  static PlayerState _seState = PlayerState.STOPPED;
  static PlayerState _cvState = PlayerState.STOPPED;

  /* instance variances */
  AudioCache _ui = AudioCache(
      prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
  AudioCache _bgm = AudioCache(
      prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.MEDIA_PLAYER));
  Map<String, AudioCache> _seMap = {};
  AudioCache _cv = AudioCache(
      prefix: '', fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));

  // todo: bgm, se, as, cvの実装
  // todo: state
  // todo: フェード
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
            prefix: '',
            fixedPlayer: AudioPlayer(mode: PlayerMode.MEDIA_PLAYER));
        _instance!._bgm.loadAll(filePaths);
        break;
      case SE:
        _instance!._seMap.clear();
        for (int i = 0; i < filePaths.length; i++) {
          _instance!._seMap[filePaths[i]] = AudioCache(
              prefix: '',
              fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
          _instance!._seMap[filePaths[i]]!.load(filePaths[i]);
        }
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
    AudioPlayer player = await _instance!._ui.play(filePath);
    player.onPlayerStateChanged.listen((event) {
      _uiState = event;
    });
    _uiState = player.state;
  }

  /// Play BGM audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.BGM] type.
  ///
  /// @param filePath : Specify audio file path you want to play.
  static Future<void> playBGM(String filePath,
      {bool loop = false,
      bool fadeIn = false,
      bool fadeTransition = false}) async {
    _instanceExistenceCheck();
    double startVolume = bgmVolume;
    AudioPlayer player;
    if (fadeIn) {
      startVolume = 0.0;
    }
    if (loop) {
      player = await _instance!._bgm.loop(filePath, volume: startVolume);
    } else {
      player = await _instance!._bgm.play(filePath, volume: startVolume);
    }
    player.onPlayerStateChanged.listen((event) {
      _bgmState = event;
    });
    _bgmState = player.state;
  }

  /// Play SE audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.SE] type.
  ///
  /// @param filePath : Specify audio file path you want to play.
  static Future<void> playSE(String filePath) async {
    _instanceExistenceCheck();
    if (_instance!._seMap[filePath] == null) {
      throw AssertionError("WARNING: AudioMixer: $filePath is not loaded.");
    }
    AudioPlayer player = await _instance!._seMap[filePath]!.play(filePath);
    player.onPlayerStateChanged.listen((event) {
      _seState = event;
    });
    _seState = player.state;
  }

  /// Play CV audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [AudioMixer.CV] type.
  ///
  /// @param filePath : Specify audio file path you want to play.
  static Future<void> playCV(String filePath) async {
    _instanceExistenceCheck();
    AudioPlayer player = await _instance!._cv.play(filePath);
    player.onPlayerStateChanged.listen((event) {
      _cvState = event;
    });
    _cvState = player.state;
  }

  /* pause functions */
  static void pauseBGM() {}

  /* resume functions */

  /* stop functions */

  Future<void> _fadeOut(AudioPlayer audioPlayer, int audioType) async {
    double volume = _volumes[audioType];
    while (volume > 0) {
      volume = volume - (volume / _fadeStep);
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

  static PlayerState get uiState => _uiState;
  static PlayerState get bgmState => _bgmState;
  static PlayerState get seState => _seState;
  static PlayerState get cvState => _cvState;

  /// private named constructor.
  /// DO NOT MAKE INSTANCE FROM OTHER CLASS DIRECTLY.
  AudioMixer._makeInstance();
}

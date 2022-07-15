import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

/// **Play UI sounds, Background Musics, Ambient Sounds & Character's voices.**
///
/// This class is Singleton.
///
/// Depended package: audio_players version >= 1.0
///
/// ## Features
///   1. Playing, stopping, pausing, resuming sounds.
///   2. fade-in & fade-out effect
///   3. Configure each volume (UI, BGM, AS, CV)
///   4. playing state
class SoundPlayer {
  /* Configurations */
  /// Fade-in or fade-out effect takes [_fadeDuration] milli seconds.
  /// So, fade transition (fade-out then fade-in) takes [_fadeDuration]*2 milli seconds.
  static const int _fadeDuration = 1700; // [ms]
  static const int _fadeStep = 17; // process will execute [_fadeStep] times.
  // recommend configuration : _fadeDuration / _fadeStep > 100 [ms/step]

  /* Interfaces */
  /// User Interface audio
  static const int ui = 0;

  /// Back Ground Music audio
  static const int bgm = 1;

  /// Ambient Sound audio
  static const int as = 2;

  /// Character's Voice audio
  static const int cv = 3;

  /* Private Fields */
  static final SoundPlayer _singleton = SoundPlayer._internalConstructor();

  Map<String, _PlayerTuple> _uiCaches = {};
  Map<String, _PlayerTuple> _bgmCaches = {};
  Map<String, _PlayerTuple> _asCaches = {};
  Map<String, _PlayerTuple> _cvCaches = {};

  List<double> _volumes = List.filled(4, 1.0); // 0.0 <= _volumes <= 1.0

  /* Factory constructor */
  /// This class is SingleTon.
  /// So, You need to get the instance of this class before you call below methods.
  ///
  /// ### Example
  /// ```dart
  /// SoundPlayer soundPlayer = SoundPlayer();
  /// soundPlayer.precacheSounds([foo.mp3], SoundPlayer.ui);
  /// ```
  factory SoundPlayer() => _singleton; // Always return same instance

  /* Load function */
  /// Load audio files to AudioPlayer instances.
  ///
  /// @param [filePaths] : Specify list of audio file path you want to load.
  ///
  /// @param [audioType] : Specify any one of below options depends on files you load.
  ///        Option : SoundPlayer.ui, SoundPlayer.bgm, SoundPlayer.as, SoundPlayer.cv
  Future<void> precacheSounds(
      {required List<String> filePaths, required int audioType}) async {
    Map<String, _PlayerTuple> caches;
    PlayerMode playerMode = PlayerMode.mediaPlayer;
    double volume;
    switch (audioType) {
      case ui:
        caches = _uiCaches;
        volume = uiVolume;
        playerMode = PlayerMode.lowLatency;
        break;
      case bgm:
        caches = _bgmCaches;
        volume = bgmVolume;
        break;
      case as:
        caches = _asCaches;
        volume = asVolume;
        break;
      case cv:
        caches = _cvCaches;
        volume = cvVolume;
        break;
      default:
        throw AssertionError("SoundPlayer: unexpected audioType error\n"
            "Specify 'ui', 'bgm', 'as' or 'cv' to audioType.");
    }
    print("[list content] $filePaths");
    await _deleteUnnecessaryCaches(filePaths, caches);
    print("[list content] $filePaths");
    for (String element in filePaths) {
      AudioPlayer newPlayer = AudioPlayer();
      newPlayer.setPlayerMode(playerMode);
      newPlayer.setReleaseMode(ReleaseMode.stop);
      newPlayer.setVolume(volume);
      newPlayer.setSourceAsset(element);
      caches[element] = _PlayerTuple(element, newPlayer, newPlayer.state);
      newPlayer.onPlayerStateChanged.listen((event) {
        print(event);
        caches[element]?.state = event;
      });
      newPlayer.onPlayerComplete.listen((event) {
        caches[element]?.state = PlayerState.completed;
        print("Finished. tuple.state=${caches[element]?.state}");
      });
    }
  }

  /* Release functions*/
  /// Release all User Interface audio caches.
  Future<void> releaseUICaches() async {
    _uiCaches.forEach((key, value) async {
      await value.player.dispose();
    });
    _uiCaches = {};
  }

  /// Release all Back Ground Music audio caches.
  Future<void> releaseBGMCaches() async {
    _bgmCaches.forEach((key, value) async {
      await value.player.dispose();
    });
    _bgmCaches = {};
  }

  /// Release all Ambient Sound audio caches.
  Future<void> releaseASCaches() async {
    _asCaches.forEach((key, value) async {
      await value.player.dispose();
    });
    _asCaches = {};
  }

  /// Release all Character's Voice audio caches.
  Future<void> releaseCVCaches() async {
    _cvCaches.forEach((key, value) async {
      await value.player.dispose();
    });
    _cvCaches = {};
  }

  /// Release all User Interface, Back Ground Music,
  /// Ambient Sound & Character's Voice audio caches.
  Future<void> clearAllCaches() async {
    await releaseUICaches();
    await releaseBGMCaches();
    await releaseASCaches();
    await releaseCVCaches();
  }

  /* Play functions */
  /// Play User Interface audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [SoundPlayer.ui] type.
  ///
  /// @param [filePath] : Specify audio file path you want to play.
  void playUI(String filePath) async {
    await stopUI(fadeOut: false);
    if (!_uiCaches.containsKey(filePath)) {
      throw AssertionError("SoundPlayer.playUI(): $filePath is not cached.");
    } else {
      _uiCaches[filePath]?.player.seek(const Duration(microseconds: 0)); // cue
      _uiCaches[filePath]?.player.resume(); // play from start.
    }
  }

  /// Play Back Ground Music audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [SoundPlayer.bgm] type.
  ///
  /// @param [filePath] : Specify audio file path you want to play.
  ///
  /// @param [loop] : if "true", specified Back Ground Music starts looping until
  ///    you call stopBGM().
  ///
  /// @param [fadeOut] : if "true", Back Ground Music playing now will be applied
  ///    fade-out effect and then stop before new audio file start playing.
  ///
  /// @param [fadeIn] : if "true", new audio file start playing with fade-in effect.
  void playBGM(String filePath,
      {bool loop = true, bool fadeOut = true, bool fadeIn = false}) async {
    final double startVolume;
    final ReleaseMode mode;
    await stopBGM(fadeOut: fadeOut);
    if (loop) {
      mode = ReleaseMode.loop;
    } else {
      mode = ReleaseMode.stop;
    }
    if (fadeIn) {
      startVolume = 0;
    } else {
      startVolume = bgmVolume;
    }
    if (!_bgmCaches.containsKey(filePath)) {
      throw AssertionError("SoundPlayer.playBGM(): $filePath is not cached.");
    } else {
      _bgmCaches[filePath]?.player.seek(const Duration(microseconds: 0)); // cue
      _bgmCaches[filePath]?.player.setReleaseMode(mode);
      _bgmCaches[filePath]?.player.setVolume(startVolume);
      _bgmCaches[filePath]?.player.resume(); // play from start.
      if (fadeIn) {
        _fadeIn(_bgmCaches[filePath]!.player, bgm);
      }
    }
  }

  /// Play Ambient Sound audio files.
  /// This function must be called after the audio files you want to play are
  /// loaded as [SoundPlayer.as] type.
  ///
  /// @param [filePaths] : Specify the list of audio file paths you want to play.
  ///
  /// @param [loop] : if "true", specified Ambient Sound starts looping until
  ///    you call stopASAll().
  ///
  /// @param [fadeOut] : if "true", Ambient Sound playing now will be applied
  ///    fade-out effect and then stop before new audio file start playing.
  ///
  /// @param fadeIn : if "true", new audio file start playing with fade-in effect.
  void playAS(List<String> filePaths,
      {bool loop = false, bool fadeOut = false, bool fadeIn = true}) async {
    final double startVolume;
    final ReleaseMode mode;
    await stopASAll(fadeOut: fadeOut);
    if (loop) {
      mode = ReleaseMode.loop;
    } else {
      mode = ReleaseMode.stop;
    }
    if (fadeIn) {
      startVolume = 0;
    } else {
      startVolume = asVolume;
    }
    for (String e in filePaths) {
      if (!_asCaches.containsKey(e)) {
        throw AssertionError("SoundPlayer.playAS(): $e is not cached.");
      } else {
        _asCaches[e]?.player.seek(const Duration(microseconds: 0)); // cue
        _asCaches[e]?.player.setReleaseMode(mode);
        _asCaches[e]?.player.setVolume(startVolume);
        _asCaches[e]?.player.resume(); // play from start.
        if (fadeIn) {
          _fadeIn(_asCaches[e]!.player, as);
        }
      }
    }
  }

  /// Play Character's Voice audio files.
  /// This function must be called after the audio files you want to play are
  /// loaded as [SoundPlayer.cv] type.
  ///
  /// @param [filePaths] : Specify the list of audio file paths you want to play.
  ///
  /// @param [fadeOut] : if "true", the Character's Voice audio playing now will be
  ///    applied fade-out effect and then stop before new audio file start playing.
  void playCV(List<String> filePaths, {bool fadeOut = true}) async {
    await stopCVAll(fadeOut: fadeOut);
    for (String e in filePaths) {
      if (!_cvCaches.containsKey(e)) {
        throw AssertionError("SoundPlayer.playCV(): $e is not cached.");
      } else {
        _cvCaches[e]?.player.seek(const Duration(microseconds: 0)); // cue
        _cvCaches[e]?.player.resume(); // play from start.
      }
    }
  }

  /* Pause functions */
  /// Pause Back Ground Music playing now.
  Future<void> pauseBGM() async {
    _bgmCaches.forEach((key, value) async {
      await value.player.pause();
    });
  }

  /// Pause Ambient Sounds playing now.
  Future<void> pauseAS() async {
    _asCaches.forEach((key, value) async {
      await value.player.pause();
    });
  }

  /// Pause Character's Voice audios playing now.
  Future<void> pauseCV() async {
    _cvCaches.forEach((key, value) async {
      await value.player.pause();
    });
  }

  /// Pause Back Ground Music, Ambient Sounds & Character's Voice audios playing now.
  void pauseALL() {
    pauseBGM();
    pauseAS();
    pauseCV();
  }

  /* Resume functions */
  /// Resume Back Ground Music paused.
  Future<void> resumeBGM() async {
    _bgmCaches.forEach((key, value) {
      if (value.state == PlayerState.paused) {
        value.player.resume();
      }
    });
  }

  /// Resume Ambient Sounds paused.
  Future<void> resumeAS() async {
    _asCaches.forEach((key, value) {
      if (value.state == PlayerState.paused) {
        value.player.resume();
      }
    });
  }

  /// Resume Character's Voice audios paused.
  Future<void> resumeCV() async {
    _cvCaches.forEach((key, value) {
      if (value.state == PlayerState.paused) {
        value.player.resume();
      }
    });
  }

  /// Resume Back Ground Music, Ambient Sounds & Character's Voice audios paused.
  void resumeALL() async {
    resumeBGM();
    resumeAS();
    resumeCV();
  }

  /* Stop functions */
  /// Stop User Interface audio playing now.
  Future<void> stopUI({bool fadeOut = true}) async {
    await Future.forEach(_uiCaches.keys, (value) async {
      value = value as _PlayerTuple;
      if (fadeOut) {
        await _fadeOut(value.player, ui);
      }
      await value.player.stop();
    });
  }

  /// Stop Back Ground Music playing now.
  Future<void> stopBGM({bool fadeOut = true}) async {
    await Future.forEach(_bgmCaches.keys, (value) async {
      value = value as _PlayerTuple;
      if (fadeOut) {
        await _fadeOut(value.player, bgm);
      }
      await value.player.stop();
    });
  }

  /// Stop all Ambient Sounds playing now.
  Future<void> stopASAll({bool fadeOut = true}) async {
    await Future.forEach(_asCaches.keys, (value) async {
      value = value as _PlayerTuple;
      if (fadeOut) {
        await _fadeOut(value.player, as);
      }
      await value.player.stop();
    });
  }

  /// Stop all Character's Voice audios playing now.
  Future<void> stopCVAll({bool fadeOut = false}) async {
    await Future.forEach(_cvCaches.keys, (value) async {
      value = value as _PlayerTuple;
      if (fadeOut) {
        await _fadeOut(value.player, cv);
      }
      await value.player.stop();
    });
  }

  /// Stop all Back Ground Music, Ambient Sounds & Character's Voice audios
  /// playing now. (User Interface audio will not be stopped.)
  void stopSound() async {
    stopBGM();
    stopASAll();
    stopCVAll();
  }

  /// Stop all User Interface audio, Back Ground Music, Ambient Sounds &
  /// Character's Voice audios playing now.
  void stopALL() async {
    stopUI();
    stopBGM();
    stopASAll();
    stopCVAll();
  }

  /* Private functions */
  Future<void> _deleteUnnecessaryCaches(
      List<String> necessaryFiles, Map<String, _PlayerTuple> caches) async {
    for (String e in caches.keys) {
      if (!necessaryFiles.contains(e)) {
        await caches[e]?.player.release();
        caches.remove(e);
      } else {
        necessaryFiles.remove(e);
      }
    }
  }

  Future<void> _fadeOut(AudioPlayer audioPlayer, int audioType) async {
    double volume = _volumes[audioType];
    while (volume >= 0) {
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
    while (volume <= goal) {
      volume = volume + (goal / _fadeStep);
      if (volume >= goal) {
        volume = goal;
      }
      await audioPlayer.setVolume(volume);
      await Future.delayed(
          const Duration(milliseconds: (_fadeDuration ~/ _fadeStep)));
    }
  }

  /* Getters & Setters */
  double get uiVolume => _volumes[ui];
  double get bgmVolume => _volumes[bgm];
  double get asVolume => _volumes[as];
  double get cvVolume => _volumes[cv];

  set uiVolume(double value) {
    if (value > 1.0) {
      _volumes[ui] = 1.0;
    } else if (value < 0) {
      _volumes[ui] = 0.0;
    } else {
      _volumes[ui] = value;
    }
    _uiCaches.forEach((key, value) {
      value.player.setVolume(_volumes[ui]);
    });
  }

  set bgmVolume(double value) {
    if (value > 1.0) {
      _volumes[bgm] = 1.0;
    } else if (value < 0) {
      _volumes[bgm] = 0.0;
    } else {
      _volumes[bgm] = value;
    }
    _uiCaches.forEach((key, value) {
      value.player.setVolume(_volumes[ui]);
    });
  }

  set asVolume(double value) {
    if (value > 1.0) {
      _volumes[as] = 1.0;
    } else if (value < 0) {
      _volumes[as] = 0.0;
    } else {
      _volumes[as] = value;
    }
    _uiCaches.forEach((key, value) {
      value.player.setVolume(_volumes[ui]);
    });
  }

  set cvVolume(double value) {
    if (value > 1.0) {
      _volumes[cv] = 1.0;
    } else if (value < 0) {
      _volumes[cv] = 0.0;
    } else {
      _volumes[cv] = value;
    }
    _uiCaches.forEach((key, value) {
      value.player.setVolume(_volumes[ui]);
    });
  }

  PlayerState get uiState {
    if (_uiCaches.isEmpty) {
      return PlayerState.stopped;
    } else {
      List<PlayerState> states = [];
      _uiCaches.forEach((key, value) {
        states.add(value.state);
      });
      if (states.contains(PlayerState.playing)) {
        return PlayerState.playing;
      } else if (states.contains(PlayerState.paused)) {
        return PlayerState.paused;
      } else if (states.contains(PlayerState.completed)) {
        return PlayerState.completed;
      } else {
        return PlayerState.stopped;
      }
    }
  }

  PlayerState get bgmState {
    if (_bgmCaches.isEmpty) {
      return PlayerState.stopped;
    } else {
      List<PlayerState> states = [];
      _bgmCaches.forEach((key, value) {
        states.add(value.state);
      });
      if (states.contains(PlayerState.playing)) {
        return PlayerState.playing;
      } else if (states.contains(PlayerState.paused)) {
        return PlayerState.paused;
      } else if (states.contains(PlayerState.completed)) {
        return PlayerState.completed;
      } else {
        return PlayerState.stopped;
      }
    }
  }

  PlayerState get asState {
    if (_asCaches.isEmpty) {
      return PlayerState.stopped;
    } else {
      List<PlayerState> states = [];
      _asCaches.forEach((key, value) {
        states.add(value.state);
      });
      if (states.contains(PlayerState.playing)) {
        return PlayerState.playing;
      } else if (states.contains(PlayerState.paused)) {
        return PlayerState.paused;
      } else if (states.contains(PlayerState.completed)) {
        return PlayerState.completed;
      } else {
        return PlayerState.stopped;
      }
    }
  }

  PlayerState get cvState {
    if (_cvCaches.isEmpty) {
      return PlayerState.stopped;
    } else {
      List<PlayerState> states = [];
      _cvCaches.forEach((key, value) {
        states.add(value.state);
      });
      if (states.contains(PlayerState.playing)) {
        return PlayerState.playing;
      } else if (states.contains(PlayerState.paused)) {
        return PlayerState.paused;
      } else if (states.contains(PlayerState.completed)) {
        return PlayerState.completed;
      } else {
        return PlayerState.stopped;
      }
    }
  }

  /// Private named constructor
  /// DO NOT MAKE INSTANCE FROM OTHER CLASS DIRECTLY.
  SoundPlayer._internalConstructor() {
    // Configure audio context
    AudioContextAndroid androidConfig = AudioContextAndroid(
        isSpeakerphoneOn: false,
        stayAwake: false,
        contentType: AndroidContentType.speech,
        usageType: AndroidUsageType.game,
        audioFocus: AndroidAudioFocus.none);
    AudioContextIOS iosConfig = AudioContextIOS(
      defaultToSpeaker: false,
      category: AVAudioSessionCategory.playback,
      options: [
        AVAudioSessionOptions.allowAirPlay,
        AVAudioSessionOptions.allowBluetooth,
      ],
    );
    AudioPlayer.global.setGlobalAudioContext(
        AudioContext(android: androidConfig, iOS: iosConfig));

    // Configure log level
    AudioPlayer.global
        .changeLogLevel(LogLevel.info); // todo: delete when release
  }
}

/// Internal data structure
class _PlayerTuple {
  String sourceName;
  AudioPlayer player;
  PlayerState state;
  _PlayerTuple(this.sourceName, this.player, this.state);
}

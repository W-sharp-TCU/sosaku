import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:universal_platform/universal_platform.dart';

/// **Play UI sounds, background musics, sound effects & character voices.**
///
/// This class is Singleton.
///
/// Depended package: audio_players version >= 1.0
///
/// ## Features
///   1. Playing, stopping, pausing, resuming sounds.
///   2. fade-in & fade-out effect
///   3. Volume config (UI, BGM, AS, CV)
///   4. playing state
class SoundPlayer {
  /* Configurations */
  /// Fade-in or fade-out effect takes [_fadeDuration] milli seconds.
  /// So, fade transition (fade-out then fade-in) takes [_fadeDuration]*2 milli seconds.
  static const int _fadeDuration = 1700; // [ms]
  static const int _fadeStep = 17; // process will execute [_fadeStep] times.
  // recommend configuration : _fadeDuration / _fadeStep > 100 [ms/step]

  /* Interfaces */
  /// User Interface Sound Effect
  static const int ui = 0;

  /// Back Ground Music
  static const int bgm = 1;

  /// Ambient Sound
  static const int as = 2;

  /// Character Voice audio
  static const int cv = 3;

  /* Fields */
  static final SoundPlayer _singleton = SoundPlayer._internalConstructor();

  Map<String, _PlayerTuple> _uiCaches = {};
  Map<String, _PlayerTuple> _bgmCaches = {};
  Map<String, _PlayerTuple> _asCaches = {};
  Map<String, _PlayerTuple> _cvCaches = {};

  List<double> _volumes = List.filled(4, 1.0); // 0.0 <= _volumes <= 1.0

  /// Load audio files to [AudioCache] class.
  ///
  /// @param [filePaths] : Specify list of audio file path you want to load.
  ///
  /// @param [audioType] : Specify any one of below options depends on files you load.
  ///        Option : SoundPlayer.ui, SoundPlayer.bgm, SoundPlayer.as, SoundPlayer.cv
  Future<void> precacheAudio(
      {required List<String> filePaths, required int audioType}) async {
    switch (audioType) {
      case ui:
        print("[list content] $filePaths");
        await _deleteUnnecessaryCaches(filePaths, _uiCaches);
        print("[list content] $filePaths");
        for (String element in filePaths) {
          AudioPlayer newPlayer = AudioPlayer();
          newPlayer.setPlayerMode(PlayerMode.lowLatency);
          newPlayer.setReleaseMode(ReleaseMode.stop);
          newPlayer.setVolume(uiVolume);
          newPlayer.setSourceAsset(element);
          _uiCaches[element] = newPlayer;
        }
        break;
      case bgm:
        await _deleteUnnecessaryCaches(filePaths, _bgmCaches);
        for (String element in filePaths) {
          AudioPlayer newPlayer = AudioPlayer();
          newPlayer.setPlayerMode(PlayerMode.mediaPlayer);
          newPlayer.setReleaseMode(ReleaseMode.stop);
          newPlayer.setVolume(bgmVolume);
          newPlayer.setSourceAsset(element);
          _uiCaches[element] = newPlayer;
        }
        break;
      case as:
        await _deleteUnnecessaryCaches(filePaths, _asCaches);
        for (String element in filePaths) {
          AudioPlayer newPlayer = AudioPlayer();
          newPlayer.setPlayerMode(PlayerMode.mediaPlayer);
          newPlayer.setReleaseMode(ReleaseMode.stop);
          newPlayer.setVolume(asVolume);
          newPlayer.setSourceAsset(element);
          _uiCaches[element] = newPlayer;
        }
        break;
      case cv:
        await _deleteUnnecessaryCaches(filePaths, _cvCaches);
        for (String element in filePaths) {
          AudioPlayer newPlayer = AudioPlayer();
          newPlayer.setPlayerMode(PlayerMode.mediaPlayer);
          newPlayer.setReleaseMode(ReleaseMode.stop);
          newPlayer.setVolume(cvVolume);
          newPlayer.setSourceAsset(element);
          _uiCaches[element] = newPlayer;
        }
        break;
      default:
        throw AssertionError("SoundPlayer: unexpected audioType error\n"
            "Specify 'ui', 'bgm', 'as' or 'cv' to audioType.");
    }
  }

  /* clear functions*/
  /// Release all UI audio caches.
  Future<void> releaseUICaches() async {
    _uiCaches.forEach((key, value) async {
      await value.dispose();
    });
    _uiCaches = {};
  }

  /// Release all BGM caches.
  Future<void> releaseBGMCaches() async {
    _bgmCaches.forEach((key, value) async {
      await value.dispose();
    });
    _bgmCaches = {};
  }

  /// Release all AS caches.
  Future<void> releaseASCaches() async {
    _asCaches.forEach((key, value) async {
      await value.dispose();
    });
    _asCaches = {};
  }

  /// Release all CV caches.
  Future<void> releaseCVCaches() async {
    _cvCaches.forEach((key, value) async {
      await value.dispose();
    });
    _cvCaches = {};
  }

  /// Release all UI audio, BGM, AS, CV caches.
  Future<void> clearAllCaches() async {
    await releaseUICaches();
    await releaseBGMCaches();
    await releaseASCaches();
    await releaseCVCaches();
  }

  /* play functions */
  /// Play UI audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [SoundPlayer.ui] type.
  ///
  /// @param [filePath] : Specify audio file path you want to play.
  void playUI(String filePath) async {
    await stopUI();
    if (!_uiCaches.containsKey(filePath)) {
      throw AssertionError("SoundPlayer.playUI(): $filePath is not cached.");
    } else {
      AudioPlayer? player = _uiCaches[filePath];
      player!.resume();
      _PlayerTuple playerTuple = _PlayerTuple(player, player.state);
      _uiActivePlayers.add(playerTuple);
      player.onPlayerStateChanged.listen((event) => );
    }
  }

  /// Play BGM audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [SoundPlayer.bgm] type.
  ///
  /// @param [filePath] : Specify audio file path you want to play.
  /// @param [loop] : if "true", BGM starts looping until you call stopBGM().
  /// @param [fadeOut] : if "true", BGM playing now will be applied fade-out
  ///                  effect and then stop before new audio file start playing.
  /// @param [fadeIn] : if "true", new audio file start playing with fade-in effect.
  void playBGM(String filePath,
      {bool loop = true, bool fadeOut = true, bool fadeIn = false}) async {
    AudioPlayer player;
    if (_bgmController != null) {
      await stopBGM(fadeOut: fadeOut);
    }
    double startVolume = bgmVolume;
    if (fadeIn) {
      startVolume = 0.0;
    }
    if (loop) {
      player = await _bgmCache.loop(filePath, volume: startVolume);
    } else {
      player = await _bgmCache.play(filePath, volume: startVolume);
    }
    _bgmController = player;
    if (fadeIn) {
      _fadeIn(player, SoundPlayer.bgm);
    }
    player.onPlayerStateChanged.listen((event) {
      _playersState[bgm] = event;
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        _bgmController = null;
      }
    });
    _playersState[bgm] = _bgmController!.state;
  }

  /// Play AS audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [SoundPlayer.as] type.
  ///
  /// @param filePaths : Specify the list of audio file paths you want to play.
  /// @param loop : if "true", AS starts looping until you call stopSE().
  /// @param fadeOut : if "true", AS playing now will be applied fade-out
  ///                  effect and then stop before new audio file start playing.
  /// @param fadeIn : if "true", new audio file start playing with fade-in effect.
  void playAS(List<String> filePaths,
      {bool loop = false, bool fadeOut = false, bool fadeIn = true}) async {
    if (_asControllers.isNotEmpty) {
      await stopASAll(fadeOut: fadeOut);
    }
    List<AudioPlayer> players = [];
    double startVolume = asVolume;
    if (fadeIn) {
      startVolume = 0.0;
    }
    for (String element in filePaths) {
      if (loop) {
        players.add(await _asCache.loop(element, volume: startVolume));
      } else {
        players.add(await _asCache.play(element, volume: startVolume));
      }
      if (fadeIn) {
        _fadeIn(players.last, SoundPlayer.as);
      }
    }
    _asControllers = players;
    players.first.onPlayerStateChanged.listen((event) {
      _playersState[as] = event;
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        _asControllers.clear();
      }
    });
    _playersState[as] = players[0].state;
  }

  /// Play CV audio file.
  /// This function must be called after the audio file you want to play is
  /// loaded as [SoundPlayer.cv] type.
  ///
  /// @param filePaths : Specify the list of  audio file paths you want to play.
  void playCV(List<String> filePaths) async {
    if (_cvControllers.isNotEmpty) {
      stopCVAll(fadeOut: false);
    }
    List<AudioPlayer> players = [];
    for (String element in filePaths) {
      players.add(await _cvCache.play(element, volume: cvVolume));
    }
    _cvControllers = players;
    players.first.onPlayerStateChanged.listen((event) {
      _playersState[cv] = event;
      if (event == PlayerState.COMPLETED || event == PlayerState.STOPPED) {
        _cvControllers.clear();
      }
    });
    _playersState[cv] = players.first.state;
    /** provisional */
    if (UniversalPlatform.isWeb) {
      await Future.delayed(const Duration(seconds: 17));
      _playersState[cv] = PlayerState.COMPLETED;
    }
  }

  /* pause functions */
  /// Pause BGM.
  Future<void> pauseBGM() async {
    await _bgmController?.pause();
  }

  /// Pause AS.
  Future<void> pauseAS() async {
    for (AudioPlayer element in _asControllers) {
      await element.pause();
    }
  }

  /// Pause CV.
  Future<void> pauseCV() async {
    for (AudioPlayer element in _cvControllers) {
      await element.pause();
    }
  }

  /// Pause BGM, AS & CV.
  void pauseALL() {
    pauseBGM();
    pauseAS();
    pauseCV();
  }

  /* resume functions */
  /// Resume BGM paused.
  Future<void> resumeBGM() async {
    await _bgmController?.resume();
  }

  /// Resume AS paused.
  Future<void> resumeAS() async {
    for (AudioPlayer element in _asControllers) {
      await element.resume();
    }
  }

  /// Resume CV paused.
  Future<void> resumeCV() async {
    for (AudioPlayer element in _cvControllers) {
      await element.resume();
    }
  }

  /// Resume BGM, AS & CV paused.
  void resumeALL() async {
    resumeBGM();
    resumeAS();
    resumeCV();
  }

  /* stop functions */
  /// Stop UI audio playing now.
  Future<void> stopUI({bool fadeOut = true}) async {
    if (_uiPlayers != null) {
      if (fadeOut) {
        await _fadeOut(_uiPlayers!, SoundPlayer.ui);
      }
      await _uiPlayers?.stop();
      _uiPlayers = null;
    }
  }

  /// Stop BGM playing now.
  Future<void> stopBGM({bool fadeOut = true}) async {
    if (_bgmController != null) {
      if (fadeOut) {
        await _fadeOut(_bgmController!, SoundPlayer.bgm);
      }
      await _bgmController?.stop();
      _bgmController = null;
    }
  }

  /// Stop all AS playing now.
  Future<void> stopASAll({bool fadeOut = true}) async {
    for (AudioPlayer element in _asControllers) {
      if (fadeOut) {
        await _fadeOut(element, SoundPlayer.as);
      }
      await element.stop();
    }
    _asControllers.clear();
  }

  /// Stop all CV playing now.
  Future<void> stopCVAll({bool fadeOut = false}) async {
    for (AudioPlayer element in _cvControllers) {
      if (fadeOut) {
        await _fadeOut(element, SoundPlayer.cv);
      }
      await element.stop();
    }
    _cvControllers.clear();
  }

  /// Stop all BGM, AS, CV playing now.
  void stopSound() async {
    stopBGM();
    stopASAll();
    stopCVAll();
  }

  /// Stop all UI audio, BGM, AS, CV playing now.
  void stopALL() async {
    stopUI();
    stopBGM();
    stopASAll();
    stopCVAll();
  }

  /* private functions */
  Future<void> _deleteUnnecessaryCaches(
      List<String> necessaryFiles, Map<String, AudioPlayer> caches) async {
    for (String e in caches.keys) {
      if (!necessaryFiles.contains(e)) {
        await caches[e]?.release();
        caches.remove(e);
      } else {
        necessaryFiles.remove(e);
      }
    }
  }

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

  /* getters & setters */
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
    _uiPlayers?.setVolume(_volumes[ui]);
  }

  set bgmVolume(double value) {
    if (value > 1.0) {
      _volumes[bgm] = 1.0;
    } else if (value < 0) {
      _volumes[bgm] = 0.0;
    } else {
      _volumes[bgm] = value;
    }
    _bgmController?.setVolume(_volumes[bgm]);
  }

  set asVolume(double value) {
    if (value > 1.0) {
      _volumes[as] = 1.0;
    } else if (value < 0) {
      _volumes[as] = 0.0;
    } else {
      _volumes[as] = value;
    }
    if (_asControllers.isNotEmpty) {
      for (AudioPlayer element in _asControllers) {
        element.setVolume(_volumes[as]);
      }
    }
  }

  set cvVolume(double value) {
    if (value > 1.0) {
      _volumes[cv] = 1.0;
    } else if (value < 0) {
      _volumes[cv] = 0.0;
    } else {
      _volumes[cv] = value;
    }
    if (_cvControllers.isNotEmpty) {
      for (AudioPlayer element in _cvControllers) {
        element.setVolume(_volumes[cv]);
      }
    }
  }

  PlayerState get uiState => _playersState[ui];
  PlayerState get bgmState => _playersState[bgm];
  PlayerState get asState => _playersState[as];
  PlayerState get cvState => _playersState[cv];

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
  AudioPlayer player;
  PlayerState state;
  _PlayerTuple(this.player, this.state);
}
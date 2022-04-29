import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  static late final AudioCache _seAudioCache = AudioCache(
      prefix: "", fixedPlayer: AudioPlayer(mode: PlayerMode.LOW_LATENCY));
  static AudioPlayer? _sePlayer;
  static PlayerState _seState = PlayerState.STOPPED;
  static double seVolume = 1.0;
  static late final AudioCache _bgmAudioCache =
      AudioCache(prefix: "", fixedPlayer: AudioPlayer());
  static AudioPlayer? _bgmPlayer;
  static PlayerState _bgmState = PlayerState.STOPPED;
  static double bgmVolume = 1.0;

  static void loadSE(List<String> filePaths) {
    _seAudioCache.clearAll();
    _seAudioCache.loadAll(filePaths);
  }

  static void loadBGM(List<String> filePaths) {
    _bgmAudioCache.clearAll();
    _bgmAudioCache.loadAll(filePaths);
  }

  static void playSE(String filePath, {bool loop = false}) async {
    if (_seState != PlayerState.PLAYING) {
      if (loop) {
        _sePlayer = await _seAudioCache.loop(filePath,
            isNotification: true, volume: seVolume);
        _sePlayer!.onPlayerStateChanged.listen((event) {
          _seState = event;
          print(_seState);
        });
        _bgmState = PlayerState.PLAYING;
      } else {
        _sePlayer = await _seAudioCache.play(filePath,
            isNotification: true, volume: seVolume);
      }
    }
  }

  static void stopSE() {
    if (_sePlayer != null) {
      _sePlayer!.stop();
    }
  }

  static void playBGM(String filePath, {bool loop = false}) async {
    if (_bgmState != PlayerState.PLAYING) {
      if (loop) {
        _bgmPlayer = await _bgmAudioCache.loop(filePath,
            isNotification: true, volume: bgmVolume);
        _bgmPlayer!.onPlayerStateChanged.listen((event) {
          _bgmState = event;
          print(_bgmState);
        });
        _bgmState = PlayerState.PLAYING;
      } else {
        _bgmPlayer = await _bgmAudioCache.play(filePath,
            isNotification: true, volume: bgmVolume);
      }
    }
  }

  static void stopBGM() {
    if (_bgmPlayer != null) {
      _bgmPlayer!.stop();
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import '../Wrapper/wrapper_SoundPlayer.dart';

class ResourceManager {
  ResourceManager._internalConstructor();
  static final ResourceManager _singleton =
      ResourceManager._internalConstructor();
  factory ResourceManager() => _singleton;

  final Map<String, Set<String>> _que = {
    "drawable": {},
    "UI": {},
    "BGM": {},
    "SE": {},
    "CV": {},
  };

  final Map<String, Set<String>> _cached = {
    "drawable": {},
    "UI": {},
    "BGM": {},
    "SE": {},
    "CV": {},
  };

  bool _isCaching = false;
  get ready => !_isCaching;

  void addAll(
    BuildContext context, {
    List<String> drawable = const [],
    List<String> ui = const [],
    List<String> bgm = const [],
    List<String> se = const [],
    List<String> cv = const [],
  }) {
    _que["drawable"]?.addAll(drawable);
    _que["UI"]?.addAll(ui);
    _que["BGM"]?.addAll(bgm);
    _que["SE"]?.addAll(se);
    _que["CV"]?.addAll(cv);
    startCaching(context);
  }

  void startCaching(BuildContext context) {
    if (!_isCaching) {
      _cache(context);
    }
  }

  void stopCaching() {
    _isCaching = false;
  }

  Future<void> _cache(BuildContext context) async {
    _isCaching = true;
    /** Cache drawable assets **/
    while (setEquals(_cached["drawable"], _que["drawable"])) {
      Set<String> diff = {...?_que["drawable"]}; // copy _que to diff
      diff.removeAll(_cached["drawable"]!); // que - cached = no-cached
      for (String filepath in diff) {
        await precacheImage(AssetImage(filepath), context);
        _cached["drawable"]!.add(filepath);
      }
    }
    /** Cache UI Audio assets **/
    while (setEquals(_cached["UI"], _que["UI"])) {
      Set<String> diff = {...?_que["UI"]}; // copy _que to diff
      diff.removeAll(_cached["UI"]!); // que - cached = no-cached
      await SoundPlayer()
          .precacheSounds(filePaths: diff.toList(), audioType: SoundPlayer.ui);
      _cached["UI"]!.addAll(diff);
    }
    /** Cache Background Music assets **/
    while (setEquals(_cached["BGM"], _que["BGM"])) {
      Set<String> diff = {...?_que["BGM"]}; // copy _que to diff
      diff.removeAll(_cached["BGM"]!); // que - cached = no-cached
      await SoundPlayer()
          .precacheSounds(filePaths: diff.toList(), audioType: SoundPlayer.bgm);
      _cached["BGM"]!.addAll(diff);
    }
    /** Cache Sound Effect Audio assets **/
    while (setEquals(_cached["SE"], _que["SE"])) {
      Set<String> diff = {...?_que["SE"]}; // copy _que to diff
      diff.removeAll(_cached["SE"]!); // que - cached = no-cached
      await SoundPlayer()
          .precacheSounds(filePaths: diff.toList(), audioType: SoundPlayer.as);
      _cached["SE"]!.addAll(diff);
    }
    /** Cache Character's Voice Audio assets **/
    while (setEquals(_cached["CV"], _que["CV"])) {
      Set<String> diff = {...?_que["CV"]}; // copy _que to diff
      diff.removeAll(_cached["CV"]!); // que - cached = no-cached
      await SoundPlayer()
          .precacheSounds(filePaths: diff.toList(), audioType: SoundPlayer.cv);
      _cached["CV"]!.addAll(diff);
    }
  }
}

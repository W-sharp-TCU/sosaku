import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<String, AnimationProvider> _animationProviders = {};
Map<String, AutoDisposeChangeNotifierProvider<AnimationProvider>>
    _animationADProviders = {};
AnimationWidgetController animationController = AnimationWidgetController();

// TODO : int型のアニメーション実装(もしかしたら軽量化できる？)
// TODO : ジェネリクスに対応させてスマートに
/// WARNING : アニメーションプロバイダはマイフレームウィジェットの再描画を行うため、
/// animationProviderのstateDoubleを利用するウィジェットはビルドの末端に配置する(GestureDetectorなどが反応しない場合がある)
/// This provider manages Double variables for animation.
/// This provider is used by animationController.
class AnimationProvider extends ChangeNotifier {
  late final String _id;
  final Map<String, double> _stateDouble = {};
  final Map<String, dynamic> _stateDynamic = {};
  final Map<String, void Function()?> _animations = {};
  final Map<String, ConfigurableStopwatch> _stopwatches = {};
  final Map<String, Function()?> _callbacks = {};
  int _fps = 60;
  bool _isAnimation = false;

  Map<String, double> get stateDouble => _stateDouble;
  Map<String, dynamic> get stateDynamic => _stateDynamic;
  AnimationProvider(String id) {
    _id = id;
  }

  void addNewStateDouble(String stateName, double initialValue) {
    if (!_stateDouble.containsKey(stateName)) {
      _stateDouble[stateName] = initialValue;
      _animations[stateName] = null;
      _callbacks[stateName] = null;
      _stopwatches[stateName] = ConfigurableStopwatch();
    }
  }

  void addNewStateDynamic(String stateName, String initialValue) {
    if (!_stateDynamic.containsKey(stateName)) {
      _stateDynamic[stateName] = initialValue;
    }
  }

  void setStateDouble(String stateName, double state) {
    if (_stateDouble.containsKey(stateName)) {
      _stateDouble[stateName] = state;
    }
    notifyListeners();
  }

  void setStateDynamic(String stateName, String state) {
    if (_stateDynamic.containsKey(stateName)) {
      _stateDynamic[stateName] = state;
    }
    notifyListeners();
  }

  void setAnimationCallback(String stateName, Function()? callback) async {
    if (_callbacks.containsKey(stateName)) {
      _callbacks[stateName] = callback;
    }
  }

  void loop() async {
    _isAnimation = true;
    while (_isAnimation) {
      if (_animations.values.every((element) => element == null)) {
        _isAnimation = false;
      }

      for (String stateName in _stateDouble.keys) {
        if (_animations[stateName] == null) {
          _callbacks[stateName]?.call();
          _callbacks[stateName] = null;
        } else {
          _animations[stateName]?.call();
        }
      }
      notifyListeners();
      await Future.delayed(Duration(milliseconds: (1000 / _fps).ceil()));
    }
  }

  @override
  void dispose() {
    _isAnimation = false;
    _animationProviders.remove(_id);
    _animationADProviders.remove(_id);
    super.dispose();
  }
}

class AnimationWidgetController {
  /// Create an AutoDisposeChangeNotifierProvider that manages the variables to be animated.
  /// This function should be called within the build function of the UI.
  ///
  /// @param providerId : ID of the provider to be created
  /// @param statesDouble : Map of state names and their initial values(animatable)
  /// @param statesDynamic : Map of state names and their initial values(non-animatable)
  /// @return Instance of AutoDisposeChangeNotifierProvider
  ///
  /// Here is an example of use.
  ///
  /// Widget build(BuildContext context, WidgetRef ref) {
  ///
  ///   final widget = animationController.createProvider('widget',{
  ///     'width' : 0.05,
  ///     'height' : 0.05
  ///   });
  ///
  ///   return Container(
  ///     width: ref.watch(widget).stateDouble['width']! *
  ///         GetScreenSize.screenWidth(),
  ///     height: ref.watch(widget).stateDouble['height']! *
  ///         GetScreenSize.screenWidth()
  ///   );
  /// }
  AutoDisposeChangeNotifierProvider<AnimationProvider> createProvider(
      String providerId, Map<String, double> statesDouble,
      [Map<String, dynamic>? statesDynamic]) {
    if (!_animationProviders.containsKey(providerId)) {
      _animationProviders[providerId] = AnimationProvider(providerId);
      _animationADProviders[providerId] = ChangeNotifierProvider.autoDispose(
          (ref) => _animationProviders[providerId]!);
    }
    addNewStatesDouble(providerId, statesDouble);
    addNewStatesDynamic(providerId, statesDynamic ?? {});
    return _animationADProviders[providerId]!;
  }

  /// Get Provider(ChangeNotifier) by specifying ID.
  ///
  /// @param providerId : ID of provider to be get
  /// @return Instance of ChangeNotifier
  AnimationProvider? getProvider(String providerId) {
    return _animationProviders[providerId];
  }

  AutoDisposeChangeNotifierProvider<AnimationProvider>? getAutoDisposeProvider(
      String providerId) {
    return _animationADProviders[providerId];
  }

  /// Add a new states(double) and their initial values to an already created provider.
  ///
  /// @param providerId : ID of the provider to which the state is to be added
  /// @param states : Map of state names and their initial values
  void addNewStatesDouble(String providerId, Map<String, double> states) {
    for (String stateName in states.keys) {
      _animationProviders[providerId]
          ?.addNewStateDouble(stateName, states[stateName] ?? 0);
    }
  }

  /// Add a new states(dynamic) and their initial values to an already created provider.
  ///
  /// @param providerId : ID of the provider to which the state is to be added
  /// @param states : Map of state names and their initial values
  void addNewStatesDynamic(String providerId, Map<String, dynamic> states) {
    for (String stateName in states.keys) {
      _animationProviders[providerId]
          ?.addNewStateDynamic(stateName, states[stateName]);
    }
  }

  /// Assigns a double value to a stateDouble that already exists.
  ///
  /// @param providerId : ID of the provider
  /// @param states : Map of state names and their initial values
  void setStatesDouble(String providerId, Map<String, double> states) async {
    while (!_animationProviders.containsKey(providerId)) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
    for (String stateId in states.keys) {
      _animationProviders[providerId]
          ?.setStateDouble(stateId, states[stateId]!);
    }
  }

  /// Assigns a dynamic value to a stateDynamic that already exists.
  ///
  /// @param providerId : ID of the provider
  /// @param states : Map of state names and their initial values
  void setStatesDynamic(String providerId, Map<String, dynamic> states) async {
    while (!_animationProviders.containsKey(providerId)) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
    for (String stateId in states.keys) {
      _animationProviders[providerId]
          ?.setStateDynamic(stateId, states[stateId]!);
    }
  }

  /// Sets the callback to be called when the animation of each state ends.
  ///
  /// @param providerId : ID of the provider
  /// @param callbacks : Map of state names and their callback functions
  void setCallbacks(String providerId, Map<String, Function()?> callbacks) {
    for (String stateId in callbacks.keys) {
      _animationProviders[providerId]
          ?.setAnimationCallback(stateId, callbacks[stateId]);
    }
  }

  double getStateDouble(String providerId, String stateId) {
    return _animationProviders[providerId]!.stateDouble[stateId]!;
  }

  dynamic getStateDynamic(String providerId, String stateId) {
    return _animationProviders[providerId]!.stateDynamic[stateId]!;
  }

  bool isAnimation(String providerId, [String? stateId]) {
    if (stateId == null) {
      return _animationProviders[providerId]!._isAnimation;
    } else {
      return (_animationProviders[providerId]?._animations[stateId] != null);
    }
  }

  void setFPS(String providerId, int fps) {
    _animationProviders[providerId]?._fps = fps;
  }

  /// Start animation.
  /// This function for controller.
  ///
  /// @param providerId : Provider id to manage multiple states together
  /// @param stateId  : Variable id to be animated
  /// @param animations : List of animations to run
  /// @param repeat : Number of animation iterations (default 1, -1 for infinite loop)
  Future<void> animate(
      String providerId, String stateId, List<CustomAnimation> animations,
      [int repeat = 1]) async {
    while (!_animationProviders.containsKey(providerId) ||
        !_animationProviders[providerId]!._stateDouble.containsKey(stateId)) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
    if (_animationProviders.containsKey(providerId) &&
        _animationProviders[providerId]!._stateDouble.containsKey(stateId)) {
      int duration = 0;
      _animationProviders[providerId]?._stopwatches[stateId]?.reset();
      _animationProviders[providerId]?._stopwatches[stateId]?.start();

      for (CustomAnimation animation in animations) {
        if (duration < animation.timeEnd) {
          duration = animation.timeEnd;
        }
      }

      void animation() {
        if (_animationProviders[providerId]!
                    ._stopwatches[stateId]!
                    .elapsedMilliseconds <
                duration * repeat ||
            repeat == -1) {
          for (CustomAnimation animation in animations) {
            _animationProviders[providerId]?._stateDouble[stateId] =
                animation.getValue(_animationProviders[providerId]!
                            ._stopwatches[stateId]!
                            .elapsedMilliseconds %
                        duration) ??
                    _animationProviders[providerId]?._stateDouble[stateId] ??
                    0;
          }
        } else {
          for (CustomAnimation animation in animations) {
            _animationProviders[providerId]?._stateDouble[stateId] =
                animation.getValue(duration) ??
                    _animationProviders[providerId]?._stateDouble[stateId] ??
                    0;
          }
          stopAnimation(providerId, stateId);
        }
      }

      _animationProviders[providerId]?._animations[stateId] = animation;
      _animationProviders[providerId]?.loop();
    }
  }

  void stopAnimation(String providerId, String stateId) {
    if (_animationProviders.containsKey(providerId)) {
      _animationProviders[providerId]?._animations[stateId] = null;
      _animationProviders[providerId]?._stopwatches[stateId]?.stop();
      _animationProviders[providerId]?._stopwatches[stateId]?.reset();
    }
  }

  void skipAnimation(String providerId, String stateId) {
    if (_animationProviders.containsKey(providerId)) {
      _animationProviders[providerId]
          ?._stopwatches[stateId]
          ?.setMilliseconds(double.maxFinite.toInt());
    }
  }

  void pauseAnimation(String providerId, String stateId) {
    if (_animationProviders.containsKey(providerId)) {
      _animationProviders[providerId]?._stopwatches[stateId]?.stop();
    }
  }

  void restartAnimation(String providerId, String stateId) {
    if (_animationProviders.containsKey(providerId)) {
      _animationProviders[providerId]?._stopwatches[stateId]?.start();
    }
  }
}

abstract class CustomAnimation {
  final int _timeBegin;
  final int _timeEnd;
  bool _isReverse = false;

  int get timeBegin => _timeBegin;
  int get timeEnd => _timeEnd;
  bool get isReverse => _isReverse;

  CustomAnimation(this._timeBegin, this._timeEnd);
  double? getValue(int time) {
    if (_isReverse) {
      time = -time + 2 * (_timeEnd - _timeBegin);
    }
    if (_timeBegin <= time && time <= _timeEnd && _timeEnd - _timeBegin > 0) {
      return _func(time);
    } else {
      return null;
    }
  }

  double? _func(int time);
  CustomAnimation reverse() {
    _isReverse = true;
    return this;
  }
}

class Linear extends CustomAnimation {
  final double _begin;
  final double _end;

  Linear(int _timeBegin, int _timeEnd, this._begin, this._end)
      : super(_timeBegin, _timeEnd);

  @override
  double? _func(int time) {
    return _begin +
        (_end - _begin) * ((time - _timeBegin) / (_timeEnd - _timeBegin));
  }
}

class Wave extends CustomAnimation {
  double min;
  double max;
  double t;
  double phi;

  Wave(int _timeBegin, int _timeEnd, this.min, this.max, this.t, this.phi)
      : super(_timeBegin, _timeEnd);

  @override
  double? _func(int time) {
    return ((max - min) / 2) +
        min +
        ((max - min) / 2) * sin(2 * pi * (time / t) + phi * pi);
  }
}

class Pause extends CustomAnimation {
  Pause(int _timeBegin, int _timeEnd) : super(_timeBegin, _timeEnd);
  @override
  double? _func(int time) {
    return null;
  }
}

class Easing extends CustomAnimation {
  final double _begin;
  final double _end;
  String _type = '';

  Easing(int _timeBegin, int _timeEnd, this._begin, this._end)
      : super(_timeBegin, _timeEnd);

  /// Use only if you want to specify the Easing type as a String.
  /// Use functions such as inQuint if not needed.
  CustomAnimation setType(String type) {
    assert(type == 'InQuint' ||
        type == 'OutQuint' ||
        type == 'InOutQuint' ||
        type == 'InElastic' ||
        type == 'OutElastic' ||
        type == 'InOutElastic');
    _type = type;
    return this;
  }

  CustomAnimation inQuint() {
    _type = 'InQuint';
    return this;
  }

  CustomAnimation outQuint() {
    _type = 'OutQuint';
    return this;
  }

  CustomAnimation inOutQuint() {
    _type = 'InOutQuint';
    return this;
  }

  CustomAnimation inElastic() {
    _type = 'InElastic';
    return this;
  }

  CustomAnimation outElastic() {
    _type = 'OutElastic';
    return this;
  }

  CustomAnimation inOutElastic() {
    _type = 'InOutElastic';
    return this;
  }

  @override
  double? _func(int time) {
    double t = (time - _timeBegin) / (_timeEnd - _timeBegin);
    if (t == 0) {
      return _begin;
    } else if (t == 1) {
      return _end;
    } else {
      switch (_type) {
        case 'InQuint':
          return (_end - _begin) * (pow(t, 5)) + _begin;
        case 'OutQuint':
          return (_end - _begin) * (1 - pow(1 - t, 5)) + _begin;
        case 'InOutQuint':
          return t < 0.5
              ? (_end - _begin) * (16 * pow(t, 5)) + _begin
              : (_end - _begin) * (1 - pow(-2 * t + 2, 5) / 2) + _begin;
        case 'InElastic':
          return (_end - _begin) *
                  (-pow(2, 10 * t - 10) *
                      sin((t * 10 - 10.75) * (2 * pi / 3))) +
              _begin;
        case 'OutElastic':
          return (_end - _begin) *
                  (pow(2, -10 * t) * sin((t * 10 - 0.75) * (2 * pi / 3)) + 1) +
              _begin;
        case 'InOutElastic':
          return t < 0.5
              ? (_end - _begin) *
                      (-pow(2, 20 * t - 10) *
                          sin((t * 20 - 11.125) * (2 * pi / 4.5)) /
                          2) +
                  _begin
              : (_end - _begin) *
                      (pow(2, -20 * t + 10) *
                              sin((t * 20 - 11.125) * (2 * pi / 4.5)) /
                              2 +
                          1) +
                  _begin;
        default:
          // linear
          return _begin +
              (_end - _begin) * ((time - _timeBegin) / (_timeEnd - _timeBegin));
      }
    }
  }
}

/// 経過時間を加算したり、指定することができるストップウォッチ
/// TODO : これを使わないAnimationControllerの実装
class ConfigurableStopwatch extends Stopwatch {
  int _skipMilliseconds = 0;
  @override
  int get elapsedMilliseconds => super.elapsedMilliseconds + _skipMilliseconds;
  void skipMilliseconds(int milliseconds) {
    _skipMilliseconds += milliseconds;
  }

  void setMilliseconds(int milliseconds) {
    _skipMilliseconds = milliseconds - elapsedMilliseconds;
  }
}

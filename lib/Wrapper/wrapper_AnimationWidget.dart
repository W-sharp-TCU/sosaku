import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<String, AnimationProvider> _animationProviders = {};
Map<String, AutoDisposeChangeNotifierProvider<AnimationProvider>>
    _animationADProviders = {};
AnimationWidgetController animationController = AnimationWidgetController();

/// This provider manages Double variables for animation.
/// This provider is used by animationController.
class AnimationProvider extends ChangeNotifier {
  late final String _id;
  final Map<String, double> _stateDouble = {};
  final Map<String, void Function()?> _animations = {};
  final Map<String, Stopwatch> _stopwatches = {};
  final Map<String, Function()?> _callbacks = {};
  bool _isAnimation = false;

  Map<String, double> get stateDouble => _stateDouble;
  bool _isAnimation = false;
  AnimationProvider(String id) {
    _id = id;
  }

  void addNewState(String stateName, double initialValue) {
    if (!_stateDouble.containsKey(stateName)) {
      _stateDouble[stateName] = initialValue;
      _animations[stateName] = null;
      _callbacks[stateName] = null;
      _stopwatches[stateName] = Stopwatch();
    }
  }

  void setStateDouble(String stateName, double state) {
    if (_stateDouble.containsKey(stateName)) {
      _stateDouble[stateName] = state ?? 0;
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
<<<<<<< HEAD
      print('loop');
=======
>>>>>>> develop
      _isAnimation = false;
      for (void Function()? animation in _animations.values) {
        if (animation != null) {
          _isAnimation = true;
          break;
        }
      }
      for (String stateName in _stateDouble.keys) {
        _animations[stateName]?.call();
        if (_animations[stateName] == null && _callbacks[stateName] != null) {
          Function()? callback = _callbacks[stateName];
          _callbacks[stateName] = null;
          callback?.call();
        }
      }
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 16));
    }
  }

  @override
  void dispose() {
<<<<<<< HEAD
    print('dispose$_id');
=======
>>>>>>> develop
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
  /// @param states : Map of state names and their initial values
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
      String providerId, Map<String, double> states) {
    print('createprovider');
    if (!_animationProviders.containsKey(providerId)) {
      _animationProviders[providerId] = AnimationProvider(providerId);
      _animationADProviders[providerId] = ChangeNotifierProvider.autoDispose(
          (ref) => _animationProviders[providerId]!);
    }
    addNewState(providerId, states);
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

  /// Add a new states and their initial values to an already created provider.
  ///
  /// @param providerId : ID of the provider to which the state is to be added
  /// @param states : Map of state names and their initial values
  void addNewState(String providerId, Map<String, double> states) {
    for (String stateName in states.keys) {
      _animationProviders[providerId]
          ?.addNewState(stateName, states[stateName] ?? 0);
    }
  }

<<<<<<< HEAD
  void animate(
      String widgetId, String stateId, List<Animation> animations) async {
    print('animate');
    await Future.delayed(const Duration(milliseconds: 16));
    print(_animationProviders);
    if (_animationProviders.containsKey(widgetId) &&
        _animationProviders[widgetId]!._stateDouble.containsKey(stateId)) {
      print('animate if true');
=======
  /// Assigns a value to a state that already exists.
  ///
  /// @param providerId : ID of the provider
  /// @param states : Map of state names and their initial values
  void setStates(String providerId, Map<String, double> states) async {
    while (!_animationProviders.containsKey(providerId)) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
    for (String stateId in states.keys) {
      _animationProviders[providerId]
          ?.setStateDouble(stateId, states[stateId]!);
    }
  }

  void setState(String providerId, String stateId, double state) async {
    while (!_animationProviders.containsKey(providerId)) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
    _animationProviders[providerId]?.setStateDouble(stateId, state);
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

  void setCallback(String providerId, String stateId, Function()? callback) {
    _animationProviders[providerId]?.setAnimationCallback(stateId, callback);
  }

  bool isAnimation(String providerId, String stateId) {
    return (_animationProviders[providerId]?._animations[stateId] != null);
  }

  /// Start animation.
  /// This function for controller.
  ///
  /// @param providerId : Provider id to manage multiple states together
  /// @param stateId  : Variable id to be animated
  /// @param animations : List of animations to run
  /// @param repeat : Number of animation iterations (default 1, -1 for infinite loop)
  /// if(visible = true);
  /// animate
  Future<void> animate(
      String providerId, String stateId, List<Animation> animations,
      [int repeat = 1]) async {
    while (!_animationProviders.containsKey(providerId) ||
        !_animationProviders[providerId]!._stateDouble.containsKey(stateId)) {
      await Future.delayed(const Duration(milliseconds: 1));
    }
    if (_animationProviders.containsKey(providerId) &&
        _animationProviders[providerId]!._stateDouble.containsKey(stateId)) {
>>>>>>> develop
      int duration = 0;
      _animationProviders[providerId]?._stopwatches[stateId]?.reset();
      _animationProviders[providerId]?._stopwatches[stateId]?.start();

      for (Animation animation in animations) {
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
          for (Animation animation in animations) {
            _animationProviders[providerId]?._stateDouble[stateId] =
                animation.getValue(_animationProviders[providerId]!
                            ._stopwatches[stateId]!
                            .elapsedMilliseconds %
                        duration) ??
                    _animationProviders[providerId]?._stateDouble[stateId] ??
                    0;
          }
        } else {
          for (Animation animation in animations) {
            _animationProviders[providerId]?._stateDouble[stateId] =
                animation.getValue(duration) ??
                    _animationProviders[providerId]?._stateDouble[stateId] ??
                    0;
          }
          stopAnimation(providerId, stateId);
        }
      }

<<<<<<< HEAD
      _animationProviders[widgetId]?._animations[stateId] = animation;
      _animationProviders[widgetId]?.loop();
      print('startloop');
=======
      _animationProviders[providerId]?._animations[stateId] = animation;
      _animationProviders[providerId]?.loop();
>>>>>>> develop
    }
  }

  void stopAnimation(String providerId, String stateId) {
    if (_animationProviders.containsKey(providerId)) {
      _animationProviders[providerId]?._animations[stateId] = null;
      _animationProviders[providerId]?._stopwatches[stateId]?.stop();
      _animationProviders[providerId]?._stopwatches[stateId]?.reset();
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

abstract class Animation {
  final int _timeBegin;
  final int _timeEnd;
  bool _isReverse = false;

  int get timeBegin => _timeBegin;
  int get timeEnd => _timeEnd;
  bool get isReverse => _isReverse;

  Animation(this._timeBegin, this._timeEnd);
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
  Animation reverse() {
    _isReverse = true;
    return this;
  }
}

class Linear extends Animation {
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

class Wave extends Animation {
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

class Pause extends Animation {
  Pause(int _timeBegin, int _timeEnd) : super(_timeBegin, _timeEnd);
  @override
  double? _func(int time) {
    return null;
  }
}

class Easing extends Animation {
  final double _begin;
  final double _end;
  String _type = '';

  Easing(int _timeBegin, int _timeEnd, this._begin, this._end)
      : super(_timeBegin, _timeEnd);

  Animation inQuint() {
    _type = 'InQuint';
    return this;
  }

  Animation outQuint() {
    _type = 'OutQuint';
    return this;
  }

  Animation inOutQuint() {
    _type = 'InOutQuint';
    return this;
  }

  Animation inElastic() {
    _type = 'InElastic';
    return this;
  }

  Animation outElastic() {
    _type = 'OutElastic';
    return this;
  }

  Animation inOutElastic() {
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
      }
    }
  }
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<String, AnimationProvider> _animationProviders = {};
Map<String, AutoDisposeChangeNotifierProvider<AnimationProvider>>
    _animationADProviders = {};
AnimationWidgetController animationController = AnimationWidgetController();

class AnimationProvider extends ChangeNotifier {
  late final String _id;
  final Map<String, double> _stateDouble = {};
  final Map<String, double> _defaultState = {};
  final Map<String, void Function()?> _animations = {};
  final Map<String, Stopwatch> _stopwatches = {};
  Map<String, double> get stateDouble => _stateDouble;
  bool _isAnimation = false;
  AnimationProvider(String id) {
    _id = id;
  }

  void addNewState(String stateName, double initialValue) {
    if (!_stateDouble.containsKey(stateName)) {
      _stateDouble[stateName] = initialValue;
      if (!_defaultState.containsKey(stateName)) {
        _defaultState[stateName] = initialValue;
      }
      _animations[stateName] = null;
      _stopwatches[stateName] = Stopwatch();
    }
  }

  void setStateDouble(Map<String, double> states) {
    for (String stateName in states.keys) {
      if (_stateDouble.containsKey(stateName)) {
        _stateDouble[stateName] = states[stateName] ?? 0;
      }
    }
    notifyListeners();
  }

  void loop() async {
    _isAnimation = true;
    while (_isAnimation) {
      print('loop');
      _isAnimation = false;
      for (void Function()? animation in _animations.values) {
        if (animation != null) {
          _isAnimation = true;
          break;
        }
      }
      for (String stateName in _stateDouble.keys) {
        _animations[stateName]?.call();
      }
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 16));
    }
  }

  @override
  void dispose() {
    print('dispose$_id');
    _isAnimation = false;
    _animationProviders.remove(_id);
    _animationADProviders.remove(_id);
    super.dispose();
  }
}
// state = controller.createProvider()
// state.addState('', 0)
// ref.watch(state).stateName

class AnimationWidgetController {
  AutoDisposeChangeNotifierProvider<AnimationProvider> createProvider(
      String providerId, Map<String, double> states) {
    print('createprovider');
    if (!_animationProviders.containsKey(providerId)) {
      _animationProviders[providerId] = AnimationProvider(providerId);
      _animationADProviders[providerId] = ChangeNotifierProvider.autoDispose(
          (ref) => _animationProviders[providerId]!);
    }
    for (String stateName in states.keys) {
      _animationProviders[providerId]
          ?.addNewState(stateName, states[stateName] ?? 0);
    }

    return _animationADProviders[providerId]!;
  }
  //
  // void addNewState(String widgetId, String stateName, double initialValue) {
  //   _animationProviders[widgetId]?.addNewState(stateName, initialValue);
  // }

  void animate(
      String widgetId, String stateId, List<Animation> animations) async {
    print('animate');
    await Future.delayed(const Duration(milliseconds: 16));
    print(_animationProviders);
    if (_animationProviders.containsKey(widgetId) &&
        _animationProviders[widgetId]!._stateDouble.containsKey(stateId)) {
      print('animate if true');
      int duration = 0;
      _animationProviders[widgetId]?._stopwatches[stateId]?.reset();
      _animationProviders[widgetId]?._stopwatches[stateId]?.start();

      for (Animation animation in animations) {
        if (duration < animation.timeEnd) {
          duration = animation.timeEnd;
        }
      }

      void animation() {
        if (_animationProviders[widgetId]!
                ._stopwatches[stateId]!
                .elapsedMilliseconds <
            duration) {
          for (Animation animation in animations) {
            _animationProviders[widgetId]?.stateDouble[stateId] =
                animation.getValue(_animationProviders[widgetId]!
                        ._stopwatches[stateId]!
                        .elapsedMilliseconds) ??
                    _animationProviders[widgetId]?.stateDouble[stateId] ??
                    0;
          }
        } else {
          stopAnimation(widgetId, stateId);
        }
      }

      _animationProviders[widgetId]?._animations[stateId] = animation;
      _animationProviders[widgetId]?.loop();
      print('startloop');
    }
  }

  void stopAnimation(String widgetId, String stateId) {
    if (_animationProviders.containsKey(widgetId)) {
      _animationProviders[widgetId]?._animations[stateId] = null;
      _animationProviders[widgetId]?._stopwatches[stateId]?.stop();
      _animationProviders[widgetId]?._stopwatches[stateId]?.reset();
    }
  }
}

abstract class Animation {
  final int _timeBegin;
  final int _timeEnd;

  int get timeBegin => _timeBegin;
  int get timeEnd => _timeEnd;

  Animation(this._timeBegin, this._timeEnd);
  double? getValue(int time) {
    if (_timeBegin <= time && time < _timeEnd) {
      return func(time);
    } else {
      return null;
    }
  }

  double func(int time);
}

class Linear extends Animation {
  final double _begin;
  final double _end;

  Linear(int _timeBegin, int _timeEnd, this._begin, this._end)
      : super(_timeBegin, _timeEnd);

  @override
  double func(int time) {
    return _begin +
        (_end - _begin) * ((time - _timeBegin) / (_timeEnd - _timeBegin));
  }
}

class Wave extends Animation {
  double min;
  double max;
  double t;

  Wave(int _timeBegin, int _timeEnd, this.min, this.max, this.t)
      : super(_timeBegin, _timeEnd);

  @override
  double func(int time) {
    return ((max - min) / 2) +
        min +
        ((max - min) / 2) * sin((1 / 500 * t) * pi * time);
  }
}

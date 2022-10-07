import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Conversation/UI_conversation_ConversationScreen.dart';

import '../Wrapper/wrapper_AnimationWidget.dart';

enum Name { ayana, nonono, neneka, sakaki, kawamoto }

enum Face { angry, flat, normal, puzzle, smile }

enum Mouth { open, close }

enum Eye { open, close }

enum Animation { shake }

class LayerData {
  late final String _layerId;
  late final String name;
  String face = 'normal';
  String mouth = 'close';
  String eye = 'open';
  late final AutoDisposeChangeNotifierProvider<AnimationProvider>
      _animationProvider;

  double? position;
  late double positionX;
  final List<Function()?> animations = [];
  final bool _isAnimation = false;

  String get layerId => _layerId;

  AutoDisposeChangeNotifierProvider<AnimationProvider> get animationProvider =>
      _animationProvider;
  LayerData(this._layerId, this.positionX) {
    _animationProvider =
        animationController.createProvider('${_layerId}characterAnimation', {
      'positionX': positionX,
      'positionY': 0,
      'rotate': 0,
      'ratio': 0,
      'brightness': 1,
      'opacity': 0
    });

    if (_layerId.contains('あやな')) {
      name = 'Ayana';
    } else if (_layerId.contains('ののの')) {
      name = 'Nonono';
    } else if (_layerId.contains('音々花')) {
      name = 'Neneka';
    } else if (_layerId.contains('榊')) {
      name = 'Sakaki';
    } else if (_layerId.contains('川本')) {
      name = 'Kawamoto';
    }
  }
  // void moveToX(double x) {
  //   animationController.animate('characterPosition', '${_layerId}positionX',
  //       [Linear(0, 500, _positionX, x)]);
  //   animationController.setCallbacks('characterPosition', {
  //     '${_layerId}positionX': () {
  //       _positionX = x;
  //       position = position != null ? x : null;
  //     }
  //   });
  // }
}

class ConversationCharacterController {
  void characterIn(String layerId, String animation) {}
  void characterOut(String layerId, String animation) {}
  void position(String layerId, double position) {}
  void expression(String layerId, Face face) {}
  void mouth(String layerId, Mouth mouth) {}
  void eye(String layerId, Eye eye) {}
  void applyChanges() {}
}

class ConversationCharacterProvider extends ChangeNotifier {
  final Map<String, LayerData> _layers = {};
  int animationNum = 0;
  bool get isAnimation => animationNum > 0;
  Map<String, LayerData> get layers => _layers;
  void update() {
    for (LayerData layer in _layers.values) {
      while (layer.animations.isNotEmpty) {
        layer.animations[0]?.call();
        layer.animations.removeAt(0);
      }
    }
    notifyListeners();
  }
  // void characterIn(String layerName) {
  //   int i = 0;
  //   for (LayerData layer in _layers.values) {
  //     layer.moveToX((i + 1) / (_layers.length + 2));
  //     i++;
  //   }
  //   _layers[layerName] = LayerData(layerName, (i + 1) / (_layers.length + 2));
  //   animationController.animate(
  //       'characterPosition', '${layerName}opacity', [Linear(500, 1000, 0, 1)]);
  // }
}

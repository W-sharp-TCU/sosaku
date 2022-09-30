import 'package:flutter/cupertino.dart';

import '../Wrapper/wrapper_AnimationWidget.dart';

class LayerData {
  late final String _layerId;
  late final String _name;
  late final String _face;
  double? _position;
  late double _positionX;
  late double _positionY;

  String get layerId => _layerId;
  String get name => _name;
  String get face => _face;
  double get positionX => _positionX;
  double get positionY => _positionY;
  LayerData(this._layerId, this._positionX) {
    animationController.addNewState('characterPosition',
        {'${_layerId}positionX': _positionX, '${_layerId}opacity': 0});
    if (_layerId.contains('あやな')) {
      _name = 'Ayana';
      _face = 'normal';
    }
  }
  void moveToX(double x) {
    animationController.animate('characterPosition', '${_layerId}positionX',
        [Linear(0, 500, _positionX, x)]);
    animationController.setCallback('characterPosition', {
      '${_layerId}positionX': () {
        _positionX = x;
      }
    });
  }
}

class ConversationCharacterProvider extends ChangeNotifier {
  // レイヤー名
  // キャラ名
  // 位置
  // 参照位置
  // サイズ
  // 参照サイズ
  // 色
  // 参照色
  // 表情
  // isAnimation
  final Map<String, LayerData> _layers = {};
  Map<String, LayerData> get layers => _layers;
  void characterIn(String layerName) {
    int i = 0;
    for (LayerData layer in _layers.values) {
      layer.moveToX((i + 1) / (_layers.length + 2));
      i++;
    }
    _layers[layerName] = LayerData(layerName, (i + 1) / (_layers.length + 2));
    animationController.animate(
        'characterPosition', '${layerName}opacity', [Linear(500, 1000, 0, 1)]);
  }
}

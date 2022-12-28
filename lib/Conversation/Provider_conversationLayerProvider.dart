import 'package:flutter/cupertino.dart';
import '../Wrapper/wrapper_AnimationWidget.dart';

class ConversationImageLayerProvider extends ChangeNotifier {
  final String _layerId;
  String _imagePath;
  late final _animationProvider;
  final List<Function()?> _animations = [];

  // getter
  String get layerId => _layerId;
  String get imagePath => _imagePath;

  /// posX, posY, width, height, rotX, rotY, rotZ, opacity, brightness
  String get animationProvider => _animationProvider;

  ConversationImageLayerProvider(
    this._layerId,
    this._imagePath, {
    double posX = 0,
    double posY = 0,
    double width = 1,
    double height = 1,
    double rotX = 0,
    double rotY = 0,
    double rotZ = 0,
    double opacity = 1,
    double brightness = 1,
  }) {
    _animationProvider = animationController.createProvider(_layerId, {
      'posX': posX,
      'posY': posY,
      'width': width,
      'height': height,
      'rotX': rotX,
      'rotY': rotY,
      'rotZ': rotZ,
      'opacity': opacity,
      'brightness': brightness,
    });
  }

  void setImagePath(String imagePath) {
    _imagePath = imagePath;
  }

  void customAnimation(String stateId, String animationFunc) {
    // String to List
    List<String> words = animationFunc.split(',');
    String func = words[0];
    List<String> args = words.sublist(1);
    // add animation to animations
    CustomAnimation animation;
    switch (func) {
      case 'Linear':
        animation = Linear(int.parse(args[0]), int.parse(args[1]),
            double.parse(args[2]), double.parse(args[3]));
        break;
      case 'Wave':
        animation = Wave(
            int.parse(args[0]),
            int.parse(args[1]),
            double.parse(args[2]),
            double.parse(args[3]),
            double.parse(args[4]),
            double.parse(args[5]));
        break;
      case 'Pause':
        animation = Pause(
          int.parse(args[0]),
          int.parse(args[1]),
        );
        break;
      case 'Easing':
        animation = Easing(int.parse(args[0]), int.parse(args[1]),
                double.parse(args[2]), double.parse(args[3]))
            .setType(args[4]);
        break;
      default:
        throw ('AnimationFunc "$func" is not defined');
    }
    _animations.add(() {
      animationController.animate(_layerId, stateId, [animation]);
    });
  }
}

class ConversationCharacterLayerProvider
    extends ConversationImageLayerProvider {
  String _characterName = '';
  String _face = 'normal';
  String _eye = 'open';
  String _mouth = 'close';
  bool _isAutoAlign = true;
  bool _isAutoBlink = true;
  bool _isAutoBreath = true;
  bool _isAutoGrayOut = true;

  bool get isAutoAlign => _isAutoAlign;
  bool get isAutoBlink => _isAutoBlink;
  bool get isAutoBreath => _isAutoBreath;
  bool get isAutoGrayOut => _isAutoGrayOut;

  ConversationCharacterLayerProvider(
    String layerId,
    String imagePath, {
    double posX = 0,
    double posY = 0,
    double width = 1,
    double height = 1,
    double rotX = 0,
    double rotY = 0,
    double rotZ = 0,
    double opacity = 1,
    double brightness = 1,
  }) : super(layerId, imagePath,
            posX: posX,
            posY: posY,
            width: width,
            height: height,
            rotX: rotX,
            rotY: rotY,
            rotZ: rotZ,
            opacity: opacity,
            brightness: brightness) {
    _imagePath =
        'assets/drawable/CharacterImage/$_characterName/$_face-mouth_$_mouth-eye_$_eye.png';
  }
}

class ConversationBGLayerProvider extends ConversationImageLayerProvider {
  String BGname = '';
  ConversationBGLayerProvider(
    String layerId,
    String imagePath, {
    double posX = 0,
    double posY = 0,
    double width = 1,
    double height = 1,
    double rotX = 0,
    double rotY = 0,
    double rotZ = 0,
    double opacity = 1,
    double brightness = 1,
  }) : super(layerId, imagePath,
            posX: posX,
            posY: posY,
            width: width,
            height: height,
            rotX: rotX,
            rotY: rotY,
            rotZ: rotZ,
            opacity: opacity,
            brightness: brightness);
}

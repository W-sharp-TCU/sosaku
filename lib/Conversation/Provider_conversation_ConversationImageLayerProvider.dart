import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sosaku/Wrapper/wrapper_CharacterNames.dart';
import '../Wrapper/wrapper_AnimationWidget.dart';

class ConversationImageLayerProvider extends ChangeNotifier {
  final String _layerId;
  late final _animationProvider;
  final List<Function()?> _animations = [];

  // getter
  String get layerId => _layerId;
  bool get isAnimation => animationController.isAnimation(_layerId);

  /// posX, posY, width, height, rotX, rotY, rotZ, opacity, brightness
  AutoDisposeChangeNotifierProvider<AnimationProvider> get animationProvider =>
      _animationProvider;

  ConversationImageLayerProvider(
    this._layerId, {
    String imagePath = '',
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
    }, {
      'imagePath': imagePath,
    });
    setImagePath(imagePath);
  }

  void setImagePath(String imagePath) {
    _animations.add(() {
      animationController.setStatesDynamic(_layerId, {'imagePath': imagePath});
    });
  }

  void defaultAnimation(String animationName) {
    switch (animationName) {
      case ('shake'):
        shake();
        break;
      case ('bow'):
        bow();
        break;
      case ('jump'):
        jump();
        break;
      case ('zoomIn'):
        zoomIn();
        break;
      case ('zoomOut'):
        zoomOut();
        break;
      case ('fadeIn'):
        fadeIn();
        break;
      case ('fadeOut'):
        fadeOut();
        break;
      case ('grayOut'):
        grayOut();
        break;
      case ('highLight'):
        highlight();
        break;
      case ('walk'):
        walk();
        break;
      case ('run'):
        run();
        break;
    }
  }

  void moveTo(double dstPosX) {
    double srcPosX = animationController.getStateDouble(_layerId, 'posX');
    _animations.add(() {
      animationController
          .animate(_layerId, 'posX', [Linear(0, 1000, srcPosX, dstPosX)]);
    });
  }

  void shake() {
    double posX = animationController.getStateDouble(_layerId, 'posX');
    _animations.add(() {
      animationController.animate(
          _layerId, 'posX', [Wave(0, 500, posX - 0.005, posX + 0.005, 100, 0)]);
    });
  }

  void bow() {
    double posY = animationController.getStateDouble(_layerId, 'posY');
    _animations.add(() {
      animationController.animate(
          _layerId, 'posY', [Wave(0, 500, posY, posY + 0.03, 500, -0.5)]);
    });
  }

  void jump() {
    double posY = animationController.getStateDouble(_layerId, 'posY');
    _animations.add(() {
      animationController.animate(
          _layerId, 'posY', [Wave(0, 500, posY - 0.03, posY, 500, 0.5)]);
    });
  }

  void zoomIn() {
    double width = animationController.getStateDouble(_layerId, 'width');
    double height = animationController.getStateDouble(_layerId, 'height');
    double posY = animationController.getStateDouble(_layerId, 'posY');
    _animations.add(() {
      animationController
          .animate(_layerId, 'width', [Linear(0, 500, width, width * 1.33)]);
      animationController
          .animate(_layerId, 'height', [Linear(0, 500, height, height * 1.33)]);
      animationController.animate(
          _layerId, 'posY', [Linear(0, 500, posY, posY + height * 0.33 / 2)]);
    });
  }

  void zoomOut() {
    double width = animationController.getStateDouble(_layerId, 'width');
    double height = animationController.getStateDouble(_layerId, 'height');
    double posY = animationController.getStateDouble(_layerId, 'posY');
    _animations.add(() {
      animationController
          .animate(_layerId, 'width', [Linear(0, 500, width, width / 1.33)]);
      animationController
          .animate(_layerId, 'height', [Linear(0, 500, height, height / 1.33)]);
      animationController.animate(
          _layerId, 'posY', [Linear(0, 500, posY, posY - height * 0.33 / 2)]);
    });
  }

  void fadeIn() {
    _animations.add(() {
      animationController.animate(_layerId, 'opacity', [Linear(0, 500, 0, 1)]);
    });
  }

  void fadeOut() {
    _animations.add(() {
      animationController.animate(_layerId, 'opacity', [Linear(0, 500, 1, 0)]);
    });
  }

  void grayOut() {
    _animations.add(() {
      animationController
          .animate(_layerId, 'brightness', [Linear(0, 200, 1, 0.5)]);
    });
  }

  void highlight() {
    _animations.add(() {
      animationController
          .animate(_layerId, 'brightness', [Linear(0, 200, 0.5, 1)]);
    });
  }

  void walk() {
    double posY = animationController.getStateDouble(_layerId, 'posY');
    _animations.add(() {
      animationController.animate(
          _layerId, 'posY', [Wave(0, 2000, posY, posY + 0.03, 500, -0.5)]);
    });
  }

  void run() {
    double posY = animationController.getStateDouble(_layerId, 'posY');
    _animations.add(() {
      animationController.animate(
          _layerId, 'posY', [Wave(0, 2000, posY, posY + 0.03, 300, -0.5)]);
    });
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

  void update() async {
    while (_animations.isNotEmpty) {
      await _animations[0]?.call();
      _animations.removeAt(0);
    }
  }
}

class ConversationCharacterLayerProvider
    extends ConversationImageLayerProvider {
  String _characterName = '';
  String _face = 'flat';
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
    String layerId, {
    String imagePath = '',
    double posX = 0,
    double posY = 0,
    double width = 1,
    double height = 1,
    double rotX = 0,
    double rotY = 0,
    double rotZ = 0,
    double opacity = 1,
    double brightness = 1,
  }) : super(layerId,
            imagePath: imagePath,
            posX: posX,
            posY: posY,
            width: width,
            height: height,
            rotX: rotX,
            rotY: rotY,
            rotZ: rotZ,
            opacity: opacity,
            brightness: brightness) {
    _characterName = layerId.toCharacterNames().toStringEn;
    print(layerId);
    print(layerId.toCharacterNames().toStringEn);
    setImagePath(
        'assets/drawable/CharacterImage/$_characterName/$_face-mouth_$_mouth-eye_$_eye.png');
    notifyListeners();
  }
  set isAutoAlign(bool isAutoAlign) {
    _isAutoAlign = isAutoAlign;
  }

  set face(String face) {
    _face = face;
    String imagePath =
        'assets/drawable/CharacterImage/$_characterName/$_face-mouth_$_mouth-eye_$_eye.png';
    setImagePath(imagePath);
  }

  set eye(String eye) {
    _eye = eye;
    String imagePath =
        'assets/drawable/CharacterImage/$_characterName/$_face-mouth_$_mouth-eye_$_eye.png';
    setImagePath(imagePath);
  }

  set mouth(String mouth) {
    _mouth = mouth;
    String imagePath =
        'assets/drawable/CharacterImage/$_characterName/$_face-mouth_$_mouth-eye_$_eye.png';
    setImagePath(imagePath);
  }
}

class ConversationBGLayerProvider extends ConversationImageLayerProvider {
  String BGname = '';
  ConversationBGLayerProvider(
    String layerId, {
    String imagePath = '',
    double posX = 0,
    double posY = 0,
    double width = 1,
    double height = 1,
    double rotX = 0,
    double rotY = 0,
    double rotZ = 0,
    double opacity = 1,
    double brightness = 1,
  }) : super(layerId,
            imagePath: imagePath,
            posX: posX,
            posY: posY,
            width: width,
            height: height,
            rotX: rotX,
            rotY: rotY,
            rotZ: rotZ,
            opacity: opacity,
            brightness: brightness) {
    notifyListeners();
  }
}

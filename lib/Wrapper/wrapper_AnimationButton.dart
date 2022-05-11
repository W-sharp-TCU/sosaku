///package
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

Map<String, AutoDisposeChangeNotifierProvider<AnimationButtonProvider>> _abp =
    {};
AnimationButtonController _abc = AnimationButtonController();

class _DefaultValues {
  static const String id = "buttonDefault";
  static const double? width = 1;
  static const double? height = 1;
  static const double margin = 0;
  static const double marginVertical = 0;
  static const double marginHorizontal = 0;
  static const String? text = null;
  static const TextStyle textStyle = TextStyle(fontSize: 10);
  static const String? image = null;
  static const Color color = Colors.white;
  static const double opacity = 1;
  static const double ratio = 1.1;
  static const int duration = 32;
  static const void Function()? onTap = null;
  static const Widget? child = null;
}

class AnimationButton extends ConsumerWidget {
  String _id = _DefaultValues.id;
  AnimationButton(
      {Key? key,
      required String id,
      double? width = _DefaultValues.width,
      double? height = _DefaultValues.height,
      double? margin = _DefaultValues.margin,
      String? text = _DefaultValues.text,
      TextStyle? textStyle = _DefaultValues.textStyle,
      String? image = _DefaultValues.image,
      Color? color = _DefaultValues.color,
      double? opacity = _DefaultValues.opacity,
      double? ratio = _DefaultValues.ratio,
      int? duration = _DefaultValues.duration,
      void Function()? onTap = _DefaultValues.onTap,
      Widget? child = _DefaultValues.child})
      : super(key: key) {
    _id = id;
    _abc.setControllerState(
        id: id,
        width: width,
        height: height,
        margin: margin,
        text: text,
        textStyle: textStyle,
        image: image,
        color: color,
        opacity: opacity,
        ratio: ratio,
        duration: duration,
        onTap: onTap,
        child: child);
    _abc.updateProvider(_id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    if (!_abp.containsKey(_id)) {
      _abp[_id] = ChangeNotifierProvider.autoDispose(
          (ref) => AnimationButtonProvider(_id));
      _abc.setProvider(_id, ref.watch(_abp[_id]!));
    }

    return SizedBox(
        width: /*_width ?? */ ref.watch(_abp[_id]!).width,
        height: /*_height ?? */ ref.watch(_abp[_id]!).height,
        child: GestureDetector(
          // TODO : Allows for the addition of animation.
          onTapDown: (detail) {
            _abc.startZoomIn(_id);
          },
          onTapUp: (detail) {
            _abc.startZoomOut(_id);
          },
          onTapCancel: () {
            _abc.startZoomOut(_id);
          },
          onTap: () {
            _abc.startZoomInOut(_id);
            ref.watch(_abp[_id]!).onTap?.call();
          },
          child: Container(
              // alignment: Alignment(0, 0),
              margin: EdgeInsets.symmetric(
                  vertical: ref.watch(_abp[_id]!).marginVertical,
                  horizontal: ref.watch(_abp[_id]!).marginHorizontal),
              color: ref
                  .watch(_abp[_id]!)
                  .color
                  .withOpacity(ref.watch(_abp[_id]!).opacity),
              child: Stack(
                children: [
                  /// Image
                  if (ref.watch(_abp[_id]!).image != null)
                    Center(
                        child: Image(
                            fit: BoxFit.fitHeight,
                            image: AssetImage(
                              ref.watch(_abp[_id]!).image!,
                            ))),

                  /// Text
                  if (ref.watch(_abp[_id]!).text != null)
                    Center(
                        child: Text(
                      ref.watch(_abp[_id]!).text!,
                      style: ref.watch(_abp[_id]!).textStyle,
                    )),

                  /// Child
                  if (ref.watch(_abp[_id]!).child != null)
                    Center(
                      child: ref.watch(_abp[_id]!).child,
                    )
                ],
              )),
        ));
  }
}

class AnimationButtonProvider extends ChangeNotifier {
  String _id = _DefaultValues.id;
  double _width = _DefaultValues.width ?? 1;
  double _height = _DefaultValues.height ?? 1;
  double _marginVertical = _DefaultValues.marginVertical;
  double _marginHorizontal = _DefaultValues.marginHorizontal;
  String? _text = _DefaultValues.text;
  TextStyle _textStyle = _DefaultValues.textStyle;
  String? _image = _DefaultValues.image;
  Color _color = _DefaultValues.color;
  double _opacity = _DefaultValues.opacity;
  void Function()? _onTap = _DefaultValues.onTap;
  Widget? _child = _DefaultValues.child;

  double get width => _width;
  double get height => _height;
  double get marginVertical => _marginVertical;
  double get marginHorizontal => _marginHorizontal;
  String? get text => _text;
  TextStyle? get textStyle => _textStyle;
  String? get image => _image;
  Color get color => _color;
  double get opacity => _opacity;
  void Function()? get onTap => _onTap;
  Widget? get child => _child;

  AnimationButtonProvider(String id) {
    _id = id;
  }

  void changeNotification() {
    notifyListeners();
  }

  void setWidth(double? width) {
    _width = width ?? _width;
  }

  void setHeight(double? height) {
    _height = height ?? _height;
  }

  void setMarginVertical(double? marginVertical) {
    _marginVertical = (marginVertical ?? _marginVertical) /*.ceilToDouble()*/;
    if (_marginVertical.isNegative) {
      _marginVertical = 0;
    }
  }

  void setMarginHorizontal(double? marginHorizontal) {
    _marginHorizontal =
        (marginHorizontal ?? _marginHorizontal) /*.ceilToDouble()*/;
    if (_marginHorizontal.isNegative) {
      _marginHorizontal = 0;
    }
  }

  void setText(String? text) {
    _text = text ?? _text;
  }

  void setTextStyle(TextStyle? textStyle) {
    _textStyle = (TextStyle(
        fontSize: (textStyle ?? _textStyle).fontSize! /*.ceilToDouble()*/));
  }

  void setImage(String? image) {
    _image = image ?? _image;
  }

  void setColor(Color? color) {
    _color = color ?? _color;
  }

  void setOpacity(double? opacity) {
    _opacity = opacity ?? _opacity;
  }

  void setOnTap(void Function()? onTap) {
    _onTap = onTap ?? _onTap;
  }

  void setChild(Widget? child) {
    _child = child ?? _child;
  }

  @override
  void dispose() {
    _abc.providerDispose(_id);
    _abp.remove(_id);
    super.dispose();
  }
}

class AnimationButtonController {
  static const int _animationInterval = 16;
  final Map<String, bool> _isAnimation = {};
  final Map<String, AnimationButtonProvider> _providers = {};
  final Map<String, double?> _widths = {};
  final Map<String, double?> _heights = {};
  final Map<String, double?> _margins = {};
  final Map<String, String?> _texts = {};
  final Map<String, TextStyle?> _textStyles = {};
  final Map<String, String?> _images = {};
  final Map<String, Color?> _colors = {};
  final Map<String, double?> _opacities = {};
  final Map<String, double?> _ratios = {};
  final Map<String, int?> _durations = {};
  final Map<String, void Function()?> _onTaps = {};
  final Map<String, Widget?> _children = {};

  final Map<String, double> _nowMarginRatios = {};
  final Map<String, void Function(String)?> _nowAnimations = {};

  void _startAnimation(String id) {
    /// TODO : For debug.
    Stopwatch s = Stopwatch();
    void _animationDraw(Timer? timer) {
      if (_isAnimation[id] == false) {
        /// TODO : For debug.
        s.stop();
        print('Animation run time : ${s.elapsedMilliseconds.toString()}');
        s.reset();
        timer?.cancel();
      } else {
        _nowAnimations[id]?.call(id);
      }
    }

    if (_isAnimation[id] == false) {
      _isAnimation[id] = true;
      _animationDraw(null);
      Timer.periodic(
          const Duration(milliseconds: _animationInterval), _animationDraw);

      /// TODO : For Debug
      s.start();
    }
  }

  void setControllerState(
      {required String id,
      required double? width,
      required double? height,
      required double? margin,
      required String? text,
      required TextStyle? textStyle,
      required String? image,
      required Color? color,
      required double? opacity,
      required double? ratio,
      required int? duration,
      required void Function()? onTap,
      required Widget? child}) {
    _isAnimation[id] ??= false;
    _nowAnimations[id] ??= null;
    _widths[id] = width;
    _heights[id] = height;
    _margins[id] = margin;
    _texts[id] = text;
    _textStyles[id] = textStyle;
    _images[id] = image;
    _colors[id] = color;
    _opacities[id] = opacity;
    _ratios[id] = ratio;
    _durations[id] = duration;
    _onTaps[id] = onTap;
    _children[id] = child;

    if (_isAnimation[id]! == false) {
      _nowMarginRatios[id] = (_ratios[id]! - 1) / (2 * _ratios[id]!);
    }
  }

  void setProvider(
    String id,
    AnimationButtonProvider provider,
  ) {
    _providers[id] = provider;
    updateProvider(id);
  }

  void updateProvider(String id) async {
    // TODO : Change from delay to build callbacks.
    await Future.delayed(const Duration(microseconds: _animationInterval));
    _providers[id]?.setWidth(_widths[id]);
    _providers[id]?.setHeight(_heights[id]);
    _providers[id]?.setMarginVertical(_margins[id]! +
        (_heights[id]! - _margins[id]! * 2) * _nowMarginRatios[id]!);
    _providers[id]?.setMarginHorizontal(_margins[id]! +
        (_widths[id]! - _margins[id]! * 2) * _nowMarginRatios[id]!);
    _providers[id]?.setText(_texts[id]);
    _providers[id]?.setTextStyle(TextStyle(
        fontSize:
            _textStyles[id]!.fontSize! * (1 - 2 * _nowMarginRatios[id]!)));
    _providers[id]?.setImage(_images[id]);
    _providers[id]?.setColor(_colors[id]);
    _providers[id]?.setOpacity(_opacities[id]);
    _providers[id]?.setOnTap(_onTaps[id]);
    _providers[id]?.setChild(_children[id]);
    _providers[id]?.changeNotification();
  }

  void startZoomIn(String id) {
    _nowAnimations[id] = _zoomIn;
    _startAnimation(id);
  }

  void startZoomOut(String id) {
    _nowAnimations[id] = _zoomOut;
    _startAnimation(id);
  }

  void startZoomInOut(String id) {
    _nowAnimations[id] = _zoomInOut;
    _startAnimation(id);
  }

  void _zoomIn(String id) {
    if (_nowMarginRatios[id]! > 0 && _durations[id]! > 0) {
      _nowMarginRatios[id] = _nowMarginRatios[id]! -
          ((_ratios[id]! - 1) / (2 * _ratios[id]!)) /
              (_durations[id]! / _animationInterval).ceil();
      _providers[id]?.setMarginVertical(_margins[id]! +
          (_heights[id]! - _margins[id]! * 2) * _nowMarginRatios[id]!);
      _providers[id]?.setMarginHorizontal(_margins[id]! +
          (_widths[id]! - _margins[id]! * 2) * _nowMarginRatios[id]!);
      _providers[id]?.setTextStyle(TextStyle(
          fontSize:
              _textStyles[id]!.fontSize! * (1 - 2 * _nowMarginRatios[id]!)));

      _providers[id]?.changeNotification();
    }
  }

  void _zoomOut(String id) {
    if (_nowMarginRatios[id]! < (_ratios[id]! - 1) / (2 * _ratios[id]!) &&
        _durations[id]! > 0) {
      _nowMarginRatios[id] = _nowMarginRatios[id]! +
          ((_ratios[id]! - 1) / (2 * _ratios[id]!)) /
              (_durations[id]! / _animationInterval).ceil();
      _providers[id]?.setMarginVertical(_margins[id]! +
          (_heights[id]! - _margins[id]! * 2) * _nowMarginRatios[id]!);
      _providers[id]?.setMarginHorizontal(_margins[id]! +
          (_widths[id]! - _margins[id]! * 2) * _nowMarginRatios[id]!);
      _providers[id]?.setTextStyle(TextStyle(
          fontSize:
              _textStyles[id]!.fontSize! * (1 - 2 * _nowMarginRatios[id]!)));
      _providers[id]?.changeNotification();
    }
    if (!(_nowMarginRatios[id]! < (_ratios[id]! - 1) / (2 * _ratios[id]!) &&
        _durations[id]! > 0)) {
      _isAnimation[id] = false;
    }
  }

  void _zoomInOut(String id) {
    if (_nowMarginRatios[id]! > 0 && _durations[id]! > 0) {
      _nowMarginRatios[id] = _nowMarginRatios[id]! -
          ((_ratios[id]! - 1) / (2 * _ratios[id]!)) /
              (_durations[id]! / _animationInterval).ceil();
      _providers[id]?.setMarginVertical(_margins[id]! +
          (_heights[id]! - _margins[id]! * 2) * _nowMarginRatios[id]!);
      _providers[id]?.setMarginHorizontal(_margins[id]! +
          (_widths[id]! - _margins[id]! * 2) * _nowMarginRatios[id]!);
      _providers[id]?.setTextStyle(TextStyle(
          fontSize:
              _textStyles[id]!.fontSize! * (1 - 2 * _nowMarginRatios[id]!)));
      _providers[id]?.changeNotification();
    }
    if (!(_nowMarginRatios[id]! > 0 && _durations[id]! > 0)) {
      _nowAnimations[id] = _zoomOut;
    }
  }

  void providerDispose(String id) {
    _providers.remove(id);
    _isAnimation[id] = false;
  }
}

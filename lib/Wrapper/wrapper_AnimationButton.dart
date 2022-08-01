///package
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

Map<String, AutoDisposeChangeNotifierProvider<AnimationButtonProvider>> _abp =
    {};
Map<String, AnimationButtonProvider> _providers = {};
AnimationButtonController abc = AnimationButtonController();

class _DefaultValues {
  static const String id = "buttonDefault";
  static const double width = 1;
  static const double height = 1;
  static const double margin = 0;
  static const double marginLeft = 0;
  static const double marginTop = 0;
  static const double marginRight = 0;
  static const double marginBottom = 0;
  static const String? text = null;
  static const TextStyle textStyle = TextStyle(fontSize: 10);
  static const String? image = null;
  static const Color color = Colors.white;
  static const double opacity = 1;
  static const double ratio = 1.1;
  static const int duration = 64;
  static const void Function()? onTap = null;
  static const void Function()? onTapDown = null;
  static const void Function()? onTapUp = null;
  static const void Function()? onTapCancel = null;
  static const Widget? child = null;
}

class AnimationButton extends ConsumerWidget {
  late final String _id;
  AnimationButton(
      {Key? key,
      required String id,
      double width = _DefaultValues.width,
      double height = _DefaultValues.height,
      double marginLeft = _DefaultValues.marginLeft,
      double marginTop = _DefaultValues.marginTop,
      double marginRight = _DefaultValues.marginRight,
      double marginBottom = _DefaultValues.marginBottom,
      String? text = _DefaultValues.text,
      TextStyle textStyle = _DefaultValues.textStyle,
      String? image = _DefaultValues.image,
      Color color = _DefaultValues.color,
      double opacity = _DefaultValues.opacity,
      void Function()? onTap = _DefaultValues.onTap,
      void Function()? onTapDown = _DefaultValues.onTapDown,
      void Function()? onTapUp = _DefaultValues.onTapUp,
      void Function()? onTapCancel = _DefaultValues.onTapCancel,
      Widget? child = _DefaultValues.child})
      : super(key: key) {
    print(key);
    _id = id;
    if (!_abp.containsKey(_id)) {
      _providers[_id] = AnimationButtonProvider(_id);
      _abp[_id] = ChangeNotifierProvider.autoDispose((ref) => _providers[_id]!);
    }

    /// Save arguments to provider.
    _providers[_id]?.setStateDouble('width', width);
    _providers[_id]?.setStateDouble('height', height);
    _providers[_id]?.setStateDouble('marginLeft', marginLeft);
    _providers[_id]?.setStateDouble('marginTop', marginTop);
    _providers[_id]?.setStateDouble('marginRight', marginRight);
    _providers[_id]?.setStateDouble('marginBottom', marginBottom);
    _providers[_id]?.setStateDouble('opacity', opacity);
    _providers[_id]?.setText(text);
    _providers[_id]?.setTextStyle(textStyle);
    _providers[_id]?.setImage(image);
    _providers[_id]?.setColor(color);
    _providers[_id]?.setOnTap(onTap);
    _providers[_id]?.setOnTapDown(onTapDown);
    _providers[_id]?.setOnTapUp(onTapUp);
    _providers[_id]?.setOnTapCancel(onTapCancel);
    _providers[_id]?.setChild(child);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return SizedBox(
        width: ref.watch(_abp[_id]!).stateDouble['width'],
        height: ref.watch(_abp[_id]!).stateDouble['height'],
        child: GestureDetector(
          onTap: () {
            // If onTap is null, animate zoomInOut.
            ref.watch(_abp[_id]!).onTap?.call();
          },
          onTapDown: (detail) {
            // If onTapDown is null, animate zoomIn.
            ref.watch(_abp[_id]!).onTapDown?.call();
          },
          onTapUp: (detail) {
            // If onTapUp is null, animate zoomOut.
            ref.watch(_abp[_id]!).onTapUp?.call();
          },
          onTapCancel: () {
            // If onTapCancel is null, animate zoomOut.
            ref.watch(_abp[_id]!).onTapCancel?.call();
          },
          child: Container(
              // alignment: Alignment(0, 0),
              margin: EdgeInsets.only(
                  left: ref.watch(_abp[_id]!).stateDouble['marginLeft']!,
                  top: ref.watch(_abp[_id]!).stateDouble['marginTop']!,
                  right: ref.watch(_abp[_id]!).stateDouble['marginRight']!,
                  bottom: ref.watch(_abp[_id]!).stateDouble['marginBottom']!),
              color: ref
                  .watch(_abp[_id]!)
                  .color
                  .withOpacity(ref.watch(_abp[_id]!).stateDouble['opacity']!),
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
  late String _id;
  String? _text = _DefaultValues.text;
  TextStyle _textStyle = _DefaultValues.textStyle;
  String? _image = _DefaultValues.image;
  Color _color = _DefaultValues.color;
  void Function()? _onTap = _DefaultValues.onTap;
  void Function()? _onTapDown = _DefaultValues.onTapDown;
  void Function()? _onTapUp = _DefaultValues.onTapUp;
  void Function()? _onTapCancel = _DefaultValues.onTapCancel;
  Widget? _child = _DefaultValues.child;

  /// Double type value to be animated.
  ///
  /// width, height, marginLeft, marginTop, marginRight, marginBottom, opacity...
  Map<String, double> _stateDouble = {
    'width': _DefaultValues.width,
    'height': _DefaultValues.height,
    'marginLeft': _DefaultValues.marginLeft,
    'marginTop': _DefaultValues.marginTop,
    'marginRight': _DefaultValues.marginRight,
    'marginBottom': _DefaultValues.marginBottom,
    'opacity': _DefaultValues.opacity,
  };
  Map<String, bool> _nowStateAnimation = {
    'width': false,
    'height': false,
    'marginLeft': false,
    'marginTop': false,
    'marginRight': false,
    'marginBottom': false,
    'opacity': false,
  };

  Map<String, double> get stateDouble => _stateDouble;
  String? get text => _text;
  TextStyle? get textStyle => _textStyle;
  String? get image => _image;
  Color get color => _color;
  void Function()? get onTap => _onTap;
  void Function()? get onTapDown => _onTapDown;
  void Function()? get onTapUp => _onTapUp;
  void Function()? get onTapCancel => _onTapCancel;
  Widget? get child => _child;

  AnimationButtonProvider(String id) {
    _id = id;
  }

  void changeNotification() {
    notifyListeners();
  }

  void setStateDouble(String key, double? value) {
    if (value != null) {
      _stateDouble[key] = value;
    } else {
      throw FormatException('State value can not be null');
    }
  }

  void setText(String? text) {
    _text = text ?? _text;
  }

  void setTextStyle(TextStyle? textStyle) {
    _textStyle = (TextStyle(
        fontSize: (textStyle ?? _textStyle).fontSize!.ceilToDouble()));
  }

  void setImage(String? image) {
    _image = image ?? _image;
  }

  void setColor(Color? color) {
    _color = color ?? _color;
  }

  void setOnTap(void Function()? onTap) {
    _onTap = onTap ?? _onTap;
  }

  void setOnTapDown(void Function()? onTapDown) {
    _onTapDown = onTapDown ?? _onTapDown;
  }

  void setOnTapUp(void Function()? onTapUp) {
    _onTapUp = onTapUp ?? _onTapUp;
  }

  void setOnTapCancel(void Function()? onTapCancel) {
    _onTapCancel = onTapCancel ?? _onTapCancel;
  }

  void setChild(Widget? child) {
    _child = child ?? _child;
  }

  @override
  void dispose() {
    abc.providerDispose(_id);
    _abp.remove(_id);
    super.dispose();
  }
}

class AnimationButtonController {
  static const int _animationInterval = 16;
  final Map<String, bool> _isAnimation = {};
  final Map<String, AnimationButtonProvider> _providers = {};
  final Map<String, double> _nowMarginRatios = {};
  final Map<String, void Function(String)?> _nowAnimations = {};

  Future<void> animation(
      {required String id,
      required String state,
      required double begin,
      required double end,
      required int duration}) async {
    if (_providers.containsKey(id) &&
        _providers[id]!.stateDouble.containsKey(state)) {}
  }

  void providerDispose(String id) {
    _providers.remove(id);
    _isAnimation[id] = false;
  }
}

// abstract class Animation {
//   int _timeBegin;
//   int _timeEnd;
//
//   int get timeBegin => _timeBegin;
//   int get timeEnd => _timeEnd;
//
//   Animation(this._timeBegin, this._timeEnd);
//   double? getValue(int time) {
//     if (_timeBegin <= time && time < _timeEnd) {
//       return func(time);
//     } else {
//       return null;
//     }
//   }
//
//   double func(int time);
// }
//
// class Linear extends Animation {
//   double _begin;
//   double _end;
//
//   Linear(int _timeBegin, int _timeEnd, this._begin, this._end)
//       : super(_timeBegin, _timeEnd);
//
//   double func(int time) {
//     return _begin +
//         (_end - _begin) * ((time - _timeBegin) / (_timeEnd - _timeBegin));
//   }
// }
//
// class Wave extends Animation {
//   double a;
//   double t;
//
//   Wave(int _timeBegin, int _timeEnd, this.a, this.t)
//       : super(_timeBegin, _timeEnd);
//
//   double func(int time) {
//     return a * sin((t / 500) * pi * time);
//   }
// }

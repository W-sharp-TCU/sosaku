///package

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

class _AnimationButtonId {
  static int _i = 0;
  static getId() {
    String id = 'AnimationButton' + _i.toString();
    _i++;
    return id;
  }
}

class AnimationButton extends ConsumerWidget {
  late double _width;
  late double _height;
  EdgeInsets? _margin;
  late int _duration;
  late double _ratio;
  Color? _color;
  Function? _onTap;
  Widget? _child;

  AnimationButton(
      {Key? key,
      double width = 0,
      double height = 0,
      EdgeInsets? margin,
      int duration = 150,
      double ratio = 1.1,
      Color? color,
      Function? onTap,
      Widget? child})
      : super(key: key ?? UniqueKey()) {
    _width = width;
    _height = height;
    _margin = margin;
    _duration = duration;
    _ratio = ratio;
    _color = color;
    _onTap = onTap;
    _child = child;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    final animationProvider =
        animationController.createProvider(key.toString(), {'margin': 1});

    return Container(
        margin: _margin,
        child: SizedBox(
            width: _width,
            height: _height,
            child: GestureDetector(
                onTap: () {
                  double m =
                      ref.watch(animationProvider).stateDouble['margin']!;
                  int d = (m * _duration / 3).round();

                  animationController.animate(key.toString(), 'margin', [
                    Linear(0, d, m, 0),
                    Easing(d, d + _duration, 0, 1).outElastic()
                  ]);
                  animationController.setCallback(key.toString(), {
                    'margin': () {
                      _onTap?.call();
                    }
                  });
                },
                onTapDown: (detail) {
                  double m =
                      ref.watch(animationProvider).stateDouble['margin']!;
                  int d = (m * _duration / 3).round();
                  animationController.animate(key.toString(), 'margin', [
                    Linear(0, d, m, 0),
                  ]);
                  print(m);
                },
                onTapUp: (detail) {},
                onTapCancel: () {
                  print('cancel');
                  double m =
                      ref.watch(animationProvider).stateDouble['margin']!;
                  int d = (m * _duration).round();
                  animationController.animate(key.toString(), 'margin', [
                    Easing(0, _duration - d, m, 1).outElastic(),
                  ]);
                },
                child: Container(
                    // decoration: const BoxDecoration(
                    //   image: DecorationImage(
                    //     fit: BoxFit.fill,
                    //     image: AssetImage(
                    //         'assets/drawable/Conversation/button_sample.png'),
                    //   ),
                    // ),
                    margin: EdgeInsets.symmetric(
                      horizontal:
                          (ref.watch(animationProvider).stateDouble['margin']! *
                                  _width *
                                  (_ratio - 1) /
                                  2)
                              .abs(),
                      vertical:
                          (ref.watch(animationProvider).stateDouble['margin']! *
                                  _height *
                                  (_ratio - 1) /
                                  2)
                              .abs(),
                    ),
                    color: _color,
                    child: _child))));
  }
}

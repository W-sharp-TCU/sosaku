///package

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

final tapEffectScreenProvider =
    ChangeNotifierProvider.autoDispose((ref) => TapEffectScreenProvider());

class TapEffectScreen extends ConsumerWidget {
  Widget? _child;

  TapEffectScreen({Key? key, Widget? child}) : super(key: key ?? UniqueKey()) {
    _child = child;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    return GestureDetector(
        onTapDown: (detail) {
          print(detail.localPosition);
          for (int i = 0; i < 10; i++) {
            ref.read(tapEffectScreenProvider).create(
                (detail.localPosition.dx / GetScreenSize.screenWidth() * 2) - 1,
                (detail.localPosition.dy / GetScreenSize.screenHeight() * 2) -
                    1);
          }
        },
        child: Stack(children: [
          Container(
            child: _child,
          ),
          if (ref.watch(tapEffectScreenProvider)._isAnimation)
            for (AutoDisposeChangeNotifierProvider<
                    AnimationProvider> sakuraProvider
                in ref.watch(tapEffectScreenProvider)._sakuraProviders.values)
              Align(
                alignment: Alignment(
                  ref.watch(sakuraProvider).stateDouble['dx']! +
                      0.05 *
                          cos(ref.watch(sakuraProvider).stateDouble['theta']!) *
                          ref.watch(sakuraProvider).stateDouble['r']!,
                  ref.watch(sakuraProvider).stateDouble['dy']! +
                      (0.05 * 16 / 9) *
                          sin(ref.watch(sakuraProvider).stateDouble['theta']!) *
                          ref.watch(sakuraProvider).stateDouble['r']!,
                ),
                child: SizedBox(
                  width: ref.watch(sakuraProvider).stateDouble['ratio']! *
                      GetScreenSize.screenWidth() *
                      0.015,
                  height: ref.watch(sakuraProvider).stateDouble['ratio']! *
                      GetScreenSize.screenWidth() *
                      0.015,
                  child: Center(
                      child: Opacity(
                          opacity:
                              ref.watch(sakuraProvider).stateDouble['opacity']!,
                          child: Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0)
                              ..rotateX(
                                  ref.watch(sakuraProvider).stateDouble['rx']!)
                              ..rotateY(
                                  ref.watch(sakuraProvider).stateDouble['ry']!)
                              ..rotateZ(
                                  ref.watch(sakuraProvider).stateDouble['rz']!),
                            child: const Image(
                              image: AssetImage(
                                  'assets/drawable/Conversation/sakura.png'),
                            ),
                          ))),
                ),
              ),
        ]));
  }
}

class TapEffectScreenProvider extends ChangeNotifier {
  static const int _duration = 1000;
  bool _isAnimation = false;
  int _i = 0;
  List<double> _offset = [0, 0];
  final Map<String, AutoDisposeChangeNotifierProvider<AnimationProvider>>
      _sakuraProviders = {};
  List<double> get offset => _offset;
  void setOffset(List<double> offset) {
    _offset = offset;
    notifyListeners();
  }

  void create(double dx, double dy) {
    _isAnimation = true;
    String id = 'sakura$_i';
    final rand = Random();
    _sakuraProviders[id] = animationController.createProvider(id, {
      'dx': dx,
      'dy': dy,
      'theta': rand.nextDouble() * 2 * pi,
      'r': 0.3,
      'rx': rand.nextDouble() * 2 * pi,
      'ry': rand.nextDouble() * 2 * pi,
      'rz': rand.nextDouble() * 2 * pi,
      'ratio': rand.nextDouble() * 0.5 + 1,
      'opacity': 1,
    });
    notifyListeners();
    animationController.animate(id, 'opacity', [Linear(0, _duration, 1, 0)]);
    animationController
        .animate(id, 'r', [Easing(0, _duration, 0.3, 2).outQuint()]);
    animationController.setCallback(id, {
      'opacity': () {
        _sakuraProviders.remove(id);
        if (_sakuraProviders == {}) {
          _isAnimation = false;
          notifyListeners();
        }
      }
    });
    _i++;
  }
}

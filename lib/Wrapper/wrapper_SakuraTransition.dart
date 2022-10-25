///package

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosaku/Wrapper/wrapper_AnimationWidget.dart';

///other dart files
import '../Wrapper/wrapper_GetScreenSize.dart';

final sakuraTransitionProvider =
    ChangeNotifierProvider.autoDispose((ref) => SakuraTransitionProvider());

class SakuraTransition extends ConsumerWidget {
  Widget? _child;

  SakuraTransition({Key? key, Widget? child}) : super(key: key ?? UniqueKey()) {
    _child = child;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetScreenSize.setSize(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    final sakuraTransitionBG = animationController.createProvider(
        'sakuraTransitionBG', {'dy': -1, 'opacity': 0, 'white': 0});
    return Stack(children: [
      /// child
      Container(
        child: _child,
      ),

      /// background
      if (SakuraTransitionProvider._isTransition)
        Positioned(
            top: GetScreenSize.screenHeight() *
                ref.watch(sakuraTransitionBG).stateDouble['dy']!,
            child: Opacity(
              opacity: ref.watch(sakuraTransitionBG).stateDouble['opacity']!,
              child: const Image(
                image: AssetImage('assets/drawable/Conversation/sky.png'),
              ),
            )),

      /// white filter
      if (SakuraTransitionProvider._isTransition)
        Container(
          color: Colors.white
              .withOpacity(ref.watch(sakuraTransitionBG).stateDouble['white']!),
        ),

      /// sakura
      for (AutoDisposeChangeNotifierProvider<AnimationProvider> sakuraProvider
          in ref.watch(sakuraTransitionProvider)._sakuraProviders)
        Align(
          alignment: Alignment(
              ref.watch(sakuraProvider).stateDouble['dx']! +
                  ref.watch(sakuraProvider).stateDouble['delta']!,
              ref.watch(sakuraProvider).stateDouble['dy']! +
                  ref.watch(sakuraProvider).stateDouble['delta']!),
          child: SizedBox(
            width: ref.watch(sakuraProvider).stateDouble['ratio']! *
                GetScreenSize.screenWidth() *
                0.015,
            height: ref.watch(sakuraProvider).stateDouble['ratio']! *
                GetScreenSize.screenWidth() *
                0.015,
            child: Center(
                child: Opacity(
                    opacity: ref.watch(sakuraProvider).stateDouble['opacity']!,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0)
                        ..rotateX(ref.watch(sakuraProvider).stateDouble['rx']!)
                        ..rotateY(ref.watch(sakuraProvider).stateDouble['ry']!)
                        ..rotateZ(ref.watch(sakuraProvider).stateDouble['rz']!),
                      child: const Image(
                        image: AssetImage(
                            'assets/drawable/Conversation/sakura.png'),
                      ),
                    ))),
          ),
        ),
    ]);
  }
}

class SakuraTransitionProvider extends ChangeNotifier {
  static const int _max = 30;
  static const int _duration = 2000;
  final List<AutoDisposeChangeNotifierProvider<AnimationProvider>>
      _sakuraProviders = [];
  static bool _isTransition = false;
  SakuraTransitionProvider() {
    for (int i = 0; i < _max; i++) {
      _sakuraProviders
          .add(animationController.createProvider('sakuraTransition$i', {
        'dx': 0,
        'dy': 0,
        'delta': 0,
        'rx': 0,
        'ry': 0,
        'rz': 0,
        'ratio': 0,
        'opacity': 0,
      }));
    }
  }

  static Future<void> beginTransition() async {
    _isTransition = true;
    for (int i = 0; i < _max; i++) {
      String id = 'sakuraTransition$i';
      final rand = Random();
      animationController.setStates(id, {
        'dx': rand.nextDouble() * 2 + 0.5,
        'dy': rand.nextDouble() * 2 + 0.5,
        'delta': 0,
        'rx': rand.nextDouble() * 2 * pi,
        'ry': rand.nextDouble() * 2 * pi,
        'rz': rand.nextDouble() * 2 * pi,
        'ratio': rand.nextDouble() * 5 + 2,
        'opacity': 1,
      });
      animationController.animate(id, 'delta', [Linear(0, _duration, 0, -3)]);
      animationController
          .animate(id, 'opacity', [Easing(0, _duration, 1, 0).inQuint()]);
      animationController.animate(id, 'rx', [
        Linear(0, _duration, rand.nextDouble() * 2 * pi,
            rand.nextDouble() * 4 * pi)
      ]);
      animationController.animate(id, 'ry', [
        Linear(0, _duration, rand.nextDouble() * 2 * pi,
            rand.nextDouble() * 4 * pi)
      ]);
      animationController.animate(id, 'rz', [
        Linear(0, _duration, rand.nextDouble() * 2 * pi,
            rand.nextDouble() * 4 * pi)
      ]);
    }
    animationController.animate('sakuraTransitionBG', 'dy', [
      Easing(0, (_duration * 2 / 3).ceil(), -2, 0).outQuint(),
    ]);
    animationController.animate('sakuraTransitionBG', 'opacity', [
      Linear(0, (_duration / 4).ceil(), 0, 1),
      Linear(_duration, _duration + (_duration / 4).ceil(), 1, 0),
    ]);
    animationController.animate('sakuraTransitionBG', 'white', [
      Linear((_duration / 2).ceil(), _duration, 0, 1),
    ]);
    await Future.delayed(const Duration(milliseconds: _duration));
  }

  static Future<void> endTransition() async {
    await animationController.animate('sakuraTransitionBG', 'white', [
      Easing(0, (_duration / 2).ceil(), 1, 0).inQuint(),
    ]);
    _isTransition = false;
  }
}

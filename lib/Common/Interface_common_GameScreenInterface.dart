import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sosaku/Common/Manager_common_ResourceManager.dart';

@Deprecated("This method will be replaced to GameScreen class.")
abstract class GameScreenInterface {
  /// Must be called before the screen of class implements this function appear.
  /// Implement precache function and special initialization function if necessary.
  /// This function must be a async function.
  Future<void> prepare(BuildContext context);
}

/// Base class of each screen
///
/// The class that extends this class must be implemented build function.
/// When you implement build function, you should put Scaffold & GameScreen widget
/// on the bottom of the widget tree.
abstract class GameScreen extends HookConsumerWidget {
  GameScreen({Key? key, this.opaque = false}) : super(key: key);

  /// opaque flag
  final bool opaque;

  /// file path to drawable assets
  final List<String> drawableAssets = [];

  /// file path to user interface audio assets
  final List<String> uiAssets = [];

  /// file path to background music assets
  final List<String> bgmAssets = [];

  /// file path to sound effect assets
  final List<String> seAssets = [];

  /// file path to character's voice audio assets
  final List<String> cvAssets = [];

  /// Method for loading and initializing something in advance.
  ///
  /// Must be called before the screen of class implements this function appear.
  /// Implement precache function and special initialization function if necessary.
  /// This function must be a async function.
  Future<void> prepare(BuildContext context) async {
    ResourceManager().addAll(context,
        drawable: drawableAssets,
        ui: uiAssets,
        bgm: bgmAssets,
        se: seAssets,
        cv: cvAssets);
  }

  Color color(Color color) => opaque ? color.withOpacity(1) : color;
}

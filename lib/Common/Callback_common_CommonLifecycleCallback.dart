import 'package:sosaku/Wrapper/Controller_wrapper_LifecycleManager.dart';
import '../Wrapper/wrapper_SoundPlayer.dart';

/// Processes used in all screens called when the app's lifecycle is changed.
class CommonLifecycleCallback extends LifecycleCallback {
  const CommonLifecycleCallback();

  /// Called when the app is put in background and terminated.
  @override
  void onPaused() {
    SoundPlayer().pauseALL();
  }

  /// Called when the app is put in foreground from background.
  @override
  void onResumed() {
    SoundPlayer().resumeALL();
  }

  /// Called when the app is not controllable.
  /// ex) Time when user receive telephone calls.
  /// ex) Time when user open notification center or control center.
  @override
  void onInactive() {
    /* do nothing. */
  }

  /// Called when the app is terminated.
  @override
  void onDetached() {
    SoundPlayer().stopALL();
  }
}

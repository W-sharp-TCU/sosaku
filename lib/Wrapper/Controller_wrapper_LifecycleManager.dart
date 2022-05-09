import 'package:flutter/widgets.dart';

/// StatefulWidget witch manage app lifecycle
/// === Usage ===
/// Widget build(BuildContext context) {
///   return LifecycleManager(
///     callback: _screenState(),  // Create new class implements LifecycleCallback.
///     child: Container(
///       .....
/// }
/// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// class _screenState() implements LifecycleCallback {
///   << Override functions >>
/// }
/// =============
class LifecycleManager extends StatefulWidget {
  final Widget child;
  final LifecycleCallback callback;

  const LifecycleManager(
      {Key? key, required this.child, required this.callback})
      : super(key: key);

  @override
  _LifecycleManagerState createState() => _LifecycleManagerState();
}

class _LifecycleManagerState extends State<LifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');
    switch (state) {
      case AppLifecycleState.resumed:
        widget.callback?.onResumed();
        break;
      case AppLifecycleState.inactive:
        widget.callback?.onInactive();
        break;
      case AppLifecycleState.paused:
        widget.callback?.onPaused();
        break;
      case AppLifecycleState.detached:
        widget.callback?.onDetached();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}

/// callback interface
abstract class LifecycleCallback {
  void onResumed() {}

  void onPaused() {}

  void onInactive() {}

  void onDetached() {}
}

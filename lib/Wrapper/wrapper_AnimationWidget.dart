import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class AnimationWidget extends StatelessWidget {
  AnimationWidget({
    Key? key,
    this.child,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onDoubleTapDown,
    this.onDoubleTap,
    this.onDoubleTapCancel,
    this.onLongPressDown,
    this.onLongPressCancel,
    this.onLongPress,
    this.onLongPressStart,
    this.onLongPressMoveUpdate,
    this.onLongPressUp,
    this.onLongPressEnd,
    this.onSecondaryLongPressDown,
    this.onSecondaryLongPressCancel,
    this.onSecondaryLongPress,
    this.onSecondaryLongPressStart,
    this.onSecondaryLongPressMoveUpdate,
    this.onSecondaryLongPressUp,
    this.onSecondaryLongPressEnd,
    this.onTertiaryLongPressDown,
    this.onTertiaryLongPressCancel,
    this.onTertiaryLongPress,
    this.onTertiaryLongPressStart,
    this.onTertiaryLongPressMoveUpdate,
    this.onTertiaryLongPressUp,
    this.onTertiaryLongPressEnd,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onVerticalDragCancel,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onForcePressStart,
    this.onForcePressPeak,
    this.onForcePressUpdate,
    this.onForcePressEnd,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.onPanCancel,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.behavior,
    this.excludeFromSemantics = false,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(excludeFromSemantics != null),
        assert(dragStartBehavior != null),
        assert(() {
          final bool haveVerticalDrag = onVerticalDragStart != null ||
              onVerticalDragUpdate != null ||
              onVerticalDragEnd != null;
          final bool haveHorizontalDrag = onHorizontalDragStart != null ||
              onHorizontalDragUpdate != null ||
              onHorizontalDragEnd != null;
          final bool havePan =
              onPanStart != null || onPanUpdate != null || onPanEnd != null;
          final bool haveScale = onScaleStart != null ||
              onScaleUpdate != null ||
              onScaleEnd != null;
          if (havePan || haveScale) {
            if (havePan && haveScale) {
              throw FlutterError.fromParts(<DiagnosticsNode>[
                ErrorSummary('Incorrect GestureDetector arguments.'),
                ErrorDescription(
                  'Having both a pan gesture recognizer and a scale gesture recognizer is redundant; scale is a superset of pan.',
                ),
                ErrorHint('Just use the scale gesture recognizer.'),
              ]);
            }
            final String recognizer = havePan ? 'pan' : 'scale';
            if (haveVerticalDrag && haveHorizontalDrag) {
              throw FlutterError(
                'Incorrect GestureDetector arguments.\n'
                'Simultaneously having a vertical drag gesture recognizer, a horizontal drag gesture recognizer, and a $recognizer gesture recognizer '
                'will result in the $recognizer gesture recognizer being ignored, since the other two will catch all drags.',
              );
            }
          }
          return true;
        }()),
        super(key: key);
  final Widget? child;

  final GestureTapDownCallback? onTapDown;

  final GestureTapUpCallback? onTapUp;

  final GestureTapCallback? onTap;

  final GestureTapCancelCallback? onTapCancel;

  final GestureTapCallback? onSecondaryTap;

  final GestureTapDownCallback? onSecondaryTapDown;

  final GestureTapUpCallback? onSecondaryTapUp;

  final GestureTapCancelCallback? onSecondaryTapCancel;

  final GestureTapDownCallback? onTertiaryTapDown;

  final GestureTapUpCallback? onTertiaryTapUp;

  final GestureTapCancelCallback? onTertiaryTapCancel;

  final GestureTapDownCallback? onDoubleTapDown;

  final GestureTapCallback? onDoubleTap;

  final GestureTapCancelCallback? onDoubleTapCancel;

  final GestureLongPressDownCallback? onLongPressDown;

  final GestureLongPressCancelCallback? onLongPressCancel;

  final GestureLongPressCallback? onLongPress;

  final GestureLongPressStartCallback? onLongPressStart;

  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;

  final GestureLongPressUpCallback? onLongPressUp;

  final GestureLongPressEndCallback? onLongPressEnd;

  final GestureLongPressDownCallback? onSecondaryLongPressDown;

  final GestureLongPressCancelCallback? onSecondaryLongPressCancel;

  final GestureLongPressCallback? onSecondaryLongPress;

  final GestureLongPressStartCallback? onSecondaryLongPressStart;

  final GestureLongPressMoveUpdateCallback? onSecondaryLongPressMoveUpdate;

  final GestureLongPressUpCallback? onSecondaryLongPressUp;

  final GestureLongPressEndCallback? onSecondaryLongPressEnd;

  final GestureLongPressDownCallback? onTertiaryLongPressDown;

  final GestureLongPressCancelCallback? onTertiaryLongPressCancel;

  final GestureLongPressCallback? onTertiaryLongPress;

  final GestureLongPressStartCallback? onTertiaryLongPressStart;

  final GestureLongPressMoveUpdateCallback? onTertiaryLongPressMoveUpdate;

  final GestureLongPressUpCallback? onTertiaryLongPressUp;

  final GestureLongPressEndCallback? onTertiaryLongPressEnd;

  final GestureDragDownCallback? onVerticalDragDown;

  final GestureDragStartCallback? onVerticalDragStart;

  final GestureDragUpdateCallback? onVerticalDragUpdate;

  final GestureDragEndCallback? onVerticalDragEnd;

  final GestureDragCancelCallback? onVerticalDragCancel;

  final GestureDragDownCallback? onHorizontalDragDown;

  final GestureDragStartCallback? onHorizontalDragStart;

  final GestureDragUpdateCallback? onHorizontalDragUpdate;

  final GestureDragEndCallback? onHorizontalDragEnd;

  final GestureDragCancelCallback? onHorizontalDragCancel;

  final GestureDragDownCallback? onPanDown;

  final GestureDragStartCallback? onPanStart;

  final GestureDragUpdateCallback? onPanUpdate;

  final GestureDragEndCallback? onPanEnd;

  final GestureDragCancelCallback? onPanCancel;

  final GestureScaleStartCallback? onScaleStart;

  final GestureScaleUpdateCallback? onScaleUpdate;

  final GestureScaleEndCallback? onScaleEnd;

  final GestureForcePressStartCallback? onForcePressStart;

  final GestureForcePressPeakCallback? onForcePressPeak;

  final GestureForcePressUpdateCallback? onForcePressUpdate;

  final GestureForcePressEndCallback? onForcePressEnd;

  final HitTestBehavior? behavior;

  final bool excludeFromSemantics;

  final DragStartBehavior dragStartBehavior;

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{};

    if (onTapDown != null ||
        onTapUp != null ||
        onTap != null ||
        onTapCancel != null ||
        onSecondaryTap != null ||
        onSecondaryTapDown != null ||
        onSecondaryTapUp != null ||
        onSecondaryTapCancel != null ||
        onTertiaryTapDown != null ||
        onTertiaryTapUp != null ||
        onTertiaryTapCancel != null) {
      gestures[TapGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
        () => TapGestureRecognizer(debugOwner: this),
        (TapGestureRecognizer instance) {
          instance
            ..onTapDown = onTapDown
            ..onTapUp = onTapUp
            ..onTap = onTap
            ..onTapCancel = onTapCancel
            ..onSecondaryTap = onSecondaryTap
            ..onSecondaryTapDown = onSecondaryTapDown
            ..onSecondaryTapUp = onSecondaryTapUp
            ..onSecondaryTapCancel = onSecondaryTapCancel
            ..onTertiaryTapDown = onTertiaryTapDown
            ..onTertiaryTapUp = onTertiaryTapUp
            ..onTertiaryTapCancel = onTertiaryTapCancel;
        },
      );
    }

    if (onDoubleTap != null) {
      gestures[DoubleTapGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
        () => DoubleTapGestureRecognizer(debugOwner: this),
        (DoubleTapGestureRecognizer instance) {
          instance
            ..onDoubleTapDown = onDoubleTapDown
            ..onDoubleTap = onDoubleTap
            ..onDoubleTapCancel = onDoubleTapCancel;
        },
      );
    }

    if (onLongPressDown != null ||
        onLongPressCancel != null ||
        onLongPress != null ||
        onLongPressStart != null ||
        onLongPressMoveUpdate != null ||
        onLongPressUp != null ||
        onLongPressEnd != null ||
        onSecondaryLongPressDown != null ||
        onSecondaryLongPressCancel != null ||
        onSecondaryLongPress != null ||
        onSecondaryLongPressStart != null ||
        onSecondaryLongPressMoveUpdate != null ||
        onSecondaryLongPressUp != null ||
        onSecondaryLongPressEnd != null ||
        onTertiaryLongPressDown != null ||
        onTertiaryLongPressCancel != null ||
        onTertiaryLongPress != null ||
        onTertiaryLongPressStart != null ||
        onTertiaryLongPressMoveUpdate != null ||
        onTertiaryLongPressUp != null ||
        onTertiaryLongPressEnd != null) {
      gestures[LongPressGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
        () => LongPressGestureRecognizer(debugOwner: this),
        (LongPressGestureRecognizer instance) {
          instance
            ..onLongPressDown = onLongPressDown
            ..onLongPressCancel = onLongPressCancel
            ..onLongPress = onLongPress
            ..onLongPressStart = onLongPressStart
            ..onLongPressMoveUpdate = onLongPressMoveUpdate
            ..onLongPressUp = onLongPressUp
            ..onLongPressEnd = onLongPressEnd
            ..onSecondaryLongPressDown = onSecondaryLongPressDown
            ..onSecondaryLongPressCancel = onSecondaryLongPressCancel
            ..onSecondaryLongPress = onSecondaryLongPress
            ..onSecondaryLongPressStart = onSecondaryLongPressStart
            ..onSecondaryLongPressMoveUpdate = onSecondaryLongPressMoveUpdate
            ..onSecondaryLongPressUp = onSecondaryLongPressUp
            ..onSecondaryLongPressEnd = onSecondaryLongPressEnd
            ..onTertiaryLongPressDown = onTertiaryLongPressDown
            ..onTertiaryLongPressCancel = onTertiaryLongPressCancel
            ..onTertiaryLongPress = onTertiaryLongPress
            ..onTertiaryLongPressStart = onTertiaryLongPressStart
            ..onTertiaryLongPressMoveUpdate = onTertiaryLongPressMoveUpdate
            ..onTertiaryLongPressUp = onTertiaryLongPressUp
            ..onTertiaryLongPressEnd = onTertiaryLongPressEnd;
        },
      );
    }

    if (onVerticalDragDown != null ||
        onVerticalDragStart != null ||
        onVerticalDragUpdate != null ||
        onVerticalDragEnd != null ||
        onVerticalDragCancel != null) {
      gestures[VerticalDragGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<VerticalDragGestureRecognizer>(
        () => VerticalDragGestureRecognizer(debugOwner: this),
        (VerticalDragGestureRecognizer instance) {
          instance
            ..onDown = onVerticalDragDown
            ..onStart = onVerticalDragStart
            ..onUpdate = onVerticalDragUpdate
            ..onEnd = onVerticalDragEnd
            ..onCancel = onVerticalDragCancel
            ..dragStartBehavior = dragStartBehavior;
        },
      );
    }

    if (onHorizontalDragDown != null ||
        onHorizontalDragStart != null ||
        onHorizontalDragUpdate != null ||
        onHorizontalDragEnd != null ||
        onHorizontalDragCancel != null) {
      gestures[HorizontalDragGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<HorizontalDragGestureRecognizer>(
        () => HorizontalDragGestureRecognizer(debugOwner: this),
        (HorizontalDragGestureRecognizer instance) {
          instance
            ..onDown = onHorizontalDragDown
            ..onStart = onHorizontalDragStart
            ..onUpdate = onHorizontalDragUpdate
            ..onEnd = onHorizontalDragEnd
            ..onCancel = onHorizontalDragCancel
            ..dragStartBehavior = dragStartBehavior;
        },
      );
    }

    if (onPanDown != null ||
        onPanStart != null ||
        onPanUpdate != null ||
        onPanEnd != null ||
        onPanCancel != null) {
      gestures[PanGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
        () => PanGestureRecognizer(debugOwner: this),
        (PanGestureRecognizer instance) {
          instance
            ..onDown = onPanDown
            ..onStart = onPanStart
            ..onUpdate = onPanUpdate
            ..onEnd = onPanEnd
            ..onCancel = onPanCancel
            ..dragStartBehavior = dragStartBehavior;
        },
      );
    }

    if (onScaleStart != null || onScaleUpdate != null || onScaleEnd != null) {
      gestures[ScaleGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<ScaleGestureRecognizer>(
        () => ScaleGestureRecognizer(debugOwner: this),
        (ScaleGestureRecognizer instance) {
          instance
            ..onStart = onScaleStart
            ..onUpdate = onScaleUpdate
            ..onEnd = onScaleEnd
            ..dragStartBehavior = dragStartBehavior;
        },
      );
    }

    if (onForcePressStart != null ||
        onForcePressPeak != null ||
        onForcePressUpdate != null ||
        onForcePressEnd != null) {
      gestures[ForcePressGestureRecognizer] =
          GestureRecognizerFactoryWithHandlers<ForcePressGestureRecognizer>(
        () => ForcePressGestureRecognizer(debugOwner: this),
        (ForcePressGestureRecognizer instance) {
          instance
            ..onStart = onForcePressStart
            ..onPeak = onForcePressPeak
            ..onUpdate = onForcePressUpdate
            ..onEnd = onForcePressEnd;
        },
      );
    }

    return RawGestureDetector(
      gestures: gestures,
      behavior: behavior,
      excludeFromSemantics: excludeFromSemantics,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        EnumProperty<DragStartBehavior>('startBehavior', dragStartBehavior));
  }
}

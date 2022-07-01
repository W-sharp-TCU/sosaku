import 'package:flutter/material.dart';

/// Set fading transition easily.
///
/// Changeable parameters:
///   transitionDuration : set time the transition effect takes.
///
/// Example:
///   Navigator.pushReplacement(
///     context,
///     PageRouteBuilder(
///     pageBuilder: (_, __, ___) => HomeScreen(),
///     transitionDuration: const Duration(milliseconds: 500),
///     transitionsBuilder: (context, animation,
///             secondaryAnimation, child) =>
///         buildFadeTransition(
///             context, animation, secondaryAnimation, child)));
FadeTransition buildFadeTransition(
    context, animation, secondaryAnimation, child) {
  const double begin = 0.0;
  const double end = 1.0;
  final Animatable<double> tween =
      Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
  final Animation<double> doubleAnimation = animation.drive(tween);
  return FadeTransition(
    opacity: doubleAnimation,
    child: child,
  );
}

/// Set flash transition
/// (before image --- fading ---> bgColor --- fading ---> after image)
///
/// Changeable parameters:
///   transitionDuration : set time the transition effect takes.
///   bgColor : transition color
///
/// Example:
///   Navigator.pushReplacement(
///     context,
///     PageRouteBuilder(
///     pageBuilder: (_, __, ___) => HomeScreen(),
///     transitionDuration: const Duration(milliseconds: 1500),
///     transitionsBuilder: (context, animation,
///             secondaryAnimation, child) =>
///         buildFadingToColor(Colors.black, context,
///             animation, secondaryAnimation, child)));
AnimatedBuilder buildFlashTransition(
    bgColor, context, animation, secondaryAnimation, child) {
  final color = ColorTween(begin: Colors.transparent, end: bgColor)
      .animate(CurvedAnimation(
    parent: animation,
    // 前半
    curve: const Interval(
      0.0,
      0.4,
      curve: Curves.easeInOut,
    ),
  ));
  final opacity = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: animation,
    // 後半
    curve: const Interval(
      0.6,
      1.0,
      curve: Curves.easeInOut,
    ),
  ));
  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      return Container(
        color: color.value,
        child: Opacity(
          opacity: opacity.value,
          child: child,
        ),
      );
    },
    child: child,
  );
}

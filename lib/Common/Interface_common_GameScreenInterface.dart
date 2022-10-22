import 'package:flutter/cupertino.dart';

abstract class GameScreenInterface {
  /// Must be called before the screen of class implements this function appear.
  /// Implement precache function and special initialization function if necessary.
  /// This function must be a async function.
  Future<void> prepare(BuildContext context);
}

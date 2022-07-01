import 'package:flutter/cupertino.dart';

class MenuScreenProvider extends ChangeNotifier {
  bool _isHelp = false;
  bool get isHelp => _isHelp;

  void setIsHelp({required bool isHelp}) {
    _isHelp = isHelp;
  }
}

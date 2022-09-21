import 'package:flutter/cupertino.dart';

class SelectActionScreenProvider extends ChangeNotifier {
  bool _isStatus = false;
  bool _isStatusUp = false;
  String _statusUpName = '';
  double _statusUpValue = 0;
  Map<String, double> _playerState = {};

  bool get isStatus => _isStatus;
  bool get isStatusUp => _isStatusUp;
  String get statusUpName => _statusUpName;
  double get statusUpValue => _statusUpValue;
  Map<String, double> get playerState => _playerState;

  void setIsStatus(bool isStatus) {
    _isStatus = isStatus;
    notifyListeners();
  }

  void setIsStatusUp(bool isStatusUp) {
    _isStatusUp = isStatusUp;
    notifyListeners();
  }

  void setStatusUpName(String statusUpName) {
    _statusUpName = statusUpName;
    notifyListeners();
  }

  void setStatusUpValue(double statusUpValue) {
    _statusUpValue = statusUpValue;
    notifyListeners();
  }

  void setPlayerState(Map<String, double> playerState) {
    _playerState = playerState;
    notifyListeners();
  }
}

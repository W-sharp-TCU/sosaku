import 'package:flutter/cupertino.dart';

class LoadScreenProvider extends ChangeNotifier {
  String _mBGImagePath = "drawable/Load/default.jpg";
  // final _mLoadScreenProvider = this;
  List<String> _fileImagePaths =
      List.generate(20, (i) => "drawable/Load/default_file_image.png");
  static int _selectFileNumber = 0;

  String get mBGImagePath => _mBGImagePath;
  List get fileImagePaths => _fileImagePaths;
  // var get mLoadScreenProvider => _mLoadScreenProvider;
  int get selectFileNumber => _selectFileNumber;

  ///Set the path of background image for load screen
  ///
  /// @param path: Path of background image for load screen
  void setBGImage(String path) {
    _mBGImagePath = path;
    notifyListeners();
  }

  ///Set image of file
  ///
  /// @param path: Path of file image
  /// @param index: File number
  void setFileImage(String path, int index) {
    _fileImagePaths[index] = path;
    notifyListeners();
  }

  void setFileSelectText(String path) {}

  void start(BuildContext context) {}

  void stop() {}

  void setSelectFileNumber(int i){
    _selectFileNumber = i;
    print(_selectFileNumber); ///debug
    notifyListeners();
  }
}

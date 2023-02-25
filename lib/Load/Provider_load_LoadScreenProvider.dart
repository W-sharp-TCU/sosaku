import 'package:flutter/cupertino.dart';

class LoadScreenProvider extends ChangeNotifier {
  List<String> _fileImagePaths =
      List.generate(20, (i) => "drawable/Load/default_file_image.png");
  static int _selectFileNumber = 0;

  List get fileImagePaths => _fileImagePaths;
  // var get mLoadScreenProvider => _mLoadScreenProvider;
  int get selectFileNumber => _selectFileNumber;

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

  void setSelectFileNumber(int i) {
    _selectFileNumber = i;
    print(_selectFileNumber);

    ///debug
    notifyListeners();
  }
}

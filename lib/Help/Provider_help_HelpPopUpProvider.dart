import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HelpPopUpProvider extends ChangeNotifier {
  Map<String, dynamic>? data;
  /*
  contents = {
    "title": "Tutorial title",
    "contents": [
      {
        "title": "What is Tutorial?",
        "text": "Tutorial is the way to demonstrate how to play the game.\n
                Almost games show tutorial to players at it's first launch.",
        "image": "assets/drawable/tutorial/what_is_tutorial.png"
      }
    ]
  }
   */
  bool _ready = false;
  get ready => _ready;

  int _length = 0;
  get totalPages => _length;
  int _curPageNum = 0;
  get currentPageNo => _curPageNum + 1;

  get isLastPage => _curPageNum == _length;

  String _title = "";
  get title => _title;
  String _text = "";
  get text => _text;
  String _imagePath = "";
  get imagePath => _imagePath;
  bool _hasImage = false;
  get hasImage => _hasImage;

  get fileDescription {
    if (ready) {
      if (data!.containsKey("description")) {
        return data!["description"];
      } else {
        return "<No description>";
      }
    } else {
      return "<No data is loaded.>";
    }
  }

  Future<void> loadContents(String contentsFile) async {
    _ready = false;
    String rawContents = await rootBundle.loadString(contentsFile);
    data = jsonDecode(rawContents);
    if (data != null && data!.containsKey("contents")) {
      _length = data!["contents"]!.length;
      _applyPageContents(0);
      _ready = true;
    } else {
      throw InvalidHelpDataError(contentsFile);
    }
    notifyListeners();
  }

  void _applyPageContents(int contentsIndex) {
    if (0 <= contentsIndex && contentsIndex < _length) {
      _curPageNum = contentsIndex;
      /** Set title **/
      if (data!["contents"][_curPageNum].containsKey("title")) {
        _title = data!["contents"][_curPageNum]["title"];
      } else {
        _title = "<No Title>";
      }
      /** Set text **/
      if (data!["contents"][_curPageNum].containsKey("text")) {
        _text = data!["contents"][_curPageNum]["text"];
      } else {
        _text = "<No Text>";
      }
      /** Set image **/
      if (data!["contents"][_curPageNum].containsKey("image")) {
        _imagePath = data!["contents"][_curPageNum]["image"];
        _hasImage = true;
      } else {
        _imagePath = "<No Image>";
        _hasImage = false;
      }
    } else {
      throw RangeError.range(contentsIndex, 0, _length);
    }
    notifyListeners();
  }

  void setPage(int pageNo) {
    int contentsIndex = pageNo - 1;
    if (ready && 0 <= contentsIndex && contentsIndex < _length) {
      _applyPageContents(contentsIndex);
    }
  }

  void next() {
    if (ready) {
      setPage(currentPageNo + 1);
    }
  }

  void prev() {
    if (ready) {
      setPage(currentPageNo - 1);
    }
  }
}

class InvalidHelpDataError extends Error {
  InvalidHelpDataError(this.filePath) : super();

  String filePath;

  @override
  String toString() {
    return "The format of '$filePath' is invalid.";
  }
}

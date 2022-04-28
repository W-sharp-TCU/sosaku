import 'package:flutter/services.dart';

class ConversationLoadJSON {
  final String _jsonFilePath = 'assets/drawable/Conversation/scenario.json';
  String _sampleText = '';

  void printSampleText() {
    print(_sampleText);
  }

  Future<void> loadJSON() async {
    String loadData = await rootBundle.loadString(_jsonFilePath);
    _sampleText = loadData;
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  ///Save an integer value with key.
  ///
  /// @param key: name of key
  /// @param num: integer value to be saved
  static setInt(String key, int num) async {
    SharedPreferences? _pref;
    _pref = await SharedPreferences.getInstance();
    await _pref.setInt(key, num);
  }

  ///Save a boolean value with key.
  ///
  /// @param key: name of key
  /// @param boolean: boolean value to be saved
  static void setBool(String key, bool boolean) async {
    SharedPreferences? _pref;
    _pref = await SharedPreferences.getInstance();
    await _pref.setBool(key, boolean);
  }

  ///Save a double value with key.
  ///
  /// @param key: name of key
  /// @param num: double value to be saved
  static void setDouble(String key, double num) async {
    SharedPreferences? _pref;
    _pref = await SharedPreferences.getInstance();
    await _pref.setDouble(key, num);
  }

  ///Save a string value with key.
  ///
  /// @param key: name of key
  /// @param str: string value to be saved
  static void setString(String key, String str) async {
    SharedPreferences? _pref;
    _pref = await SharedPreferences.getInstance();
    await _pref.setString(key, str);
  }

  ///Save a list of string with key.
  ///
  /// @param key: name of key
  /// @param list: list to be saved
  static void setList(String key, List<String> list) async {
    SharedPreferences? _pref;
    _pref = await SharedPreferences.getInstance();
    await _pref.setStringList(key, list);
  }

  ///get an integer value saved with key
  ///
  /// @param key: key associated with value gotten
  static Future<int> getInt(String key) async {
    SharedPreferences? _pref;
    _pref = await SharedPreferences.getInstance();
    if (_pref.getInt(key) == null) {
      throw "there is no data for key called " + key;
    }
    return _pref.getInt(key)!;
  }

  ///get a boolean value saved with key
  ///
  /// @param key: key associated with value gotten
  static Future<bool> getBool(String key) async {
    SharedPreferences? _pref;
    _pref = await SharedPreferences.getInstance();
    if (_pref.getBool(key) == null) {
      throw "there is no data for key called " + key;
    }
    return _pref.getBool(key)!;
  }

  ///get a double value saved with key
  ///
  /// @param key: key associated with value gotten
  static Future<double> getDouble(String key) async {
    SharedPreferences? _pref;
    _pref = await SharedPreferences.getInstance();
    if (_pref.getDouble(key) == null) {
      throw "there is no data for key called " + key;
    }
    return _pref.getDouble(key)!;
  }

  ///get a string value saved with key
  ///
  /// @param key: key associated with value gotten
  static Future<String> getString(String key) async {
    SharedPreferences? _pref;
    _pref = await SharedPreferences.getInstance();
    if (_pref.getString(key) == null) {
      throw "there is no data for key called " + key;
    }
    return _pref.getString(key)!;
  }

  ///get a list of string saved with key
  ///
  /// @param key: key associated with value gotten
  static Future<List<String>> getList(String key) async {
    SharedPreferences? _pref;
    _pref = await SharedPreferences.getInstance();
    if (_pref.getStringList(key) == null) {
      throw "there is no data for key called " + key;
    }
    return _pref.getStringList(key)!;
  }
}

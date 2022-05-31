import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  ///Save an integer value with key.
  ///
  /// @param key: name of key
  /// @param num: integer value to be saved
  static setInt(String key, int num)async{
  SharedPreferences? _pref;
  _pref = await SharedPreferences.getInstance();
  await _pref.setInt(key, num);
  }

  ///Save a boolean value with key.
  ///
  /// @param key: name of key
  /// @param boolean: boolean value to be saved
  static void setBool(String key, bool boolean)async{
  SharedPreferences? _pref;
  _pref = await SharedPreferences.getInstance();
  await _pref.setBool(key, boolean);
  }

  ///Save a double value with key.
  ///
  /// @param key: name of key
  /// @param num: double value to be saved
  static void setDouble(String key, double num)async{
  SharedPreferences? _pref;
  _pref = await SharedPreferences.getInstance();
  await _pref.setDouble(key, num);
  }

  ///Save a string value with key.
  ///
  /// @param key: name of key
  /// @param str: string value to be saved
  static void setString(String key, String str)async{
  SharedPreferences? _pref;
  _pref = await SharedPreferences.getInstance();
  await _pref.setString(key, str);
  }

  ///Save a list of string with key.
  ///
  /// @param key: name of key
  /// @param list: list to be saved
  static void setList(String key, List<String> list)async{
  SharedPreferences? _pref;
  _pref = await SharedPreferences.getInstance();
  await _pref.setStringList(key, list);
  }



  ///get an integer value saved with key.
  ///this function requires "await" at beginning of sentence.
  ///ex) int a = await SharedPref.getInt("key", -1);
  ///
  /// @param key: key associated with value gotten
  /// @param def: if there is no data, this function return value of def
  static Future<int> getInt(String key, int def) async {
  SharedPreferences? _pref;
  _pref = await SharedPreferences.getInstance();
  if (_pref.getInt(key) == null) {
  return def;
  }
  return _pref.getInt(key)!;
  }

  ///get a boolean value saved with key.
  ///this function requires "await" at beginning of sentence.
  ///ex) bool a = await SharedPref.getBool("key", false);
  ///
  /// @param key: key associated with value gotten
  /// @param def: if there is no data, this function return value of def
  static Future<bool> getBool(String key, bool def) async{
  SharedPreferences? _pref;
  _pref = await SharedPreferences.getInstance();
  if (_pref.getBool(key) == null) {
  return def;
  }
  return _pref.getBool(key)!;
  }

  ///get a double value saved with key.
  ///this function requires "await" at beginning of sentence.
  ///ex) double a = await SharedPref.getDouble("key", -1.0);
  ///
  /// @param key: key associated with value gotten
  /// @param def: if there is no data, this function return value of def
  static Future<double> getDouble(String key, double def) async{
  SharedPreferences? _pref;
  _pref = await SharedPreferences.getInstance();
  if (_pref.getDouble(key) == null) {
  return def;
  }
  return _pref.getDouble(key)!;
  }

  ///get a string value saved with key.
  ///this function requires "await" at beginning of sentence.
  ///ex) String a = await SharedPref.getString("key", "error");
  ///
  /// @param key: key associated with value gotten
  /// @param def: if there is no data, this function return value of def
  static Future<String> getString(String key, String def) async{
  SharedPreferences? _pref;
  _pref = await SharedPreferences.getInstance();
  if (_pref.getString(key) == null) {
  return def;
  }
  return _pref.getString(key)!;
  }

  ///get a list of string saved with key.
  ///this function requires "await" at beginning of sentence.
  ///ex) List<String> a = await SharedPref.getBool("key", ["error"]);
  ///
  /// @param key: key associated with value gotten
  /// @param def: if there is no data, this function return value of def
  static Future<List<String>> getList(String key, List<String> def) async{
  SharedPreferences? _pref;
  _pref = await SharedPreferences.getInstance();
  if (_pref.getStringList(key) == null) {
  return def;
  }
  return _pref.getStringList(key)!;
  }


  }


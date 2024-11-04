import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void setStrings(String key, String value)  {
    _prefs!.setString(key, value);
  }

  static String getStrings(String key)  {
    final value = _prefs!.getString(key);
    return value ?? '';
  }

  static void setIntegers (String key, int value)  {
    _prefs!.setInt(key, value);
  }

  static int? getIntegers(String key)  {
    return _prefs!.getInt(key);
  }

  static  setBool(String key, bool value) async {
    await _prefs!.setBool(key, value);
  }

  static bool? getBool(String key)  {
    return _prefs!.getBool(key);
  }

  static setList(String key, List<String> items)  {
     _prefs!.setStringList(key, items);
  }

  static  getList(String key)  {
    return _prefs!.getStringList(key);
  }
}

import 'package:shared_preferences/shared_preferences.dart';class Prefs {  static void setInt(String key, int value) async {    SharedPreferences preferences = await SharedPreferences.getInstance();    preferences.setInt(key, value);  }  static Future<int> getInt(String key) async {    var preferences = await SharedPreferences.getInstance();    return preferences.getInt("tabIndex") ?? 0;  }}
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<void> init() async{
    prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences? prefs;
  static const String _cumtLoginUsername = "cumtLoginUsername";
  static const String _isDark = "theme";

  static String get cumtLoginUsername => _get(_cumtLoginUsername);
  static String get isDark => _get(_isDark);

  static set cumtLoginUsername(String value) => _set(_cumtLoginUsername, value);
  static set isDark(String value) => _set(_isDark, value);

  static String _get(String key) => prefs?.getString(key)??"";
  static _set(String key, String value) => prefs?.setString(key, value);
}


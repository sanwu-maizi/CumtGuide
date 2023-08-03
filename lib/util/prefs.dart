import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<void> init() async{
    prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences? prefs;
  static const String _cumtLoginUsername = "Username";
  static const String _isDark = "theme";
  static const String _avatarImagePath = "assets/2.jpg";

  static String get cumtLoginUsername => _get(_cumtLoginUsername);
  static String get isDark => _get(_isDark);
  static String get avatarImagePath => _avatarImagePath;

  static set cumtLoginUsername(String value) => _set(_cumtLoginUsername, value);
  static set isDark(String value) => _set(_isDark, value);
  static set avatarImagePath(String value) => _set(_avatarImagePath,value);

  static String _get(String key) => prefs?.getString(key)??"";
  static _set(String key, String value) => prefs?.setString(key, value);
}


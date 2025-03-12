import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum LocalStorageKey {
  records,
}

class LocalStorageService {
  static late SharedPreferences _prefs;

  static Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setValue(LocalStorageKey key, Object value) async {
    await _prefs.setString(key.name, jsonEncode(value));
  }

  static dynamic getValue(LocalStorageKey key) {
    final result = _prefs.get(key.name) as String;
    return jsonDecode(result);
  }
}

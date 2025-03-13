import 'dart:convert';

import 'package:my_money/src/services/debug_service.dart';
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
    try {
      await _prefs.setString(key.name, jsonEncode(value));
    } catch (e) {
      myLog.e(
          "setValue - failed to set value with key $key and value $value, error detail ${e.toString()}");
    }
  }

  static Object? getValue(LocalStorageKey key) {
    final result = _prefs.get(key.name);
    if (result is String) return jsonDecode(result);

    myLog.i("getValue - key $key is not string value, the value is $result");

    return null;
  }
}

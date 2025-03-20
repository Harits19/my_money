import 'dart:convert';

import 'package:my_money/src/services/debug_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LocalStorageKey {
  records,
  categories,
}

class LocalStorageService {
  static late SharedPreferences _prefs;

  final LocalStorageKey key;

  LocalStorageService({required this.key});

  static Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  setValue(Object value) async {
    try {
      myLog.i("setValue - value receive $value, key receive $key");
      var parsedValue = value;
      // if (parsedValue is Iterable) {
      //   parsedValue = parsedValue.toList();
      // }
      await _prefs.setString(key.name, jsonEncode(parsedValue));
    } catch (e) {
      myLog.e("setValue - failed to set value error detail ${e.toString()}");
    }
  }

  Object? getValue() {
    final result = _prefs.get(key.name);
    myLog.i("getValue - key $key is the value is $result");

    if (result is String) return jsonDecode(result);

    return null;
  }
}

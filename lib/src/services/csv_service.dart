import 'dart:io';

import 'package:my_money/src/services/debug_service.dart';

class CsvService {
  static Future<List<List<String>>?> readFromFile(File file) async {
    final isFileExist = await file.exists();
    if (!isFileExist) {
      myLog.i("readFromFile file path ${file.path} doesn't exist");
      return null;
    }

    final data = await file.readAsString();
    final rows = data.split("\n");

    final list = rows.map((item) {
      return item.replaceAll('"', "").split(",");
    });

    return list.toList();
  }
}

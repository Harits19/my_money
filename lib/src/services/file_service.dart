import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:my_money/src/services/debug_service.dart';

class FileService {
  static Future<File?> pickCSV() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result == null) {
      myLog.i("pickCSV result file is null");
      return null;
    }
    final path = result.files.single.path;
    if (path == null) {
      myLog.i("pickCSV result path file is null");
      return null;
    }

    return File(path);
  }
}

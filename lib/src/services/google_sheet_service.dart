import 'package:googleapis/drive/v2.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/services/google_service.dart';

class GoogleSheetService {
  static final services = GoogleService(
      scopes: [SheetsApi.spreadsheetsScope, DriveApi.driveFileScope]);

  static Future<String?> createSpreadsheet() async {
    final client = await services.authClient;
    if (client == null) {
      myLog.i("createSpreadsheet - client is null");
      return null;
    }

    final sheetsApi = SheetsApi(client);
    final Spreadsheet spreadsheet = Spreadsheet(
      properties: SpreadsheetProperties(title: "Flutter Created Spreadsheet"),
    );

    final response = await sheetsApi.spreadsheets.create(spreadsheet);

    myLog.i("createSpreadsheet - returned url ${response.spreadsheetUrl}");
    return response.spreadsheetId;
  }

  static Future<List<File>> getAllSpreadSheetFiles() async {
    final client = await services.authClient;
    if (client == null) {
      myLog.i("getAllSpreadSheetFiles - client is null");
      return [];
    }
    final driveApi = DriveApi(client);

    const query = "mimeType='application/vnd.google-apps.spreadsheet'";

    final fileList = await driveApi.files.list(q: query, spaces: 'drive');

    final items = fileList.items;

    if (items == null) {
      myLog.i("getAllSpreadSheetFiles - file items is null");
      return [];
    }

    return items;
  }

  static editSpreadSheet({required String id}) async {
    const range = "Sheet1!A1:B2"; // Range to update
    final values = [
      ["Updated Cell 1", "Updated Cell 2"],
      ["New Row", "More Data"]
    ];
    final client = await services.authClient;
    if (client == null) {
      myLog.i("editSpreadSheet - client is null");
      return null;
    }
    final sheetsApi = SheetsApi(client);

    final request = ValueRange()..values = values;

    final result = await sheetsApi.spreadsheets.values.update(
      request,
      id,
      range,
      valueInputOption: "RAW",
    );

    myLog.i(
        "editSpreadSheet - success edit spreadsheet with result ${result.toJson()}");
  }

  static void startBackup() async {
    final files = await getAllSpreadSheetFiles();

    if (files.isEmpty) {
      myLog.i(
          "startBackup - returned files is empty, start create new file for backup data");
      await createSpreadsheet();
      return;
    } else {
      myLog.i(
          "startBackup - returned files is not empty, start edit first index file");

      final file = files.first;
      final id = file.id;
      if (id == null) {
        myLog.i(
            "startBackup - returned id is null, can't update the file with new data");
        return;
      }
      await editSpreadSheet(id: id);
    }
  }
}

import 'package:googleapis/drive/v2.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/services/google_service.dart';
import 'package:my_money/src/util/int_util.dart';

abstract class SheetModel {
  List<String> toListString();
}

class _MapValueReturn<A, B> {
  final A item1;
  final B item2;

  _MapValueReturn(
    this.item1,
    this.item2,
  );
}

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

  static _MapValueReturn<String, List<List<String>>>
      mapValues<T extends SheetModel>({
    required List<T> values,
  }) {
    final mappedValues = values.map((item) {
      return item.toListString();
    }).toList();
    final firstRow = mappedValues.first;
    final excelColumn = firstRow.length.getExcelColumn();
    final range = "Sheet1!A1:$excelColumn${mappedValues.length + 1}";

    myLog.i(
      "mapValues - result ${{
        mappedValues,
        range,
      }}",
    );

    return _MapValueReturn(range, mappedValues);
  }

  static editSpreadSheet<T extends SheetModel>({
    required String id,
    required List<T> list,
  }) async {
    final resultMap = mapValues(values: list);

    final values = resultMap.item2;
    final range = resultMap.item1;

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
}

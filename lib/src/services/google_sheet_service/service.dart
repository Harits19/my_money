import 'package:googleapis/drive/v2.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/util/num_util.dart';
part 'model.dart';

class GoogleSheetService {
  GoogleSheetService({
    required this.client,
  });

  final AuthClient client;
  late final sheetsApi = SheetsApi(client);
  late final driveApi = DriveApi(client);

  Future<Spreadsheet> createSpreadsheet() async {
    final Spreadsheet spreadsheet = Spreadsheet(
      properties: SpreadsheetProperties(title: "UangKu - Spreadsheet"),
    );

    final response = await sheetsApi.spreadsheets.create(
      spreadsheet,
    );

    myLog.i("createSpreadsheet - returned value ${response.toJson()}");
    return response;
  }

  Future<File?> getSpreadsheetFile() async {
    const query = "mimeType='application/vnd.google-apps.spreadsheet'";

    final fileList = await driveApi.files.list(q: query, spaces: 'drive');

    final items = fileList.items;

    if (items == null || items.isEmpty) {
      myLog.i("getSpreadsheetFile - file items is null");
      return null;
    }

    return items.first;
  }

  _MapValueReturn<String, List<List<String>>> _mapValues<T extends SheetModel>({
    required List<T> values,
    required List<String> listOfTitles,
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

    mappedValues.insert(0, listOfTitles);

    return _MapValueReturn(range, mappedValues);
  }

  Future<void> editSpreadSheet<T extends SheetModel>({
    required String id,
    required List<T> list,
    required List<String> listOfTitles,
  }) async {
    final resultMap = _mapValues(
      values: list,
      listOfTitles: listOfTitles,
    );

    final values = resultMap.item2;
    final range = resultMap.item1;

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

  Future<void> getSpreadsheet() async {}
}

import 'package:flutter/material.dart';
import 'package:my_money/src/services/csv_service.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/services/file_service.dart';
import 'package:my_money/src/services/google_sheet_service.dart';
import 'package:my_money/src/services/local_storage_service.dart';
import 'package:my_money/src/state/date_state.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/state/record_state/state.dart';

class RecordProvider extends StatefulWidget {
  const RecordProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<RecordProvider> createState() => _RecordProviderState();
}

class _RecordProviderState extends State<RecordProvider> {
  List<RecordModel> records = [];
  bool isLoading = false;
  String? spreadsheetId;

  void importCSV() async {
    final file = await FileService.pickCSV();

    if (file == null) return;

    final list = await CsvService.readFromFile(file);
    if (list == null) return;

    final parsedList = RecordModel.fromCSV(list).reversed.toList();
    records = parsedList;
    setState(() {});

    final listJson = RecordModel.toJsonList(parsedList);

    LocalStorageService.setValue(LocalStorageKey.records, listJson);
  }

  void loadLocalStorage() async {
    final localValue = LocalStorageService.getValue(LocalStorageKey.records);

    if (localValue is! List<dynamic>) {
      myLog.i(
          "loadLocalStorage - returned value from local storage is not List<dynamic>, the values is $localValue");
      return;
    }

    final parsedValue = RecordModel.fromJsonList(localValue);

    records = parsedValue;
    setState(() {});
  }

  void deleteAllRecords() {
    records = [];
    LocalStorageService.setValue(LocalStorageKey.records, []);
    setState(() {});
  }

  void setLoading(bool value) {
    isLoading = value;
    setState(() {});
  }

  void startSync() async {
    try {
      setLoading(true);

      final file = await GoogleSheetService.getSpreadsheetFile();
      final id = file?.id;

      if (id == null) {
        myLog.i(
            "startSync - returned id file is null, start create new file for backup data");
        final createdSpreadsheet = await GoogleSheetService.createSpreadsheet();
        final createdId = createdSpreadsheet.spreadsheetId;

        if (createdId == null) {
          throw Exception(
              "startSync - createdId is null with value ${createdSpreadsheet.toJson()}");
        }

        setLink(createdId);

        await GoogleSheetService.editSpreadSheet(
          id: createdId,
          list: records,
          listOfTitles: RecordModel.listOfTitles(),
        );
      } else {
        setLink(id);

        myLog
            .i("startSync - returned id file is not null, start edit the file");
        await GoogleSheetService.editSpreadSheet(
          id: id,
          list: records,
          listOfTitles: RecordModel.listOfTitles(),
        );
      }
    } catch (e) {
      myLog.e('startSync - failed because $e');
    } finally {
      setLoading(false);
    }
  }

  void setLink(String id) {
    spreadsheetId = id;
    setState(() {});
  }

  void addRecord(RecordModel newValue) {
    records = [...records, newValue];

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return RecordState(
      spreadsheetId: spreadsheetId ?? '',
      isLoading: isLoading,
      addRecord: addRecord,
      syncWithGoogleSpreadsheet: startSync,
      deleteAllRecords: deleteAllRecords,
      records: records,
      importCSV: importCSV,
      selectedDate: DateState.of(context).date,
      child: widget.child,
    );
  }
}

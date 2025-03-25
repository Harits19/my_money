import 'package:flutter/material.dart';
import 'package:my_money/src/app.dart';
import 'package:my_money/src/model/json.dart';
import 'package:my_money/src/services/csv_service.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/services/file_service.dart';
import 'package:my_money/src/services/google_sheet_service/service.dart';
import 'package:my_money/src/services/local_storage_service.dart';
import 'package:my_money/src/state/category_state/state.dart';
import 'package:my_money/src/state/date_state.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/network_util.dart';

class RecordProvider extends StatefulWidget {
  const RecordProvider({
    super.key,
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  State<RecordProvider> createState() => _RecordProviderState();
}

class _RecordProviderState extends State<RecordProvider> {
  List<RecordModel> records = [];
  bool isLoading = false;
  bool isLoadingPref = true;
  String? spreadsheetId;

  final localStorage = LocalStorageService(key: LocalStorageKey.records);

  void importCSV() async {
    final file = await FileService.pickCSV();

    if (file == null) return;

    final list = await CsvService.readFromFile(file);
    if (list == null) return;

    final parsedList = RecordModel.fromCSV(list).toList();
    records = parsedList;
    setState(() {});

    syncLocalStorage(parsedList);
  }

  void syncLocalStorage(List<RecordModel> list) {
    final listJson = list.toJsonList();

    localStorage.setValue(listJson);
  }

  Future<void> loadLocalStorage() async {
    final localValue = localStorage.getValue();

    if (localValue is! List<dynamic>) {
      myLog.i(
          "loadLocalStorage - returned value from local storage is not List<dynamic>, the values is $localValue");
      return;
    }

    final parsedValue = RecordModel.fromJsonList(localValue);

    records = parsedValue;
    setState(() {});
  }

  void init() async {
    setLoading(true);
    await LocalStorageService.initPrefs();
    await loadLocalStorage();
    setLoading(false);
  }

  void deleteAllRecords() {
    records = [];
    localStorage.setValue([]);
    setState(() {});
  }

  void setLoading(bool value) {
    isLoading = value;
    setState(() {});
  }

  Future<bool> checkHasInternetConnection() async {
    final isHasInternetConnection = await hasInternet();

    if (!isHasInternetConnection) {
      snackbarKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("No Internet Connection"),
          duration: Duration(minutes: 5),
        ),
      );
    }

    return isHasInternetConnection;
  }

  void syncWithGoogleSpreadsheet() async {
    try {
      setLoading(true);

      final hasInternet = await checkHasInternetConnection();

      if (!hasInternet) {
        setLoading(false);
        return;
      }

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

  void setRecords(List<RecordModel> newRecords) {
    newRecords.sort((a, b) => b.time.compareTo(a.time));
    records = newRecords;
    syncLocalStorage(newRecords);
    setState(() {});
  }

  void addRecord(RecordModel newValue) {
    final newRecords = [newValue, ...records];
    setRecords(newRecords);
  }

  void updateRecord(RecordModel value) {
    final newRecords = [...records];
    final index = newRecords.indexWhere((item) => item.id == value.id);
    newRecords[index] = value;
    setRecords(newRecords);
  }

  void deleteRecord(RecordModel value) {
    final newRecords = [...records];
    final index = newRecords.indexWhere((item) => item.id == value.id);
    newRecords.removeAt(index);
    setRecords(newRecords);
  }

  void updateCategory({
    required CategoryModel oldCategory,
    required CategoryModel newCategory,
  }) {
    final newRecords = records.map((item) {
      if (item.category != oldCategory.name) {
        return item;
      }
      item.category = newCategory.name;
      return item;
    }).toList();

    setRecords(newRecords);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return RecordState(
      deleteRecord: deleteRecord,
      updateRecord: updateRecord,
      updateCategory: updateCategory,
      spreadsheetId: spreadsheetId ?? '',
      isLoading: isLoading,
      addRecord: addRecord,
      syncWithGoogleSpreadsheet: syncWithGoogleSpreadsheet,
      deleteAllRecords: deleteAllRecords,
      records: records,
      importCSV: importCSV,
      selectedDate: DateState.of(context).date,
      child: Builder(builder: (context) {
        return widget.builder(context);
      }),
    );
  }
}

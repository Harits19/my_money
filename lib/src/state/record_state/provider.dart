import 'package:flutter/material.dart';
import 'package:my_money/src/services/csv_service.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/services/file_service.dart';
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

  @override
  void initState() {
    super.initState();
    loadLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return RecordState(
      records: records,
      importCSV: importCSV,
      selectedDate: DateState.of(context).date,
      child: widget.child,
    );
  }
}

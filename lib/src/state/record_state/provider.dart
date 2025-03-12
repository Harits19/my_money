import 'package:flutter/material.dart';
import 'package:my_money/src/services/csv_service.dart';
import 'package:my_money/src/services/file_service.dart';
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

    final parsedList = RecordModel.fromCSV(list);
    records = parsedList;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RecordState(
      records: records,
      importCSV: importCSV,
      child: widget.child,
    );
  }
}

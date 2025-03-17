import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:intl/intl.dart';
import 'package:my_money/src/state/record_state/model.dart';

class RecordState extends InheritedWidget {
  const RecordState({
    super.key,
    required this.records,
    required super.child,
    required this.importCSV,
    required this.selectedDate,
    required this.deleteAllRecords,
    required this.syncWithGoogleSpreadsheet,
    required this.isLoading,
    required this.addRecord,
    this.spreadsheetId = "",
  });

  final List<RecordModel> records;
  final DateTime selectedDate;
  final VoidCallback importCSV;
  final VoidCallback deleteAllRecords;
  final ValueChanged<RecordModel> addRecord;
  final VoidCallback syncWithGoogleSpreadsheet;
  final bool isLoading;
  final String spreadsheetId;

  List<String> get categories {
    final result = records.map((item) => item.category).toSet().toList();

    return result;
  }

  List<String> get accounts {
    final result = records.map((item) => item.account).toSet().toList();

    return result;
  }

  List<RecordType> get types {
    final result = records.map((item) => item.type).toSet().toList();

    return result;
  }

  List<String> get notes {
    final result = records.map((item) => item.notes).toSet().toList();

    return result;
  }

  List<RecordModel> get filterByMonth {
    return records.where((item) {
      final format = DateFormat("YYYY MMM");
      return format.format(item.time) == format.format(selectedDate);
    }).toList();
  }

  static RecordState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RecordState>();
  }

  static RecordState of(BuildContext context) {
    final RecordState? result = maybeOf(context);
    assert(result != null, 'No State found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(RecordState oldWidget) {
    return oldWidget.records != records ||
        oldWidget.isLoading != isLoading ||
        oldWidget.spreadsheetId != spreadsheetId;
  }
}

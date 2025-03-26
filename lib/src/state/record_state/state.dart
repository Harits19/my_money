import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/src/model/tuple.dart';
import 'package:my_money/src/state/record_state/model.dart';

class RecordState extends InheritedWidget {
  const RecordState({
    super.key,
    required this.records,
    required super.child,
    required this.importCSV,
    required this.selectedDate,
    required this.deleteAllRecords,
    required this.pushToGoogleSpreadsheet,
    required this.isLoading,
    required this.addRecord,
    this.spreadsheetId = "",
    required this.updateRecord,
    required this.deleteRecord,
    required this.updateCategory,
    required this.getCurrentSpreadsheetId,
    required this.pullFromGoogleSpreadsheet,
  });

  final List<RecordModel> records;
  final DateTime selectedDate;
  final VoidCallback importCSV;
  final VoidCallback deleteAllRecords;
  final Future<void> Function() getCurrentSpreadsheetId,
      pullFromGoogleSpreadsheet;
  final ValueChanged<RecordModel> addRecord;
  final ValueChanged<RecordModel> deleteRecord;

  final void Function(RecordModel) updateRecord;
  final void Function({
    required String oldCategory,
    required String newCategory,
  }) updateCategory;
  final VoidCallback pushToGoogleSpreadsheet;
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

  int get totalCurrentMonth {
    return filterByMonth.fold(0, (prev, current) {
      return prev + current.amount.toInt();
    });
  }

  List<RecordModel> search(String search) {
    return filterByMonth.where(
      (element) {
        final stringValue = jsonEncode(element.toJson()).toLowerCase();
        final searchValue = search.toLowerCase();
        return stringValue.contains(searchValue);
      },
    ).toList();
  }

  List<RecordModel> filterByKey({
    required String key,
    required RecordModelKey modelKey,
  }) {
    return filterByMonth.where(
      (element) {
        return modelKey(element) == key;
      },
    ).toList();
  }

  Map<String, int> countTotalByKey({
    required RecordModelKey modelKey,
  }) {
    final uniqueList = filterByMonth.map((e) => modelKey(e)).toSet().toList();

    final Map<String, int> result = {};

    for (final item in uniqueList) {
      final filterListByKey = filterByKey(key: item, modelKey: modelKey);

      final total = filterListByKey.fold(
        0,
        (previousValue, element) {
          return previousValue + element.amount;
        },
      );
      result[item] = total;
    }
    return result;
  }

  Tuple2<Map<String, int>, RecordModelKey> get categoryAnalysis {
    String valueKeyCategory(RecordModel item) {
      return item.category;
    }

    final totalCategories = countTotalByKey(
      modelKey: valueKeyCategory,
    );

    return Tuple2(totalCategories, valueKeyCategory);
  }

  Map<String, Tuple2<Map<String, int>, RecordModelKey>> get analysisResult {
    String valueKeyAccount(RecordModel item) {
      return item.account;
    }

    final totalAccounts = countTotalByKey(
      modelKey: valueKeyAccount,
    );

    return {
      "categories": categoryAnalysis,
      "accounts": Tuple2(totalAccounts, valueKeyAccount),
    };
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
        oldWidget.spreadsheetId != spreadsheetId ||
        oldWidget.selectedDate != selectedDate;
  }
}

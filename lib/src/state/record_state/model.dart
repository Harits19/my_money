import 'package:intl/intl.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/services/google_sheet_service.dart';
import 'package:my_money/src/util/date_util.dart';

enum RecordType {
  expense,
  income;

  static const incomeString = '(+) Income';
  static const expenseString = '(-) Expense';

  static RecordType fromString(String value) {
    switch (value.trim()) {
      case expenseString:
        return RecordType.expense;
      default:
        return RecordType.income;
    }
  }

  @override
  String toString() {
    switch (this) {
      case RecordType.expense:
        return expenseString;
      default:
        return incomeString;
    }
  }
}

class RecordModel implements SheetModel {
  final DateTime time;
  final RecordType type;
  final num amount;
  final String category;
  final String account;
  final String notes;

  RecordModel(
      {required this.time,
      required this.type,
      required this.amount,
      required this.category,
      required this.account,
      required this.notes});

  Map<String, dynamic> toJson() {
    return {
      "time": time.toString(),
      "type": type.toString(),
      "amount": amount,
      "category": category,
      "account": account,
      "notes": notes,
    };
  }

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      time: DateTime.parse(json['time']),
      type: RecordType.fromString(json['type']),
      amount: json['amount'],
      category: json['category'],
      account: json['account'],
      notes: json['notes'],
    );
  }

  static List<RecordModel> fromCSV(List<List<String>> value) {
    value.removeAt(0);

    final result = value.asMap().entries.map((entry) {
      final item = entry.value;
      try {
        final format = DateFormat('MMM dd, yyyy h:mm a');

        final dateTime = format.tryParse("${item[0]},${item[1]}");
        return RecordModel(
          time: dateTime ?? DateTime.now(),
          type: RecordType.fromString(item[2]),
          amount: num.tryParse(item[3]) ?? 0,
          category: item[4],
          account: item[5],
          notes: item[6],
        );
      } catch (e) {
        myLog.e('index ${entry.key} value $item');
        return null;
      }
    });

    final List<RecordModel> filteredResult = [];

    for (var item in result) {
      if (item == null) continue;
      filteredResult.add(item);
    }

    return filteredResult;
  }

  static List<Map<String, dynamic>> toJsonList(List<RecordModel> list) {
    return list.map((item) => item.toJson()).toList();
  }

  static List<RecordModel> fromJsonList(List<dynamic> json) {
    return json.map((item) => RecordModel.fromJson(item)).toList();
  }

  @override
  List<String> toListString() {
    return [
      time.format3(),
      type.toString(),
      amount.toString(),
      category,
      account,
      notes,
    ];
  }
}

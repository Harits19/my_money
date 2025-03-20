import 'package:intl/intl.dart';

extension NumExtension on num {
  String toIdr() {
    final formatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return formatter.format((this));
  }

  String toPercent() {
    return "${(this * 100).toInt()} %";
  }
}

extension IntExtension on int {
  String getExcelColumn() {
    var columnNumber = this;
    String result = '';
    while (columnNumber > 0) {
      columnNumber--;
      result = String.fromCharCode(columnNumber % 26 + 65) + result;
      columnNumber ~/= 26;
    }
    return result;
  }
}

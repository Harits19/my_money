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
}

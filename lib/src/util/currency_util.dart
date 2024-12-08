import 'package:intl/intl.dart';

class CurrencyUtil {
  static String toIdr(num? value) {
    final formatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return formatter.format((value ?? 0));
  }
}

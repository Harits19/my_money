import 'package:intl/intl.dart';

class DateUtil {
  /// eg. September, 2024
  static String format1(DateTime date) {
    return DateFormat("MMMM, yyyy").format(date);
  }

  /// eg. Sep 30, Monday
  static String format2(DateTime date) {
    return DateFormat("EEEE, dd MMM yyyy").format(date);
  }

  /// eg. Sep 30, 2024 9:38 PM
  static String format3(DateTime date) {
    return DateFormat("MMM dd, yyyy hh:mm a").format(date);
  }
}

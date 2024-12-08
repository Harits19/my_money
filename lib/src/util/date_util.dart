import 'package:intl/intl.dart';

class DateUtil {
  // September, 2024
  static String dateFormat1(DateTime date) {
    return DateFormat("MMMM, yyyy").format(date);
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// eg. September, 2024
  String format1() {
    return DateFormat("MMMM, yyyy").format(this);
  }

  /// eg. Sep 30, Monday
  String format2() {
    return DateFormat("MMM dd, EEEE").format(this);
  }

  /// eg. Sep 30, 2024 9:38 PM
  String format3() {
    return DateFormat("MMM dd, yyyy hh:mm a").format(this);
  }

  /// eg. 30 Sep 2024 | 9:38 PM
  String format4() {
    return DateFormat("dd MMM yyyy | hh:mm a").format(this);
  }

  DateTime mergeWithTimeOfDay(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }
}

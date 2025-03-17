import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// eg. September, 2024
  String format1() {
    return DateFormat("MMMM, yyyy").format(this);
  }

  /// eg. Sep 30, Monday
  String format2() {
    return DateFormat("EEEE, dd MMM yyyy").format(this);
  }

  /// eg. Sep 30, 2024 9:38 PM
  String format3() {
    return DateFormat("MMM dd, yyyy hh:mm a").format(this);
  }

  DateTime mergeWithTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }
}

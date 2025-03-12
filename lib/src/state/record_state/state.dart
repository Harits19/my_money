import 'package:flutter/material.dart';
import 'package:my_money/src/state/record_state/model.dart';

class RecordState extends InheritedWidget {
  const RecordState({
    super.key,
    required this.records,
    required super.child,
    required this.importCSV,
  });

  final List<RecordModel> records;

  final VoidCallback importCSV;

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
    return oldWidget.records != records;
  }
}

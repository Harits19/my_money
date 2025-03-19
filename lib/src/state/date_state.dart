import 'package:flutter/material.dart';

class DateState extends InheritedWidget {
  const DateState({
    super.key,
    required this.date,
    required this.changeMonth,
    required super.child,
  });

  final DateTime date;

  final void Function(bool) changeMonth;

  static DateState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DateState>();
  }

  static DateState of(BuildContext context) {
    final DateState? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DateState oldWidget) {
    return true;
  }
}

class DateProvider extends StatefulWidget {
  const DateProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<DateProvider> createState() => _DateProviderState();
}

class _DateProviderState extends State<DateProvider> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return DateState(
      date: date,
      changeMonth: (isNext) {
        final value = isNext ? 1 : -1;
        final newDate = DateTime(date.year, date.month + value, date.day);

        setState(() {
          date = newDate;
        });
      },
      child: widget.child,
    );
  }
}

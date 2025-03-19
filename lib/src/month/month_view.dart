import 'package:flutter/material.dart';
import 'package:my_money/src/state/date_state.dart';

import 'package:my_money/src/util/date_util.dart';

class MonthView extends StatelessWidget {
  const MonthView({super.key});

  @override
  Widget build(BuildContext context) {
    final dateProvider = DateState.of(context);
    final selectedDate = dateProvider.date;

    return Card(
      margin: const EdgeInsets.all(16),
      child: ListTile(
        trailing: IconButton(
          onPressed: () {
            dateProvider.changeMonth(true);
          },
          icon: const Icon(
            Icons.chevron_right,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            dateProvider.changeMonth(false);
          },
          icon: const Icon(
            Icons.chevron_left,
          ),
        ),
        title: Text(
          selectedDate.format1(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

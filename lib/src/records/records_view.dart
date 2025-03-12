import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/src/records/components/detail_record_view.dart';
import 'package:my_money/src/state/date_state.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/list_util.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    final dateProvider = DateState.of(context);
    final selectedDate = dateProvider.date;
    final format = DateFormat('yyyy-MM-dd');
    final records = RecordState.of(context).filterByMonth;

    final groupedRecord = records.groupBy((value) {
      return format.format(value.time);
    });

    return Column(
      children: [
        Card(
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
              DateFormat("MMM yyyy").format(selectedDate),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...groupedRecord.entries.map(
                (item) => DetailRecordView(
                  list: item.value,
                  groupedTime: format.parse(item.key),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

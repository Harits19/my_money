import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/src/records/components/detail_record_view.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/list_util.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    final format = DateFormat();
    final records = RecordState.of(context).filterByMonth;

    final groupedRecord = records.groupBy((value) {
      return format.format(value.time);
    });

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...groupedRecord.entries.map(
            (item) => DetailRecordView(
              list: item.value,
              groupedTime: format.parse(item.key),
            ),
          ),
          Opacity(opacity: 0, child: FloatingActionButton(onPressed: () {}))
        ],
      ),
    );
  }
}

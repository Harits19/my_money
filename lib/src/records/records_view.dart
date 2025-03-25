import 'package:flutter/material.dart';
import 'package:my_money/src/components/dummy_floating_button.dart';
import 'package:my_money/src/records/components/detail_record_view.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/date_util.dart';
import 'package:my_money/src/util/list_util.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    final records = RecordState.of(context).filterByMonth;

    final groupedRecord = records.groupBy((value) {
      return  value.time.format1();
    });

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...groupedRecord.entries.map(
            (item) => DetailRecordView(
              list: item.value,
              groupedTime: item.key,
            ),
          ),
          const DummyFloatingButton(),
        ],
      ),
    );
  }
}

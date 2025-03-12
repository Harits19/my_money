import 'package:flutter/material.dart';
import 'package:my_money/src/records/components/detail_record_view.dart';
import 'package:my_money/src/state/record_state/state.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    final records = RecordState.of(context).records;
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...records.map((item) =>  DetailRecordView(
                    item: item,
                  ))
            ],
          ),
        )
      ],
    );
  }
}

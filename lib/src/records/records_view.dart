import 'package:flutter/material.dart';
import 'package:my_money/src/components/height.dart';
import 'package:my_money/src/dashboard/component/date_view.dart';
import 'package:my_money/src/records/components/detail_record_view.dart';
import 'package:my_money/src/dashboard/component/info_view.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...[1, 1, 1, 1].map((item) => const DetailRecordView())
            ],
          ),
        )
      ],
    );
  }
}

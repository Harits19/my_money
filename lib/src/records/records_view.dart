import 'package:flutter/material.dart';
import 'package:my_money/src/records/components/date_view.dart';
import 'package:my_money/src/records/components/detail_record_view.dart';
import 'package:my_money/src/records/components/info_view.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DateView(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InfoView(
              title: "EXPENSE",
              color: Colors.red,
              total: 10000000,
            ),
            InfoView(
              title: "INCOME",
              color: Colors.green,
              total: 10000000,
            ),
            InfoView(
              title: "TOTAL",
              color: Colors.red,
              total: 10000000,
            ),
          ],
        ),
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

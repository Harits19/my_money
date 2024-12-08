import 'package:flutter/material.dart';
import 'package:my_money/src/components/height.dart';
import 'package:my_money/src/records/components/date_view.dart';
import 'package:my_money/src/records/components/detail_record_view.dart';
import 'package:my_money/src/records/components/info_view.dart';

class RecordsView extends StatelessWidget {
  const RecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Height(8),
        const DateView(),
        const Height(8),
        const InfoView(
          title: "EXPENSE",
          color: Colors.red,
          total: 10000000,
        ),
        const Height(8),
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

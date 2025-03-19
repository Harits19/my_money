import 'package:flutter/material.dart';
import 'package:my_money/src/components/detail_record_item_view.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/util/date_util.dart';

class DetailRecordView extends StatelessWidget {
  const DetailRecordView({
    super.key,
    required this.list,
    required this.groupedTime,
  });

  final List<RecordModel> list;
  final DateTime groupedTime;

  @override
  Widget build(BuildContext context) {
    final date = groupedTime;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        clipBehavior: Clip.antiAlias,
        shape: Border.all(
          color: Colors.transparent,
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            date.format2(),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        children: list.map((item) {
          return DetailRecordItemView(
            item: item,
          );
        }).toList(),
      ),
    );
  }
}

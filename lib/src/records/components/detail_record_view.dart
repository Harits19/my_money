import 'package:flutter/material.dart';
import 'package:my_money/src/records/components/detail_record_dialog.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/util/currency_util.dart';
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
            DateUtil.format2(date),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        children: list.map((item) {
          return ListTile(
            onTap: () {
              DetailRecordDialog.show(context);
            },
            title: Text(
              CurrencyUtil.toIdr(item.amount),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text("${item.category} - ${item.account}"),
          );
        }).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_money/src/records/components/detail_record_dialog.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/util/currency_util.dart';
import 'package:my_money/src/util/date_util.dart';

class DetailRecordView extends StatelessWidget {
  const DetailRecordView({
    super.key,
    required this.item,
  });

  final RecordModel item;

  @override
  Widget build(BuildContext context) {
    final idrFormat = CurrencyUtil.toIdr(item.amount);
    final date = item.time;

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
        children: [1, 1, 1, 1].map((item) {
          return ListTile(
            onTap: () {
              DetailRecordDialog.show(context);
            },
            title: Text(idrFormat),
            subtitle: Text("${this.item.category} - ${this.item.account}"),
          );
        }).toList(),
      ),
    );
  }
}

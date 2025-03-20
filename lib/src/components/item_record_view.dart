import 'package:flutter/material.dart';
import 'package:my_money/src/components/detail_record_item_view.dart';
import 'package:my_money/src/state/record_state/model.dart';

class ItemRecordView extends StatelessWidget {
  const ItemRecordView({
    super.key,
    required this.item,
  });

  final List<RecordModel> item;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ...item.map(
            (item) => DetailRecordItemView(item: item),
          ),
        ],
      ),
    );
  }
}

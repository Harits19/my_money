import 'package:flutter/material.dart';
import 'package:my_money/src/components/item_record_view.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/state/record_state/state.dart';

class ListRecordView extends StatelessWidget {
  const ListRecordView({
    super.key,
    required this.valueKey,
    required this.name,
  });
  final String Function(RecordModel item) valueKey;
  final String name;

  @override
  Widget build(BuildContext context) {
    final recordState = RecordState.of(context);
    final list = recordState.filterByKey(key: name, modelKey: valueKey);
    return Scaffold(
      body: SafeArea(
        child: ItemRecordView(
          item: list,
        ),
      ),
    );
  }
}

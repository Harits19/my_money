import 'package:flutter/material.dart';
import 'package:my_money/src/add/add_view.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/state/record_state/state.dart';
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
    final recordState = RecordState.of(context);

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
          return ListTile(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Are you sure to delete this Record?"),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        recordState.deleteRecord(item);
                        Navigator.pop(context);
                      },
                      child: const Text("Yes"),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    )
                  ],
                ),
              );
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddView(
                    initialValue: item,
                  ),
                ),
              );
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

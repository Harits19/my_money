import 'package:flutter/material.dart';
import 'package:my_money/src/add/add_view.dart';
import 'package:my_money/src/state/record_state/model.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/num_util.dart';

class DetailRecordItemView extends StatelessWidget {
  const DetailRecordItemView({super.key, required this.item});

  final RecordModel item;

  @override
  Widget build(BuildContext context) {
    final recordState = RecordState.of(context);
    return ListTile(
      onLongPress: () async {
        final isConfirmDelete = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure to delete this Record?"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("Yes"),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text("Cancel"),
              )
            ],
          ),
        );
        if (isConfirmDelete != true) return;
        recordState.deleteRecord(item);
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
        item.amount.toIdr(),
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text("${item.category} - ${item.account}"),
    );
  }
}

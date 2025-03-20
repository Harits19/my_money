import 'package:flutter/material.dart';
import 'package:my_money/src/components/height.dart';
import 'package:my_money/src/util/num_util.dart';
import 'package:my_money/src/util/date_util.dart';

class DetailRecordDialog extends StatelessWidget {
  const DetailRecordDialog({super.key});

  static show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const DetailRecordDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final idr = 2000.toIdr();
    final formattedDate = DateTime.now().format3();
    const account = "Cash";

    handleDelete() async {
      final isConfirmDelete = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Are you sure"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("No"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ) ??
          false;

      if (!context.mounted) return;
      if (isConfirmDelete) {
        Navigator.pop(context);
      }
    }

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
                const Spacer(),
                IconButton(
                  onPressed: handleDelete,
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const Height(16),
            const Text(
              "EXPENSE",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Height(8),
            Text(
              idr,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const Height(8),
            Text(
              formattedDate,
            ),
            const Height(8),
            const Text(
              "Account : $account",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Height(8),
            const Text(
              "Category : Food",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Height(8),
            const Text(
              "Jajan alfamart",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const Height(8),
          ],
        ),
      ),
    );
  }
}

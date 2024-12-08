import 'package:flutter/material.dart';
import 'package:my_money/src/components/height.dart';
import 'package:my_money/src/components/width.dart';
import 'package:my_money/src/model/view_mode.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  static Future<ViewMode?> show(BuildContext context) {
    return showDialog<ViewMode>(
      context: context,
      builder: (context) {
        return const FilterDialog();
      },
    );
  }

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  ViewMode viewMode = ViewMode.monthly;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Display Option",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const Height(24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "View Mode : ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Width(12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...ViewMode.values.map((item) {
                      final isSelected = item == viewMode;
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: InkWell(
                          onTap: () {
                            viewMode = item;
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              Visibility(
                                visible: isSelected,
                                child: const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(Icons.check)),
                              ),
                              Opacity(
                                opacity: isSelected ? 1 : 0.3,
                                child: Text(item.text),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                )
              ],
            ),
            const Height(24),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, viewMode);
                },
                child: const Text("Confirm"))
          ],
        ),
      ),
    );
  }
}

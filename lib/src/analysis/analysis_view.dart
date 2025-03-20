import 'package:flutter/material.dart';
import 'package:my_money/src/components/item_record_view.dart';
import 'package:my_money/src/list_record/list_record_view.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/num_util.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    final analysis = RecordState.of(context).analysisResult;
    final totalCurrentMonth = RecordState.of(context).totalCurrentMonth;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...analysis.entries.map(
            (type) {
              return Card(
                borderOnForeground: false,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      type.key.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...type.value.item1.entries.map(
                        (e) {
                          final total = e.value;
                          final progressValue = total / totalCurrentMonth;
                          final percent = progressValue.toPercent();

                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ListRecordView(
                                    valueKey: type.value.item2,
                                    name: e.key,
                                  ),
                                ),
                              );
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.key),
                                Text(
                                  total.toIdr(),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: progressValue,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(percent)
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/currency_util.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    final analysis = RecordState.of(context).analysisResult;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ...analysis.entries.map(
            (e) => Card(
              child: ListTile(
                title: Text(
                  e.key.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  children: [
                    ...e.value.entries.map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.key),
                          Text(
                            e.value.toIdr(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

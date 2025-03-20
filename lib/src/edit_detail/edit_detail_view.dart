import 'package:flutter/material.dart';
import 'package:my_money/src/state/record_state/state.dart';

class EditDetailView extends StatelessWidget {
  const EditDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final analysis = RecordState.of(context).analysisResult;
    return Column(
      children: [
        const SizedBox(
          height: 32,
        ),
        ...analysis.entries.map(
          (e) {
            final keys = e.value.item1.keys.toList();
            return Column(
              children: [
                ...keys.map(
                  (e) => Column(
                    children: [
                      ListTile(
                        title: Text(e),
                      ),
                      const Divider(),
                    ],
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }
}

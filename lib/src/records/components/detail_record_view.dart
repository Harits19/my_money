import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/src/util/currency_util.dart';

class DetailRecordView extends StatelessWidget {
  const DetailRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    final idrFormat = CurrencyUtil.toIdr(20000);
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Sep 09, Monday",
          ),
          const Divider(),
          ...[
            1,
            1,
            1,
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Food",
                            ),
                            Text('Cash')
                          ],
                        ),
                      ),
                      Text(
                        idrFormat,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

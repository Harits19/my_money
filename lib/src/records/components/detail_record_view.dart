import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_money/src/records/components/detail_record_dialog.dart';
import 'package:my_money/src/util/currency_util.dart';
import 'package:my_money/src/util/date_util.dart';

class DetailRecordView extends StatelessWidget {
  const DetailRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    final idrFormat = CurrencyUtil.toIdr(20000);
    final date = DateTime.now();

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            DateUtil.format2(date),
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
                  InkWell(
                    onTap: () {
                      DetailRecordDialog.show(context);
                    },
                    child: Row(
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailRecordView extends StatelessWidget {
  const DetailRecordView({super.key});

  @override
  Widget build(BuildContext context) {
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
            (item) => const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Food",
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.monetization_on_outlined,
                                ),
                                Text('Cash')
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Rp20000",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

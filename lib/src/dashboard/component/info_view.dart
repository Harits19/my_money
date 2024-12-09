import 'package:flutter/material.dart';
import 'package:my_money/src/util/currency_util.dart';

class InfoView extends StatelessWidget {
  const InfoView({
    super.key,
    required this.title,
    this.total,
    required this.color,
  });

  final String title;
  final int? total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final idrFormat = CurrencyUtil.toIdr(total);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            idrFormat,
            style: TextStyle(
              color: color,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}

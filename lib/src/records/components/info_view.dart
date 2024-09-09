import 'package:flutter/material.dart';

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
    return Column(
      children: [
        Text(
          title,
        ),
        Text(
          "Rp${total ?? 0}",
          style: TextStyle(
            color: color,
          ),
        )
      ],
    );
  }
}

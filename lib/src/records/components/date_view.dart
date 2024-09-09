import 'package:flutter/material.dart';

class DateView extends StatelessWidget {
  const DateView({super.key});

  @override
  Widget build(BuildContext context) {
    const double size = 32;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.chevron_left,
            size: size,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        const Text(
          "September, 2024",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.chevron_right,
            size: size,
          ),
        )
      ],
    );
  }
}

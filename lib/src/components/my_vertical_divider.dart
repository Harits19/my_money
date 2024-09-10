import 'package:flutter/material.dart';

class MyVerticalDivider extends StatelessWidget {
  const MyVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Theme.of(context).dividerColor,
    );
  }
}

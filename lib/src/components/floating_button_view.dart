import 'package:flutter/material.dart';
import 'package:my_money/src/add/add_view.dart';

class FloatingButtonView extends StatelessWidget {
  const FloatingButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddView()),
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}

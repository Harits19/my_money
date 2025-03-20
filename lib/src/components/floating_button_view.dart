import 'package:flutter/material.dart';
import 'package:my_money/src/add/add_view.dart';

class FloatingButtonView extends StatelessWidget {
  const FloatingButtonView({
    super.key,
    this.heroTag,
  });

  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
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

import 'package:flutter/material.dart';
import 'package:my_money/src/components/floating_button_view.dart';

class DummyFloatingButton extends StatelessWidget {
  const DummyFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 24),
      child: Opacity(
        opacity: 0,
        child: IgnorePointer(
          child: FloatingButtonView(),
        ),
      ),
    );
  }
}

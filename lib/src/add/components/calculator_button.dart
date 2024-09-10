import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  const CalculatorButton(
      {super.key,
      required this.onPressed,
      this.highlightColor = false,
      required this.text});

  final VoidCallback onPressed;
  final bool highlightColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: highlightColor ? Theme.of(context).splashColor : null,
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}

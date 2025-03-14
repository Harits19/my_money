import 'package:flutter/material.dart';

class MyTextField extends TextField {
  MyTextField({
    InputDecoration? decoration,
    super.key,
    super.keyboardType,
    super.maxLines,
    super.onChanged,
  }) : super(
          decoration: decoration?.copyWith(
            border: const OutlineInputBorder(),
          ),
        );
}

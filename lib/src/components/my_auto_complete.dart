import 'package:flutter/material.dart';
import 'package:my_money/src/util/string_util.dart';

class MyAutoComplete extends StatelessWidget {
  const MyAutoComplete({
    super.key,
    required this.options,
    this.onChanged,
    this.decoration,
    this.maxLines,
    this.textInputType,
    this.validator,
    this.initialValue,
  });

  final List<String> options;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final TextInputType? textInputType;
  final int? maxLines;
  final FormFieldValidator<String>? validator;
  final TextEditingValue? initialValue;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsViewOpenDirection: OptionsViewOpenDirection.down,
      optionsBuilder: (textEditingValue) {
        final value = textEditingValue.text;
        if (value.isNullEmpty) {
          return options;
        }
        return options.search(value);
      },
      initialValue: initialValue,
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextFormField(
          keyboardType: textInputType,
          controller: controller,
          onChanged: onChanged,
          focusNode: focusNode,
          decoration: decoration,
          validator: validator,
          maxLines: maxLines,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
      onSelected: (String selection) {
        onChanged?.call(selection);
      },
    );
  }
}

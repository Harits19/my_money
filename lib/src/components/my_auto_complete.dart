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
  });

  final List<String> options;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final TextInputType? textInputType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsViewOpenDirection: OptionsViewOpenDirection.down,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return options;
        }
        return options.search(textEditingValue.text);
      },
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) =>
          TextFormField(
        keyboardType: textInputType,
        onChanged: onChanged,
        controller: controller,
        focusNode: focusNode,
        decoration: decoration,
        maxLines: maxLines,
        onFieldSubmitted: (String value) {
          onFieldSubmitted();
        },
      ),
      onSelected: (String selection) {
        onChanged?.call(selection);
      },
    );
  }
}

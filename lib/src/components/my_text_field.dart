import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/util/string_util.dart';

enum MyTextFieldFormat { currency, normal }

class MyTextFormField extends StatefulWidget {
  const MyTextFormField({
    super.key,
    this.keyboardType,
    this.maxLines,
    this.onChanged,
    this.decoration,
    this.readOnly = false,
    this.enabled,
    this.onTap,
    this.myTextFieldType = MyTextFieldFormat.normal,
    this.validator,
    this.initialValue,
    this.required = false,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
  });

  final TextInputType? keyboardType;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final bool readOnly;
  final bool? enabled;
  final VoidCallback? onTap;
  final MyTextFieldFormat myTextFieldType;
  final String? Function(String? value)? validator;
  final String? initialValue;
  final bool required;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  String? get initialValue => widget.initialValue;

  bool get isCurrencyFormat {
    return widget.myTextFieldType == MyTextFieldFormat.currency;
  }

  String? getInitialValue() {
    if (initialValue == null) return null;
    if (isCurrencyFormat) {
      return formatValue(initialValue!);
    }

    return initialValue;
  }

  late final controller = widget.controller ??
      TextEditingController(
        text: getInitialValue(),
      );

  String getNumberOnly(String value) {
    if (value.isEmpty) return '';

    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  String formatValue(String value) {
    final numericText = getNumberOnly(value);
    if (numericText.isEmpty) return '';

    return NumberFormat.currency(
      locale: 'id_ID',
      decimalDigits: 0,
      symbol: '',
    ).format(int.tryParse(numericText));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: widget.keyboardType,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: (value) {
        if (widget.required && value.isNullEmpty) {
          return "Required";
        }
        return widget.validator?.call(value);
      },
      maxLines: widget.maxLines,
      onChanged: (value) {
        myLog.i("newValue $value");

        if (isCurrencyFormat) {
          final formattedValue = formatValue(value);

          myLog.i("formatted value $formattedValue");

          controller.value = TextEditingValue(
            text: formattedValue,
            selection: TextSelection.collapsed(offset: formattedValue.length),
          );

          final rawValue = getNumberOnly(value);

          myLog.i("number only $rawValue");

          widget.onChanged?.call(rawValue);
          return;
        }

        widget.onChanged?.call(value);
      },
      decoration: widget.decoration,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      onTap: widget.onTap,
    );
  }
}

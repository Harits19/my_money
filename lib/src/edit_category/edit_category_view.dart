import 'package:flutter/material.dart';
import 'package:my_money/src/components/base_input_view.dart';
import 'package:my_money/src/components/my_text_field.dart';
import 'package:my_money/src/state/record_state/state.dart';

class EditCategoryView extends StatefulWidget {
  const EditCategoryView({
    super.key,
    required this.oldCategory,
  });

  final String oldCategory;

  @override
  State<EditCategoryView> createState() => _EditCategoryViewState();
}

class _EditCategoryViewState extends State<EditCategoryView> {
  final _form = GlobalKey<FormState>();

  late String category = widget.oldCategory;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: BaseInputView(
        title: "Edit Category",
        body: [
          MyTextFormField(
            required: true,
            initialValue: category,
            decoration: const InputDecoration(
              labelText: "New Category",
            ),
            onChanged: (value) {
              category = value;
              setState(() {});
            },
          )
        ],
        onSave: () {
          if (!_form.currentState!.validate()) return;
          final updateCategory = RecordState.of(context).updateCategory;

          updateCategory(
            newCategory: category,
            oldCategory: widget.oldCategory,
          );

          Navigator.pop(context);
        },
      ),
    );
  }
}

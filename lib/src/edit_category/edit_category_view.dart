import 'package:flutter/material.dart';
import 'package:my_money/src/components/my_text_field.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/state/category_state/state.dart';
import 'package:my_money/src/util/string_util.dart';

class EditCategoryView extends StatefulWidget {
  const EditCategoryView({
    super.key,
    required this.item,
  });

  final CategoryModel item;

  @override
  State<EditCategoryView> createState() => _EditCategoryViewState();
}

class _EditCategoryViewState extends State<EditCategoryView> {
  final formKey = GlobalKey<FormState>();

  late var name = widget.item.name;
  late var budget = widget.item.budget;

  @override
  Widget build(BuildContext context) {
    String? defaultValidator(String? value) {
      if (value.isNullEmpty) {
        return 'Required';
      }
      return null;
    }

    final children = [
      MyTextFormField(
        validator: defaultValidator,
        initialValue: widget.item.name,
        decoration: const InputDecoration(
          labelText: "Name",
        ),
        onChanged: (value) {
          name = value;
          setState(() {});
        },
      ),
      MyTextFormField(
        validator: defaultValidator,
        initialValue: widget.item.budget.toString(),
        keyboardType: TextInputType.number,
        myTextFieldType: MyTextFieldFormat.currency,
        onChanged: (value) {
          budget = int.tryParse(value) ?? 0;
          setState(() {});
        },
        decoration: const InputDecoration(
          labelText: "Budget",
        ),
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: children.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemBuilder: (context, index) => children[index],
                ),
              ),
              const Divider(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    myLog.i("start save");
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    myLog.i("after validation");
                    final newValue = CategoryModel(
                      name: name,
                      budget: budget,
                      id: widget.item.id,
                    );

                    myLog.i("category new value ${newValue.toJson()}");

                    final categoryState = CategoryState.of(context);
                    categoryState.updateCategory(newValue);
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

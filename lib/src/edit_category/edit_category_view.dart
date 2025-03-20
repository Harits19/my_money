import 'package:flutter/material.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/state/category_state/state.dart';
import 'package:my_money/src/util/string_util.dart';

class EditCategoryView extends StatelessWidget {
  const EditCategoryView({
    super.key,
    required this.item,
  });

  final CategoryModel item;

  @override
  Widget build(BuildContext context) {
    myLog.i("rebuild EditCategoryView");

    String? defaultValidator(String? value) {
      if (value.isNullEmpty) {
        return 'Required';
      }
      return null;
    }

    final formKey = GlobalKey<FormState>();
    final name = TextEditingController(
      text: item.name,
    );
    final budget = TextEditingController(
      text: item.budget.toString(),
    );

    final children = [
      TextFormField(
        validator: defaultValidator,
        keyboardType: TextInputType.number,
        controller: name,
        decoration: const InputDecoration(
          labelText: "Name",
        ),
      ),
      TextFormField(
        validator: defaultValidator,
        controller: budget,
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
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  final newValue = CategoryModel(
                    name: name.text,
                    budget: int.parse(
                      budget.text,
                    ),
                    id: item.id,
                  );

                  myLog.i("category new value ${newValue.toJson()}");

                  final categoryState = CategoryState.of(context);
                  categoryState.updateCategory(newValue);
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_money/src/edit_category/edit_category_view.dart';
import 'package:my_money/src/state/category_state/state.dart';

class EditDetailView extends StatelessWidget {
  const EditDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final analysis = CategoryState.of(context).categories;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          ...analysis.map(
            (e) => Card(
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditCategoryView(
                        item: e,
                      ),
                    ),
                  );
                },
                title: Text(e.name),
              ),
            ),
          )
        ],
      ),
    );
  }
}

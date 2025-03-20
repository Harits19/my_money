part of 'state.dart';

class CategoryProvider extends StatefulWidget {
  const CategoryProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<CategoryProvider> createState() => _CategoryProviderState();
}

class _CategoryProviderState extends State<CategoryProvider> {
  late final recordState = RecordState.of(context);
  late List<CategoryModel> categories = recordState.categories
      .map(
        (e) => CategoryModel(name: e, budget: 0, id: uniqueId()),
      )
      .toList();

  void updateCategory(CategoryModel newValue) {
    CategoryModel? oldValue;

    final newArray = [...categories];

    for (final entry in newArray.asMap().entries) {
      final item = entry.value;
      if (item.id != newValue.id) continue;
      oldValue = item;
      newArray[entry.key] = newValue;
    }

    if (oldValue == null) return;

    categories = newArray;
    setState(() {});
    recordState.updateCategory(
      newCategory: newValue,
      oldCategory: oldValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CategoryState(
      updateCategory: updateCategory,
      categories: categories,
      child: widget.child,
    );
  }
}

part of 'state.dart';

class CategoryProvider extends StatefulWidget {
  const CategoryProvider({
    super.key,
    required this.child,
    required this.categories,
  });

  final Widget child;
  final List<String> categories;

  @override
  State<CategoryProvider> createState() => _CategoryProviderState();
}

class _CategoryProviderState extends State<CategoryProvider> {
  final localStorage = LocalStorageService(key: LocalStorageKey.categories);
  late List<CategoryModel> categories = widget.categories
      .map(
        (e) => CategoryModel(name: e, budget: 0, id: uniqueId()),
      )
      .toList();

  void updateLocalStorage() {
    localStorage.setValue(categories.toJsonList());
  }

  void getLocalStorage() {
    final result = localStorage.getValue();

    if (result is! List<dynamic>) {
      updateLocalStorage();
      return;
    }

    final parsedResult = CategoryModel.fromJsonList(result);
    categories = parsedResult;
    setState(() {});
  }

  void updateCategory(CategoryModel newValue) {
    final recordState = RecordState.of(context);
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
    updateLocalStorage();
  }

  @override
  void initState() {
    super.initState();
    getLocalStorage();
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

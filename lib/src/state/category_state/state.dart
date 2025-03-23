import 'package:flutter/cupertino.dart';
import 'package:my_money/src/model/json.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/services/local_storage_service.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/string_util.dart';

part 'provider.dart';
part 'model.dart';

class CategoryState extends InheritedWidget {
  const CategoryState({
    super.key,
    required super.child,
    required this.categories,
    required this.updateCategory,
  });

  final List<CategoryModel> categories;
  final ValueChanged<CategoryModel> updateCategory;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static CategoryState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CategoryState>();
  }

  static CategoryState of(BuildContext context) {
    final CategoryState? result = maybeOf(context);
    assert(result != null, 'No State found in context');
    return result!;
  }
}

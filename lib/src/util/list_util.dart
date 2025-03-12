class Person {
  String name;
  String category;

  Person(this.name, this.category);
}

extension ListExtension<T> on List<T> {
  Map<String, List<T>> groupBy(String Function(T value) getKey) {
    final Map<String, List<T>> groupedList = {};

    for (final item in this) {
      final key = getKey(item);
      final isExist = groupedList[key] != null;

      if (isExist) {
        groupedList[key]?.add(item);
      } else {
        groupedList[key] = [item];
      }
    }

    return groupedList;
  }
}

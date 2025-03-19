extension ListStringExtension on List<String> {
  List<String> search(String value) {
    return where((String option) {
      return option.toLowerCase().contains(value.toLowerCase());
    }).toList();
  }
}

extension StringNullExtension on String? {
  bool get isNullEmpty {
    return this?.isEmpty ?? true;
  }
}

var index = 0;

String uniqueId() {
  index++;
  return index.toString();
}

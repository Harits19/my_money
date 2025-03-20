abstract class JsonModel {
  Map<String, dynamic> toJson();
}

extension JsonModelExtension<T extends JsonModel> on List<T> {
  List<Map<String, dynamic>> toJsonList() {
    return map(
      (e) => e.toJson(),
    ).toList();
  }
}

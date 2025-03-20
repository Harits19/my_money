part of 'state.dart';

class CategoryModel extends JsonModel {
  final String name;
  final int budget;
  final String id;

  CategoryModel({
    required this.name,
    required this.budget,
    required this.id,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "budget": budget,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      budget: json['budget'],
    );
  }
}

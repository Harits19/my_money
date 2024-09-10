import 'package:flutter/material.dart';

class AddTypeDetailModel {
  final String title;
  final String detail;
  final IconData icon;

  AddTypeDetailModel({
    required this.title,
    required this.detail,
    required this.icon,
  });
}

class AddTypeModel {
  final String title;
  final List<AddTypeDetailModel> details;

  AddTypeModel({
    required this.details,
    required this.title,
  });
}

class CategoryModel {
  final String name;
  final IconData icon;

  CategoryModel({required this.name, required this.icon});
}

class AccountTypeModel {
  final String name;
  final IconData icon;
  final int? total;

  AccountTypeModel({
    required this.name,
    required this.icon,
    this.total = 0,
  });
}

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

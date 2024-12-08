import 'package:flutter/material.dart';
import 'package:my_money/src/add/add_model.dart';

final incomeExpenseDetail = [
  AddTypeDetailModel(
    title: "Account",
    detail: "Account",
    icon: Icons.wallet,
  ),
  AddTypeDetailModel(
    title: "Category",
    detail: "Category",
    icon: Icons.label,
  ),
];

final List<AddTypeDetailModel> addTypeDetailModel = [
  AddTypeDetailModel(
    title: "From",
    detail: "Account",
    icon: Icons.wallet,
  ),
  AddTypeDetailModel(
    title: "To",
    detail: "Account",
    icon: Icons.wallet,
  )
];
final accountTypeList = [
  AccountTypeModel(
    name: 'Card',
    icon: Icons.wallet,
  ),
  AccountTypeModel(
    name: 'Cash',
    icon: Icons.wallet,
  ),
  AccountTypeModel(
    name: 'Savings',
    icon: Icons.wallet,
  )
];

final List<CategoryModel> categoryList = [
  CategoryModel(
    name: "Awards",
    icon: Icons.money,
  ),
  CategoryModel(
    name: "Coupons",
    icon: Icons.money,
  ),
  CategoryModel(
    name: "Grants",
    icon: Icons.money,
  ),
  CategoryModel(
    name: "Lottery",
    icon: Icons.money,
  ),
  CategoryModel(
    name: "Refunds",
    icon: Icons.money,
  ),
  CategoryModel(
    name: "Rental",
    icon: Icons.money,
  ),
  CategoryModel(
    name: "Salary",
    icon: Icons.money,
  ),
  CategoryModel(
    name: "Sale",
    icon: Icons.money,
  ),
];

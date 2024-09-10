import 'package:flutter/material.dart';
import 'package:my_money/src/accounts/accounts_view.dart';
import 'package:my_money/src/analysis/analysis_view.dart';
import 'package:my_money/src/budgets/budgets_view.dart';
import 'package:my_money/src/categories/categories_view.dart';
import 'package:my_money/src/dashboard/dashboard_model.dart';
import 'package:my_money/src/records/records_view.dart';

final dashboardMenus = <DashboardModel>[
  DashboardModel(
    bottomNavigationBarItem: const BottomNavigationBarItem(
      icon: Icon(
        Icons.list,
      ),
      label: 'Records',
    ),
    view: const RecordsView(),
  ),
  DashboardModel(
    bottomNavigationBarItem: const BottomNavigationBarItem(
      icon: Icon(
        Icons.analytics,
      ),
      label: 'Analysis',
    ),
    view: const AnalysisView(),
  ),
  DashboardModel(
    bottomNavigationBarItem: const BottomNavigationBarItem(
      icon: Icon(
        Icons.calculate,
      ),
      label: 'Budgets',
    ),
    view: const BudgetsView(),
  ),
  DashboardModel(
    bottomNavigationBarItem: const BottomNavigationBarItem(
      icon: Icon(
        Icons.wallet,
      ),
      label: 'Accounts',
    ),
    view: const AccountView(),
  ),
  DashboardModel(
    bottomNavigationBarItem: const BottomNavigationBarItem(
      icon: Icon(
        Icons.label,
      ),
      label: 'Categories',
    ),
    view: const CategoriesView(),
  )
];

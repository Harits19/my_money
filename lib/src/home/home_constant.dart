import 'package:flutter/material.dart';
import 'package:my_money/src/analysis/analysis_view.dart';
import 'package:my_money/src/records/records_view.dart';
import 'package:my_money/src/setting/setting_view.dart';

class NavigationBarModel {
  final NavigationDestination destination;

  final Widget view;

  NavigationBarModel({required this.destination, required this.view});
}

final listMenu = <NavigationBarModel>[
  NavigationBarModel(
    destination: const NavigationDestination(
      icon: Icon(Icons.home),
      label: 'Records',
    ),
    view: const RecordsView(),
  ),
  NavigationBarModel(
    destination: const NavigationDestination(
      icon: Icon(Icons.analytics),
      label: 'Analysis',
    ),
    view: const AnalysisView(),
  ),
  NavigationBarModel(
    destination: const NavigationDestination(
      icon: Icon(Icons.settings),
      label: 'Setting',
    ),
    view: const SettingView(),
  ),
];

import 'package:flutter/material.dart';
import 'package:my_money/src/add/add_view.dart';
import 'package:my_money/src/analysis/analysis_view.dart';
import 'package:my_money/src/app_bar/app_bar_view.dart';
import 'package:my_money/src/components/floating_button_view.dart';
import 'package:my_money/src/category/category_view.dart';
import 'package:my_money/src/home/home_constant.dart';
import 'package:my_money/src/records/records_view.dart';
import 'package:my_money/src/setting/setting_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedBottomBar = 0;

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      floatingActionButton: const FloatingButtonView(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedBottomBar,
        onDestinationSelected: (int index) {
          selectedBottomBar = index;
          setState(() {});
        },
        destinations: listMenu.map((item) {
          return item.destination;
        }).toList(),
      ),
      body: CustomScrollView(
        slivers: [
          const AppBarView(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return listMenu[selectedBottomBar].view;
              },
              childCount: 1, // Total number of list items
            ),
          ),
        ],
      ),
    );
  }
}

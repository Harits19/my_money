import 'package:flutter/material.dart';
import 'package:my_money/src/add/add_view.dart';
import 'package:my_money/src/components/height.dart';
import 'package:my_money/src/dashboard/dashboard_constan.dart';
import 'package:my_money/src/dashboard/component/date_view.dart';
import 'package:my_money/src/dashboard/component/info_view.dart';
import 'package:my_money/src/search/search_view.dart';
import 'package:my_money/src/state/theme_state.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int selectedBotNav = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uangku"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.restorablePushNamed(context, SearchView.routeName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.restorablePushNamed(context, AddView.routeName);
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedBotNav,
        onDestinationSelected: (index) {
          selectedBotNav = index;
          setState(() {});
        },
        destinations:
            dashboardMenus.map((item) => item.bottomNavigationBarItem).toList(),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...ThemeMode.values.map(
                  (item) => Row(
                    children: [
                      Radio(
                        value: item,
                        groupValue: ThemeState.of(context).themeMode,
                        onChanged: ThemeState.of(context).setThemeMode,
                      ),
                      Text(
                        item.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Height(8),
          const DateView(),
          const Height(8),
          const InfoView(
            title: "EXPENSE",
            color: Colors.red,
            total: 10000000,
          ),
          const Height(8),
          Expanded(
            child: IndexedStack(
              index: selectedBotNav,
              children: dashboardMenus.map((item) => item.view).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

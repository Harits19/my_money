import 'package:flutter/material.dart';
import 'package:my_money/src/add/add_view.dart';
import 'package:my_money/src/dashboard/dashboard_constan.dart';
import 'package:my_money/src/search/search_view.dart';

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
        title: const Text("MyMoney"),
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryIconTheme.color,
        unselectedItemColor: Theme.of(context).disabledColor,
        showUnselectedLabels: true,
        currentIndex: selectedBotNav,
        onTap: (index) {
          selectedBotNav = index;
          setState(() {});
        },
        items:
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
                        groupValue: ThemeMode.dark,
                        onChanged: (value) {},
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
      body: IndexedStack(
        index: selectedBotNav,
        children: dashboardMenus.map((item) => item.view).toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_money/src/accounts/accounts_view.dart';
import 'package:my_money/src/add/add_view.dart';
import 'package:my_money/src/analysis/analysis_view.dart';
import 'package:my_money/src/budgets/budgets_view.dart';
import 'package:my_money/src/categories/categories_view.dart';
import 'package:my_money/src/dashboard/dashboard_model.dart';
import 'package:my_money/src/records/records_view.dart';
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
    final menus = <DashboardModel>[
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
        items: menus.map((item) => item.bottomNavigationBarItem).toList(),
      ),
      drawer: const Drawer(),
      body: IndexedStack(
        index: selectedBotNav,
        children: menus.map((item) => item.view).toList(),
      ),
    );
  }
}

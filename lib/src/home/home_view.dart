import 'package:flutter/material.dart';
import 'package:my_money/src/add/add_view.dart';
import 'package:my_money/src/home/home_constant.dart';
import 'package:my_money/src/records/records_view.dart';
import 'package:my_money/src/search/search_view.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/services/notification_service.dart';
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
          icon: Icon(Icons.category),
          label: 'Category',
        ),
        view: const Placeholder(),
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
      appBar: AppBar(
        title: const Text("My Money"),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchView(),
                ),
              );
              if (result is! String) return;

              myLog.i("search result $result");
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {
              NotificationService.scheduleAllTime();
            },
            icon: const Icon(Icons.notification_add),
          ),
          IconButton(
            onPressed: () {
              NotificationService.showNotification(
                title: "Test Notification",
                body: "This is a simple notification",
              );
            },
            icon: const Icon(Icons.notification_add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddView()),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
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
      body: SafeArea(child: listMenu[selectedBottomBar].view),
    );
  }
}

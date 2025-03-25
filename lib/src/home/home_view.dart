import 'package:flutter/material.dart';
import 'package:my_money/src/app_bar/app_bar_view.dart';
import 'package:my_money/src/components/floating_button_view.dart';
import 'package:my_money/src/home/home_constant.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedBottomBar = 0;

  @override
  Widget build(BuildContext context) {
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

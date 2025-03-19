import 'package:flutter/material.dart';
import 'package:my_money/src/month/month_view.dart';
import 'package:my_money/src/search/search_view.dart';

class AppBarView extends StatelessWidget {
  const AppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120, // Height when expanded
      pinned: true, // AppBar is pinned when collapsed
      title: const Text("UangKu"),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(32),
        child: MonthView(),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchView(),
              ),
            );
          },
          icon: const Icon(Icons.search),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(32);
}

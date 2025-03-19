import 'package:flutter/material.dart';
import 'package:my_money/src/month/month_view.dart';
import 'package:my_money/src/search/search_view.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:my_money/src/util/currency_util.dart';

class AppBarView extends StatelessWidget {
  const AppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    const double height1 = 32;
    const double height = 120;
    const double height2 = 16;
    const double height3 = 32;

    final recordState = RecordState.of(context);
    return SliverAppBar(
      expandedHeight:
          height + height1 + height2 + height3, // Height when expanded
      collapsedHeight: height + height1 - kToolbarHeight + height2,
      pinned: true, // AppBar is pinned when collapsed
      title: const Text("UangKu"),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(height1),
        child: Column(
          children: [
            const MonthView(),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                title: const Text("Expense"),
                subtitle: Text(
                  recordState.totalCurrentMonth.toIdr(),
                ),
              ),
            )
          ],
        ),
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

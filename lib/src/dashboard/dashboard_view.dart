import 'package:flutter/material.dart';
import 'package:my_money/src/dashboard/components/date_view.dart';
import 'package:my_money/src/dashboard/components/detail_record_view.dart';
import 'package:my_money/src/dashboard/components/info_view.dart';
import 'package:my_money/src/search/search_view.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyMoney'),
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
      drawer: const Drawer(),
      body: Column(
        children: [
          const DateView(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InfoView(
                title: "EXPENSE",
                color: Colors.red,
                total: 10000000,
              ),
              InfoView(
                title: "INCOME",
                color: Colors.green,
                total: 10000000,
              ),
              InfoView(
                title: "TOTAL",
                color: Colors.red,
                total: 10000000,
              ),
            ],
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...[1, 1, 1, 1].map((item) => const DetailRecordView())
              ],
            ),
          )
        ],
      ),
    );
  }
}

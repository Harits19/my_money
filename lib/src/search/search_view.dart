import 'package:flutter/material.dart';
import 'package:my_money/src/components/item_record_view.dart';
import 'package:my_money/src/state/record_state/state.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search",
                ),
                onChanged: (value) {
                  search = value;
                  setState(() {});
                },
              ),
            ),
            const Divider(),
            ItemRecordView(
              item: RecordState.of(context).search(search),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    const items = [];
    const noMatchFound = false;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search for records",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              noMatchFound ? const Text("No match founde") : const SizedBox(),
              items.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.manage_search_rounded,
                              size: 80,
                            ),
                            Text(
                                "Search records by notes, category name or account name"),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: const [],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

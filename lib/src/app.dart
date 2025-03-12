import 'package:flutter/material.dart';
import 'package:my_money/src/home/home_view.dart';
import 'package:my_money/src/services/local_storage_service.dart';
import 'package:my_money/src/state/date_state.dart';
import 'package:my_money/src/state/record_state/provider.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    LocalStorageService.initPrefs().then((value) {
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoading
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : const DateProvider(
              child: RecordProvider(
                child: HomeView(),
              ),
            ),
    );
  }
}

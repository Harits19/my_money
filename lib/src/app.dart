import 'package:flutter/material.dart';
import 'package:my_money/src/home/home_view.dart';
import 'package:my_money/src/services/local_storage_service.dart';
import 'package:my_money/src/services/notification_service.dart';
import 'package:my_money/src/state/date_state.dart';
import 'package:my_money/src/state/record_state/provider.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

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

  void init() async {
    await LocalStorageService.initPrefs();
    await NotificationService.requestPermission();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    final defaultTheme = ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );

    return DateProvider(
      child: RecordProvider(
        child: MaterialApp(
          scaffoldMessengerKey: snackbarKey,
          themeMode: ThemeMode.system,
          darkTheme: ThemeData.dark().copyWith(
            inputDecorationTheme: defaultTheme.inputDecorationTheme,
          ),
          theme: defaultTheme,
          home: const HomeView(),
        ),
      ),
    );
  }
}

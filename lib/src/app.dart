import 'package:flutter/material.dart';
import 'package:my_money/src/home/home_view.dart';
import 'package:my_money/src/services/local_storage_service.dart';
import 'package:my_money/src/services/notification_service.dart';
import 'package:my_money/src/splash/splash_view.dart';
import 'package:my_money/src/state/category_state/state.dart';
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
    await NotificationService.init();
    await NotificationService.scheduleAllTime();
    await LocalStorageService.initPrefs();
    await NotificationService.requestPermission();
    await Future.delayed(const Duration(
      seconds: 1,
    ));
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
    final defaultTheme = ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );

    if (isLoading) {
      return const MaterialApp(
        home: SplashView(),
      );
    }

    return DateProvider(
      child: RecordProvider(
        child: CategoryProvider(
          child: MaterialApp(
            scaffoldMessengerKey: snackbarKey,
            themeMode: ThemeMode.system,
            darkTheme: ThemeData.dark().copyWith(
              inputDecorationTheme: defaultTheme.inputDecorationTheme,
            ),
            theme: defaultTheme,
            home: isLoading ? const SplashView() : const HomeView(),
          ),
        ),
      ),
    );
  }
}

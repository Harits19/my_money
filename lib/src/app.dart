import 'package:flutter/material.dart';
import 'package:my_money/src/home/home_view.dart';
import 'package:my_money/src/services/notification_service.dart';
import 'package:my_money/src/splash/splash_view.dart';
import 'package:my_money/src/state/date_state.dart';
import 'package:my_money/src/state/record_state/provider.dart';
import 'package:my_money/src/state/record_state/state.dart';

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
  bool isLoadingNotification = true;

  void init() async {
    await NotificationService.init();
    await NotificationService.requestPermission();
    await NotificationService.scheduleAllTime();
    await Future.delayed(const Duration(
      seconds: 1,
    ));
    isLoadingNotification = false;
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

    return DateProvider(
      child: RecordProvider(
        builder: (context) {
          final isLoadingRecord = RecordState.of(context).isLoading;
          return MaterialApp(
            scaffoldMessengerKey: snackbarKey,
            themeMode: ThemeMode.system,
            darkTheme: ThemeData.dark().copyWith(
              inputDecorationTheme: defaultTheme.inputDecorationTheme,
            ),
            theme: defaultTheme,
            home: isLoadingNotification || isLoadingRecord
                ? const SplashView()
                : const HomeView(),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_money/src/app.dart';
import 'package:my_money/src/state/date_state.dart';
import 'package:my_money/src/state/theme_state.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const DateProvider(
      child: ThemeProvider(
        child: MyApp(),
      ),
    );
  }
}

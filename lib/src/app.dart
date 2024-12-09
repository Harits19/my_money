import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_money/src/add/add_view.dart';
import 'package:my_money/src/dashboard/dashboard_view.dart';
import 'package:my_money/src/search/search_view.dart';
import 'package:my_money/src/state/theme_state.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeState.of(context).themeMode,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            if (ThemeState.of(context).isLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            switch (routeSettings.name) {
              case AddView.routeName:
                return const AddView();
              case SearchView.routeName:
                return const SearchView();
              default:
                return const DashboardView();
            }
          },
        );
      },
    );
  }
}

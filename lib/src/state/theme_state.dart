import 'package:flutter/material.dart';
import 'package:my_money/src/services/settings_service.dart';

class ThemeState extends InheritedWidget {
  ThemeState({
    super.key,
    required this.themeMode,
    required this.setThemeMode,
    required this.isLoading,
    required super.child,
  });

  final SettingsService settingsService = SettingsService();

  final ThemeMode themeMode;
  final bool isLoading;

  final ValueChanged<ThemeMode?> setThemeMode;

  static ThemeState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeState>();
  }

  static ThemeState of(BuildContext context) {
    final ThemeState? result = maybeOf(context);
    assert(result != null, 'No ThemeState found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant ThemeState oldWidget) {
    return oldWidget.themeMode != themeMode || oldWidget.isLoading != isLoading;
  }
}

class ThemeProvider extends StatefulWidget {
  const ThemeProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ThemeProvider> createState() => _ThemeProviderState();
}

class _ThemeProviderState extends State<ThemeProvider> {
  ThemeMode themeMode = ThemeMode.system;

  bool isLoading = false;

  final settingService = SettingsService();

  Future<void> loadSettings() async {
    isLoading = true;
    setState(() {});
    themeMode = await settingService.themeMode();
    isLoading = false;
    setState(() {});
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == themeMode) return;
    themeMode = newThemeMode;

    await settingService.updateThemeMode(newThemeMode);
  }

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeState(
      isLoading: isLoading,
      themeMode: themeMode,
      setThemeMode: (value) {
        if (value == null) return;
        themeMode = value;

        setState(() {});
      },
      child: widget.child,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/provider_observers/logging_observer.dart';
import 'core/providers/prefs_provider.dart';
import 'core/providers/theme_brightness_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [prefsProvider.overrideWithValue(prefs)],
      observers: [ProviderLogger()],
      child: const MyApp(),
    ),
  );
}


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeBrightnessProvider) == Brightness.dark
        ? AppTheme.darkTheme
        : AppTheme.lightTheme;

    final appRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: appRouter.config(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/app_settings_provider.dart';
import 'core/lottie_cache_helper.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Preload Lottie animations for optimal performance
  await LottieCacheHelper.preloadAnimations([
    'assets/lottie/countdown.json',
    'assets/lottie/day1_rose.json',
    'assets/lottie/day2_teddy.json',
    'assets/lottie/day3_chocolate.json',
    'assets/lottie/day4_propose.json',
    'assets/lottie/day5_hug.json',
    'assets/lottie/day6_kiss.json',
    'assets/lottie/day7_valentine.json',
  ]);

  runApp(const ProviderScope(child: ValentineApp()));
}

class ValentineApp extends ConsumerWidget {
  const ValentineApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(appSettingsProvider);

    return MaterialApp.router(
      key: ValueKey(
        settingsState.locale.languageCode,
      ), // Force rebuild on locale change
      debugShowCheckedModeBanner: false,
      title: 'Valentine Week Surprise',

      // Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settingsState.themeMode,

      // Localization
      locale: settingsState.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ne'), // Nepali
      ],

      // Router
      routerConfig: AppRouter.router,
    );
  }
}

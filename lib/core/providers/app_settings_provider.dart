import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsState {
  final ThemeMode themeMode;
  final Locale locale;
  final bool isLoading;

  const AppSettingsState({
    required this.themeMode,
    required this.locale,
    this.isLoading = false,
  });

  AppSettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? isLoading,
  }) {
    return AppSettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AppSettingsNotifier extends StateNotifier<AppSettingsState> {
  static const String _themeKey = 'theme_mode';
  static const String _localeKey = 'locale';

  AppSettingsNotifier()
    : super(
        const AppSettingsState(
          themeMode: ThemeMode.dark,
          locale: Locale('en'),
          isLoading: true,
        ),
      ) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Load theme mode
      final themeIndex = prefs.getInt(_themeKey) ?? ThemeMode.dark.index;
      final themeMode = ThemeMode.values[themeIndex];

      // Load locale
      final localeCode = prefs.getString(_localeKey) ?? 'en';
      final locale = Locale(localeCode);

      state = AppSettingsState(
        themeMode: themeMode,
        locale: locale,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  Future<void> setLocale(Locale locale) async {
    state = state.copyWith(locale: locale);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  Future<void> toggleTheme() async {
    final newMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }

  Future<void> toggleLanguage() async {
    final newLocale =
        state.locale.languageCode == 'en'
            ? const Locale('ne')
            : const Locale('en');
    await setLocale(newLocale);
  }
}

final appSettingsProvider =
    StateNotifierProvider<AppSettingsNotifier, AppSettingsState>((ref) {
      return AppSettingsNotifier();
    });

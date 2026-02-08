import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/providers/app_settings_provider.dart';
import '../../core/theme/app_theme.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(appSettingsProvider);

    return Scaffold(
      body: Container(
        decoration: AppTheme.backgroundGradient(context),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Settings',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Current: ${settingsState.locale.languageCode.toUpperCase()}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _buildThemeSection(context, ref),
                      const SizedBox(height: 24),
                      _buildLanguageSection(context, ref),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(appSettingsProvider);
    final settingsNotifier = ref.read(appSettingsProvider.notifier);
    final isDark = settingsState.themeMode == ThemeMode.dark;

    return Container(
      decoration: AppTheme.elevatedCardDecoration(context),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: AppTheme.primaryColor,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text('Theme', style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isDark ? 'Dark Mode' : 'Light Mode',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Switch(
                value: isDark,
                onChanged: (_) => settingsNotifier.toggleTheme(),
                activeColor: AppTheme.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(appSettingsProvider);
    final settingsNotifier = ref.read(appSettingsProvider.notifier);
    final isNepali = settingsState.locale.languageCode == 'ne';

    return Container(
      decoration: AppTheme.elevatedCardDecoration(context),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.language,
                color: AppTheme.primaryColor,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                'Language',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildLanguageOption(
            context,
            'English',
            'en',
            !isNepali,
            () => settingsNotifier.setLocale(const Locale('en')),
          ),
          const SizedBox(height: 8),
          _buildLanguageOption(
            context,
            'नेपाली (Nepali)',
            'ne',
            isNepali,
            () => settingsNotifier.setLocale(const Locale('ne')),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String title,
    String code,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppTheme.primaryColor.withValues(alpha: 0.2)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected
                    ? AppTheme.primaryColor
                    : Colors.white.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppTheme.primaryColor),
          ],
        ),
      ),
    );
  }
}

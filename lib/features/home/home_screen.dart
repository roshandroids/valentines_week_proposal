import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/valentine_day.dart';
import '../../data/valentine_days.dart';
import '../../core/day_unlock_service.dart';
import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          _AnimatedBackground(),

          // Content
          SafeArea(
            child: Column(
              children: [_Header(), Expanded(child: _DayCalendar())],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(decoration: AppTheme.backgroundGradient(context));
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.calendarTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.calendarSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => context.push('/settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isWide ? 3 : 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: valentineDays.length,
      itemBuilder: (context, index) {
        return _DayCard(day: valentineDays[index]);
      },
    );
  }
}

class _DayCard extends StatelessWidget {
  final ValentineDay day;

  const _DayCard({required this.day});

  @override
  Widget build(BuildContext context) {
    final isUnlocked = DayUnlockService.isUnlocked(day.date);

    return GestureDetector(
      onTap: () => _handleTap(context),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.overlayLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                isUnlocked
                    ? AppTheme.primaryColor.withValues(alpha: 0.5)
                    : AppTheme.overlayMedium,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Content
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Date Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isUnlocked ? AppTheme.primaryColor : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Feb ${day.date}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Lock/Unlock Icon
                    Icon(
                      isUnlocked ? Icons.favorite : Icons.lock,
                      color: isUnlocked ? AppTheme.primaryColor : Colors.grey,
                      size: 48,
                    ),

                    const SizedBox(height: 12),

                    // Title
                    Text(
                      day.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // Status
                    Text(
                      isUnlocked ? 'Tap to Open' : 'Locked',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),

              // Shimmer effect for unlocked
              if (isUnlocked)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.overlayLight,
                          Colors.transparent,
                          AppTheme.overlayLight,
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    context.go('/day/${day.date}');
  }
}

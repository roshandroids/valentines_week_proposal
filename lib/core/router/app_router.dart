import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/proposal/proposal_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/day/day_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../countdown_lock_widget.dart';
import '../day_unlock_service.dart';
import '../../data/valentine_days.dart';

class AppRouter {
  // Private constructor to prevent instantiation
  AppRouter._();

  // Route paths
  static const String proposalRoute = '/';
  static const String homeRoute = '/home';
  static const String dayRoute = '/day/:id';
  static const String settingsRoute = '/settings';

  // Router configuration
  static final GoRouter router = GoRouter(
    initialLocation: proposalRoute,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: proposalRoute,
        name: 'proposal',
        builder: (context, state) => const ProposalScreen(),
      ),
      GoRoute(
        path: homeRoute,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: settingsRoute,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: dayRoute,
        name: 'day',
        builder: (context, state) {
          final idString = state.pathParameters['id'];
          final id = int.tryParse(idString ?? '') ?? 7;

          // Validate id range
          if (id < 7 || id > 14) {
            return const HomeScreen(); // Redirect to home if invalid
          }

          final day = valentineDays.firstWhere(
            (d) => d.date == id,
            orElse: () => valentineDays[0],
          );

          final isUnlocked = DayUnlockService.isUnlocked(id);

          if (isUnlocked) {
            return DayScreen(day: day);
          } else {
            return CountdownLockWidget(targetDate: id);
          }
        },
      ),
    ],
    errorBuilder: (context, state) => const HomeScreen(),
  );

  // Navigation helpers
  static void goToProposal(BuildContext context) {
    context.go(proposalRoute);
  }

  static void goToHome(BuildContext context) {
    context.go(homeRoute);
  }

  static void goToDay(BuildContext context, int dayId) {
    context.go('/day/$dayId');
  }

  // Deep link helpers
  static String getDayDeepLink(int dayId) {
    return '/day/$dayId';
  }
}

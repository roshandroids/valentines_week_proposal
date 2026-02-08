import '../data/valentine_day.dart';

class DayUnlockService {
  /// Checks if a specific day is unlocked
  /// Day unlocks at midnight on its date in February
  static bool isUnlocked(int date) {
    final now = DateTime.now();

    // Must be February
    if (now.month != 2) return false;

    // Must be on or after the target date
    return now.day >= date;
  }

  /// Calculates remaining time until a day unlocks
  static Duration getTimeRemaining(int date) {
    final now = DateTime.now();
    final targetDate = DateTime(now.year, 2, date);

    if (now.isAfter(targetDate)) {
      return Duration.zero;
    }

    return targetDate.difference(now);
  }

  /// Formats duration for display
  static String formatDuration(Duration duration) {
    if (duration.isNegative || duration.inSeconds == 0) {
      return 'Available now!';
    }

    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (days > 0) {
      return '$days day${days > 1 ? 's' : ''}, $hours hr${hours > 1 ? 's' : ''}';
    } else if (hours > 0) {
      return '$hours hr${hours > 1 ? 's' : ''}, $minutes min';
    } else if (minutes > 0) {
      return '$minutes min, $seconds sec';
    } else {
      return '$seconds sec';
    }
  }

  /// Gets all unlocked days
  static List<ValentineDay> getUnlockedDays(List<ValentineDay> allDays) {
    return allDays.where((day) => isUnlocked(day.date)).toList();
  }

  /// Gets next day to unlock
  static ValentineDay? getNextLockedDay(List<ValentineDay> allDays) {
    final lockedDays = allDays.where((day) => !isUnlocked(day.date)).toList();
    if (lockedDays.isEmpty) return null;
    lockedDays.sort((a, b) => a.date.compareTo(b.date));
    return lockedDays.first;
  }
}

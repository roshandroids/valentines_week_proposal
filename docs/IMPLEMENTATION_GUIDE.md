# Valentine Week Surprise App - Implementation Guide

## 📋 Table of Contents

- [Phase 1: Project Setup & Dependencies](#phase-1-project-setup--dependencies)
- [Phase 2: Core Architecture](#phase-2-core-architecture)
- [Phase 3: Data Layer](#phase-3-data-layer)
- [Phase 4: Core Services](#phase-4-core-services)
- [Phase 5: Home Screen](#phase-5-home-screen)
- [Phase 6: Day Screen](#phase-6-day-screen)
- [Phase 7: Responsive Design](#phase-7-responsive-design)
- [Phase 8: Special Feb 14 Treatment](#phase-8-special-feb-14-treatment)
- [Phase 9: Polish & Optional Features](#phase-9-polish--optional-features)

---

## Phase 1: Project Setup & Dependencies

### 1.1 Update pubspec.yaml

Add the following dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  google_fonts: ^8.0.1
  lottie: ^3.1.0 # For Lottie animations
  intl: ^0.19.0 # For date formatting
  shared_preferences: ^2.2.0 # Optional - for tracking seen days

flutter:
  uses-material-design: true

  assets:
    - assets/lottie/
    - assets/gifs/
```

### 1.2 Create Assets Directory Structure

```bash
mkdir -p assets/lottie assets/gifs
```

Directory structure:

```
assets/
├── lottie/
│   ├── day1_rose.json          # Rose Day animation
│   ├── day2_teddy.json         # Teddy Day animation
│   ├── day3_chocolate.json     # Chocolate Day animation
│   ├── day4_propose.json       # Propose Day animation
│   ├── day5_hug.json           # Hug Day animation
│   ├── day6_kiss.json          # Kiss Day animation
│   ├── day7_valentine.json     # Valentine's Day animation
│   └── countdown.json          # Countdown lock screen
└── gifs/
    ├── day1.gif
    ├── day2.gif
    ├── day3.gif
    ├── day4.gif
    ├── day5.gif
    ├── day6.gif
    └── day7.gif
```

### 1.3 Install Dependencies

```bash
flutter pub get
```

### 1.4 Asset Sources

**Free Lottie Sources:**

- [LottieFiles](https://lottiefiles.com/) - Search for: roses, teddy bear, chocolate, heart, hug, kiss, valentine
- Categories: Love, Romance, Valentine

**Free GIF Sources:**

- [Giphy](https://giphy.com/) - Search romantic/cute GIFs
- [Tenor](https://tenor.com/) - Valentine themed GIFs
- Keep file sizes small (<500KB) for web performance

---

## Phase 2: Core Architecture

### 2.1 Create Directory Structure

```bash
mkdir -p lib/core lib/data lib/features/home lib/features/day lib/core/painters
```

Final structure:

```
lib/
├── core/
│   ├── painters/
│   │   ├── garden_painter.dart
│   │   ├── petal_painter.dart
│   │   ├── firefly_painter.dart
│   │   └── confetti_painter.dart
│   ├── day_unlock_service.dart
│   └── countdown_lock_widget.dart
├── data/
│   ├── valentine_day.dart
│   └── valentine_days.dart
├── features/
│   ├── home/
│   │   └── home_screen.dart
│   └── day/
│       ├── day_screen.dart
│       └── day_interaction.dart
└── main.dart
```

### 2.2 Extract Existing Painters

Move the existing painters from `main.dart` to separate files in `core/painters/`:

**Purpose:**

- Reusability across multiple screens
- Cleaner code organization
- Easy maintenance

**Files to create:**

1. `garden_painter.dart` - Background garden scene
2. `petal_painter.dart` - Floating petals animation
3. `firefly_painter.dart` - Twinkling fireflies
4. `confetti_painter.dart` - Celebration confetti

### 2.3 Architecture Principles

**Data-Driven Approach:**

- Single `DayScreen` widget for all 7 days
- Content loaded from data models
- Reduces code duplication

**Separation of Concerns:**

- `core/` - Shared utilities and services
- `data/` - Models and static data
- `features/` - UI screens organized by feature

**Responsive Design:**

- Use `LayoutBuilder` for adaptive layouts
- Use `MediaQuery` for screen dimensions
- Avoid hardcoded sizes

---

## Phase 3: Data Layer

### 3.1 Create ValentineDay Model

**File:** `lib/data/valentine_day.dart`

```dart
class ValentineDay {
  final int date;               // Day of month (7-14)
  final String title;           // "Rose Day", "Teddy Day", etc.
  final String message;         // Sarcastic/romantic message
  final String lottiePath;      // Path to Lottie JSON
  final String gifPath;         // Path to GIF
  final String interactionType; // tap, longPress, checkbox, counter, none

  const ValentineDay({
    required this.date,
    required this.title,
    required this.message,
    required this.lottiePath,
    required this.gifPath,
    required this.interactionType,
  });
}
```

**Interaction Types:**

- `tap` - Simple tap triggers animation
- `longPress` - Hold to trigger special animation
- `checkbox` - Show checklist of funny promises
- `counter` - Tap to increment counter (kisses, hugs)
- `none` - No interaction (Feb 14)

### 3.2 Create Valentine Days Data

**File:** `lib/data/valentine_days.dart`

```dart
import 'valentine_day.dart';

final List<ValentineDay> valentineDays = [
  ValentineDay(
    date: 7,
    title: 'Rose Day',
    message: 'They say roses are red... but mine came with a receipt. '
        'Just kidding! These virtual roses never wilt, unlike my patience waiting for you. 🌹',
    lottiePath: 'assets/lottie/day1_rose.json',
    gifPath: 'assets/gifs/day1.gif',
    interactionType: 'tap',
  ),

  ValentineDay(
    date: 8,
    title: 'Teddy Day',
    message: 'I got you a teddy bear because it\'s the only thing '
        'that can handle your bear hugs without complaining. Unlike me. 🧸',
    lottiePath: 'assets/lottie/day2_teddy.json',
    gifPath: 'assets/gifs/day2.gif',
    interactionType: 'longPress',
  ),

  ValentineDay(
    date: 9,
    title: 'Chocolate Day',
    message: 'Life is like a box of chocolates... and you stole all the good ones. '
        'But I still love you more than chocolate. That\'s saying something. 🍫',
    lottiePath: 'assets/lottie/day3_chocolate.json',
    gifPath: 'assets/gifs/day3.gif',
    interactionType: 'counter',
  ),

  ValentineDay(
    date: 10,
    title: 'Propose Day',
    message: 'I practiced this proposal in front of my mirror 47 times. '
        'The mirror said yes. Your turn now? 💍',
    lottiePath: 'assets/lottie/day4_propose.json',
    gifPath: 'assets/gifs/day4.gif',
    interactionType: 'checkbox', // Special - reuse existing proposal card
  ),

  ValentineDay(
    date: 11,
    title: 'Hug Day',
    message: 'Hugs are free, calorie-free, and scientifically proven to improve mood. '
        'So basically, I\'m doing you a health favor here. You\'re welcome. 🤗',
    lottiePath: 'assets/lottie/day5_hug.json',
    gifPath: 'assets/gifs/day5.gif',
    interactionType: 'longPress',
  ),

  ValentineDay(
    date: 12,
    title: 'Kiss Day',
    message: 'I googled "How to be a better kisser" and the first result was "practice". '
        'So... science says we should practice. A lot. 💋',
    lottiePath: 'assets/lottie/day6_kiss.json',
    gifPath: 'assets/gifs/day6.gif',
    interactionType: 'counter',
  ),

  ValentineDay(
    date: 13,
    title: 'Promise Day',
    message: 'I promise to laugh at your jokes (even the bad ones), '
        'share my fries (sometimes), and love you forever (definitely). 💕',
    lottiePath: 'assets/lottie/day7_valentine.json',
    gifPath: 'assets/gifs/day7.gif',
    interactionType: 'checkbox',
  ),

  ValentineDay(
    date: 14,
    title: 'Valentine\'s Day',
    message: 'My dear love, through all the jokes and sarcasm, here\'s the truth: '
        'You make every day feel like Valentine\'s Day. '
        'Thank you for being you, for being mine, for being us. '
        'I love you more than words can express. Happy Valentine\'s Day, meri maya. ❤️',
    lottiePath: 'assets/lottie/day7_valentine.json',
    gifPath: 'assets/gifs/day7.gif',
    interactionType: 'none', // Just emotional display
  ),
];
```

**Data Design Notes:**

- Days 1-6: Mix of humor and romance
- Day 10: Special - integrate existing proposal UI
- Day 14: Pure emotion, no sarcasm
- Messages personalized (configurable)

---

## Phase 4: Core Services

### 4.1 Day Unlock Service

**File:** `lib/core/day_unlock_service.dart`

```dart
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
```

**Usage Example:**

```dart
// Check if Feb 10 is unlocked
bool canOpen = DayUnlockService.isUnlocked(10);

// Get countdown for Feb 12
Duration remaining = DayUnlockService.getTimeRemaining(12);
String display = DayUnlockService.formatDuration(remaining);
// Output: "2 days, 5 hrs" or "45 min, 30 sec"
```

### 4.2 Countdown Lock Widget

**File:** `lib/core/countdown_lock_widget.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'day_unlock_service.dart';

class CountdownLockWidget extends StatefulWidget {
  final int targetDate;
  final VoidCallback onUnlocked;

  const CountdownLockWidget({
    super.key,
    required this.targetDate,
    required this.onUnlocked,
  });

  @override
  State<CountdownLockWidget> createState() => _CountdownLockWidgetState();
}

class _CountdownLockWidgetState extends State<CountdownLockWidget> {
  Timer? _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    setState(() {
      _remaining = DayUnlockService.getTimeRemaining(widget.targetDate);
    });

    // Auto-unlock when time reaches zero
    if (_remaining.isNegative || _remaining.inSeconds == 0) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUnlocked = _remaining.isNegative || _remaining.inSeconds == 0;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2B1D3A),
              Color(0xFF3F1A33),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.1),

                  // Lock Icon/Animation
                  SizedBox(
                    height: size.height * 0.3,
                    child: Lottie.asset(
                      'assets/lottie/countdown.json',
                      fit: BoxFit.contain,
                    ),
                  ),

                  SizedBox(height: 32),

                  // Title
                  Text(
                    isUnlocked ? 'Surprise Unlocked!' : 'Patience, My Love',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 16),

                  // Message
                  Text(
                    isUnlocked
                        ? 'The wait is over! Your surprise is ready. 🎉'
                        : 'Good things come to those who wait.\n'
                          'And you, my dear, are worth the wait.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 32),

                  // Countdown Timer
                  if (!isUnlocked) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Unlocks in:',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            DayUnlockService.formatDuration(_remaining),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32),
                  ],

                  // Action Button
                  ElevatedButton(
                    onPressed: isUnlocked ? widget.onUnlocked : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFC91F5A),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      disabledBackgroundColor: Colors.grey,
                    ),
                    child: Text(
                      isUnlocked ? 'Open Surprise 🎉' : 'I will wait 😏',
                    ),
                  ),

                  SizedBox(height: 16),

                  // Back button
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Back to Calendar',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

**Features:**

- Real-time countdown updates every second
- Auto-unlocks when time reaches zero
- Responsive sizing based on screen
- Smooth animations
- Disabled button shows current wait time

---

## Phase 5: Home Screen

### 5.1 Home Screen Implementation

**File:** `lib/features/home/home_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../data/valentine_days.dart';
import '../../data/valentine_day.dart';
import '../../core/day_unlock_service.dart';
import '../../core/countdown_lock_widget.dart';
import '../../core/painters/petal_painter.dart';
import '../day/day_screen.dart';

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
              children: [
                _Header(),
                Expanded(
                  child: _DayCalendar(),
                ),
              ],
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF121A34),
            Color(0xFF2B1D3A),
            Color(0xFF3F1A33),
          ],
        ),
      ),
      // Add petal animation here (reuse from existing code)
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            '💕 Valentine Week 💕',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'February 7-14, 2026',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
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
      padding: EdgeInsets.all(16),
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
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUnlocked
                ? Color(0xFFC91F5A).withOpacity(0.5)
                : Colors.white.withOpacity(0.2),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Content
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Date Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isUnlocked
                            ? Color(0xFFC91F5A)
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Feb ${day.date}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Lock/Unlock Icon
                    Icon(
                      isUnlocked ? Icons.favorite : Icons.lock,
                      color: isUnlocked ? Color(0xFFC91F5A) : Colors.grey,
                      size: 48,
                    ),

                    SizedBox(height: 12),

                    // Title
                    Text(
                      day.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 8),

                    // Status
                    Text(
                      isUnlocked ? 'Tap to Open' : 'Locked',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
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
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                          Colors.white.withOpacity(0.1),
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
    if (DayUnlockService.isUnlocked(day.date)) {
      // Navigate to day screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DayScreen(day: day),
        ),
      );
    } else {
      // Show countdown lock
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CountdownLockWidget(
            targetDate: day.date,
            onUnlocked: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DayScreen(day: day),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
```

**Features:**

- Grid layout (2 columns mobile, 3 columns tablet/desktop)
- Visual distinction between locked/unlocked days
- Smooth navigation
- Animated background with petals
- Responsive card sizing

---

## Phase 6: Day Screen

### 6.1 Day Screen Implementation

**File:** `lib/features/day/day_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../data/valentine_day.dart';
import '../../core/painters/petal_painter.dart';
import 'day_interaction.dart';

class DayScreen extends StatefulWidget {
  final ValentineDay day;

  const DayScreen({super.key, required this.day});

  @override
  State<DayScreen> createState() => _DayScreenState();
}

class _DayScreenState extends State<DayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 600;

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF2B1D3A),
                      Color(0xFF3F1A33),
                    ],
                  ),
                ),
                // Add petal painter here
              );
            },
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isWide ? 48.0 : 24.0),
                child: Column(
                  children: [
                    // Header with back button
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Text(
                            widget.day.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 48), // Balance back button
                      ],
                    ),

                    SizedBox(height: 32),

                    // Lottie Animation
                    Container(
                      height: size.height * (isWide ? 0.3 : 0.25),
                      constraints: BoxConstraints(maxWidth: 400),
                      child: Lottie.asset(
                        widget.day.lottiePath,
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(height: 32),

                    // Message Card
                    Container(
                      constraints: BoxConstraints(maxWidth: 600),
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        widget.day.message,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                              color: Colors.white,
                              height: 1.6,
                              fontSize: 16,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 32),

                    // GIF
                    Container(
                      height: size.height * 0.2,
                      constraints: BoxConstraints(maxWidth: 400),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          widget.day.gifPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: 32),

                    // Interaction Section
                    DayInteraction(
                      interactionType: widget.day.interactionType,
                      date: widget.day.date,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### 6.2 Day Interaction Widget

**File:** `lib/features/day/day_interaction.dart`

```dart
import 'package:flutter/material.dart';

class DayInteraction extends StatefulWidget {
  final String interactionType;
  final int date;

  const DayInteraction({
    super.key,
    required this.interactionType,
    required this.date,
  });

  @override
  State<DayInteraction> createState() => _DayInteractionState();
}

class _DayInteractionState extends State<DayInteraction> {
  int _counter = 0;
  bool _isPressed = false;
  List<bool> _checklist = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    switch (widget.interactionType) {
      case 'tap':
        return _buildTapInteraction();
      case 'longPress':
        return _buildLongPressInteraction();
      case 'counter':
        return _buildCounterInteraction();
      case 'checkbox':
        return _buildCheckboxInteraction();
      case 'none':
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildTapInteraction() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPressed = !_isPressed;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isPressed
              ? Color(0xFFC91F5A).withOpacity(0.3)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isPressed ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
              size: 32,
            ),
            SizedBox(width: 16),
            Text(
              _isPressed ? 'You tapped my heart! 💕' : 'Tap to send love',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLongPressInteraction() {
    return GestureDetector(
      onLongPressStart: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onLongPressEnd: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isPressed
              ? Color(0xFFC91F5A).withOpacity(0.5)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(
              Icons.favorite,
              color: Colors.white,
              size: _isPressed ? 64 : 48,
            ),
            SizedBox(height: 16),
            Text(
              _isPressed ? 'Feeling the love! 🤗' : 'Hold to hug',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterInteraction() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            widget.date == 9 ? 'Chocolates Collected' : 'Kisses Collected',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '$_counter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFC91F5A),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: Text(
              widget.date == 9 ? 'Grab Chocolate 🍫' : 'Send Kiss 💋',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxInteraction() {
    final promises = widget.date == 13
        ? [
            'Always laugh at your jokes 😄',
            'Share my snacks (sometimes) 🍿',
            'Give unlimited hugs 🤗',
            'Love you forever ❤️',
          ]
        : [
            'Make you smile every day 😊',
            'Be your biggest supporter 💪',
            'Always be honest 🤝',
            'Love you unconditionally ❤️',
          ];

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Promises to You:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ...List.generate(promises.length, (index) {
            return CheckboxListTile(
              title: Text(
                promises[index],
                style: TextStyle(color: Colors.white),
              ),
              value: _checklist[index],
              onChanged: (value) {
                setState(() {
                  _checklist[index] = value ?? false;
                });
              },
              activeColor: Color(0xFFC91F5A),
              checkColor: Colors.white,
            );
          }),
        ],
      ),
    );
  }
}
```

**Interaction Types Explained:**

- **tap**: Simple tap toggles heart animation
- **longPress**: Hold to show growing heart (hug/kiss effect)
- **counter**: Tap button to increment counter with animation
- **checkbox**: Check off promises/commitments

---

## Phase 7: Responsive Design

### 7.1 Responsive Breakpoints

Define breakpoints for different devices:

```dart
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobile;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobile && width < desktop;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktop;
  }
}
```

### 7.2 Responsive Sizing Utilities

```dart
class ResponsiveSize {
  final BuildContext context;

  ResponsiveSize(this.context);

  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // Percentage-based sizing
  double wp(double percentage) => width * (percentage / 100);
  double hp(double percentage) => height * (percentage / 100);

  // Scale text based on screen width
  double textScale(double baseSize) {
    if (width < 360) return baseSize * 0.9;
    if (width > 600) return baseSize * 1.1;
    return baseSize;
  }

  // Dynamic padding
  EdgeInsets get screenPadding {
    if (ResponsiveBreakpoints.isMobile(context)) {
      return EdgeInsets.all(16);
    } else if (ResponsiveBreakpoints.isTablet(context)) {
      return EdgeInsets.all(32);
    } else {
      return EdgeInsets.all(48);
    }
  }
}
```

### 7.3 Testing Responsive Layouts

**Manual Testing:**

1. **Mobile Portrait**: 375x667 (iPhone SE)
2. **Mobile Landscape**: 667x375
3. **Tablet**: 768x1024 (iPad)
4. **Desktop**: 1920x1080

**Chrome DevTools:**

- Toggle device toolbar (Cmd+Shift+M / Ctrl+Shift+M)
- Test various device presets
- Test zoom levels (50%, 100%, 150%)

**Flutter DevTools:**

```dart
// Enable layout guidelines
debugPaintSizeEnabled = true;
debugPaintBaselinesEnabled = true;
```

---

## Phase 8: Special Feb 14 Treatment

### 8.1 Valentine's Day Special Features

**Enhanced Day Screen for Feb 14:**

```dart
class ValentinesDayScreen extends StatefulWidget {
  final ValentineDay day;

  const ValentinesDayScreen({super.key, required this.day});

  @override
  State<ValentinesDayScreen> createState() => _ValentinesDayScreenState();
}

class _ValentinesDayScreenState extends State<ValentinesDayScreen>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _heartController;

  @override
  void initState() {
    super.initState();

    _confettiController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _heartController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    // Auto-start confetti
    Future.delayed(Duration(milliseconds: 500), () {
      _confettiController.forward();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          _buildBackground(),

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    SizedBox(height: 32),

                    // Animated heart
                    AnimatedBuilder(
                      animation: _heartController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + (_heartController.value * 0.2),
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xFFC91F5A),
                            size: 100,
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 24),

                    // Title
                    Text(
                      'Happy Valentine\'s Day',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 16),

                    Text(
                      'My dear love',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                            color: Color(0xFFC91F5A),
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 32),

                    // Main message
                    Container(
                      padding: EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Color(0xFFC91F5A).withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: Text(
                        widget.day.message,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                              color: Colors.white,
                              height: 1.8,
                              fontSize: 18,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: 32),

                    // Lottie animation
                    Container(
                      height: 300,
                      child: Lottie.asset(
                        widget.day.lottiePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Confetti overlay
          AnimatedBuilder(
            animation: _confettiController,
            builder: (context, child) {
              return CustomPaint(
                painter: ConfettiPainter(
                  progress: _confettiController.value,
                  confetti: _generateConfetti(),
                ),
                child: Container(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.0,
          colors: [
            Color(0xFF3F1A33),
            Color(0xFF2B1D3A),
            Color(0xFF121A34),
          ],
        ),
      ),
    );
  }

  List<ConfettiPiece> _generateConfetti() {
    // Reuse existing confetti generation logic
    return [];
  }
}
```

**Feb 14 Special Features:**

- Auto-playing confetti animation
- Pulsing heart icon
- Enhanced romantic message (no sarcasm)
- Special gradient background
- Larger, more emotional typography

---

## Phase 9: Polish & Optional Features

### 9.1 Shared Preferences (Mark Days as Seen)

```dart
import 'package:shared_preferences/shared_preferences.dart';

class DayProgressService {
  static const String _keyPrefix = 'day_seen_';

  // Mark a day as seen
  static Future<void> markDaySeen(int date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_keyPrefix$date', true);
  }

  // Check if day has been seen
  static Future<bool> isDaySeen(int date) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_keyPrefix$date') ?? false;
  }

  // Get all seen days
  static Future<List<int>> getSeenDays() async {
    final prefs = await SharedPreferences.getInstance();
    List<int> seenDays = [];

    for (int date = 7; date <= 14; date++) {
      if (prefs.getBool('$_keyPrefix$date') ?? false) {
        seenDays.add(date);
      }
    }

    return seenDays;
  }

  // Clear all progress (for testing)
  static Future<void> clearProgress() async {
    final prefs = await SharedPreferences.getInstance();
    for (int date = 7; date <= 14; date++) {
      await prefs.remove('$_keyPrefix$date');
    }
  }
}
```

**Usage in DayScreen:**

```dart
@override
void initState() {
  super.initState();
  // Mark as seen when opened
  DayProgressService.markDaySeen(widget.day.date);
}
```

**Home Screen Badge:**

```dart
Stack(
  children: [
    _DayCard(day: day),
    if (!await DayProgressService.isDaySeen(day.date))
      Positioned(
        top: 8,
        right: 8,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Color(0xFFC91F5A),
            shape: BoxShape.circle,
          ),
        ),
      ),
  ],
)
```

### 9.2 Background Music Toggle

```dart
import 'package:audioplayers/audioplayers.dart';

class MusicService {
  static final AudioPlayer _player = AudioPlayer();
  static bool _isMusicEnabled = true;

  static Future<void> initialize() async {
    await _player.setSource(AssetSource('music/valentine_theme.mp3'));
    await _player.setReleaseMode(ReleaseMode.loop);
  }

  static Future<void> play() async {
    if (_isMusicEnabled) {
      await _player.resume();
    }
  }

  static Future<void> pause() async {
    await _player.pause();
  }

  static void toggle() {
    _isMusicEnabled = !_isMusicEnabled;
    if (_isMusicEnabled) {
      play();
    } else {
      pause();
    }
  }

  static bool get isEnabled => _isMusicEnabled;
}
```

**Music Toggle Button:**

```dart
FloatingActionButton(
  mini: true,
  onPressed: () {
    setState(() {
      MusicService.toggle();
    });
  },
  child: Icon(
    MusicService.isEnabled ? Icons.music_note : Icons.music_off,
  ),
)
```

### 9.3 Photo Slideshow (Optional)

**For Feb 14:**

```dart
class PhotoSlideshow extends StatefulWidget {
  final List<String> photoPaths;

  const PhotoSlideshow({super.key, required this.photoPaths});

  @override
  State<PhotoSlideshow> createState() => _PhotoSlideshowState();
}

class _PhotoSlideshowState extends State<PhotoSlideshow> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Auto-advance every 3 seconds
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentIndex < widget.photoPaths.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      if (mounted) {
        _pageController.animateToPage(
          _currentIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.photoPaths.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(widget.photoPaths[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
```

### 9.4 Testing & Debugging

**Date Override for Testing:**

```dart
class DateOverride {
  static DateTime? _overrideDate;

  static void setDate(int day) {
    _overrideDate = DateTime(2026, 2, day);
  }

  static void clearOverride() {
    _overrideDate = null;
  }

  static DateTime get now => _overrideDate ?? DateTime.now();
}
```

**Use in DayUnlockService:**

```dart
static bool isUnlocked(int date) {
  final now = DateOverride.now; // Instead of DateTime.now()
  if (now.month != 2) return false;
  return now.day >= date;
}
```

**Debug Panel:**

```dart
class DebugPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Debug Controls'),
          ),
          ...List.generate(8, (index) {
            int day = index + 7;
            return ListTile(
              title: Text('Set to Feb $day'),
              onTap: () {
                DateOverride.setDate(day);
                Navigator.pop(context);
              },
            );
          }),
          ListTile(
            title: Text('Clear Date Override'),
            onTap: () {
              DateOverride.clearOverride();
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Clear Progress'),
            onTap: () async {
              await DayProgressService.clearProgress();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
```

---

## 🚀 Final Deployment Checklist

### Android

- [ ] Update `android/app/build.gradle` version
- [ ] Add app icon
- [ ] Test on physical device
- [ ] Build release: `flutter build apk --release`

### iOS

- [ ] Update version in Xcode
- [ ] Add app icon
- [ ] Test on physical device
- [ ] Build release: `flutter build ios --release`

### Web

- [ ] Test on Chrome, Safari, Firefox
- [ ] Optimize images/GIFs for web
- [ ] Build release: `flutter build web --release`
- [ ] Deploy to hosting (Firebase Hosting, Netlify, etc.)

### Performance

- [ ] All images optimized (<500KB)
- [ ] Lottie animations load quickly
- [ ] No memory leaks (dispose controllers)
- [ ] Smooth 60fps animations

### Testing

- [ ] Test all 7 days
- [ ] Test locked/unlocked states
- [ ] Test countdown timer
- [ ] Test all interactions
- [ ] Test responsive on mobile/tablet/desktop
- [ ] Test date boundaries (Feb 6, Feb 7, Feb 14, Feb 15)

---

## 📚 Additional Resources

**Flutter Documentation:**

- [Responsive Design](https://docs.flutter.dev/ui/layout/responsive/adaptive-responsive)
- [Animations](https://docs.flutter.dev/ui/animations)
- [Assets and Images](https://docs.flutter.dev/ui/assets/assets-and-images)

**Packages:**

- [Lottie](https://pub.dev/packages/lottie)
- [Shared Preferences](https://pub.dev/packages/shared_preferences)
- [Google Fonts](https://pub.dev/packages/google_fonts)

**Design Inspiration:**

- [Dribbble - Valentine's Day](https://dribbble.com/tags/valentine)
- [Behance - Love Apps](https://www.behance.net/search/projects?search=valentine+app)

---

## 🎉 Conclusion

This guide provides a complete roadmap for implementing the Valentine Week Surprise app. Follow the phases sequentially, test thoroughly, and customize the content to make it personal and special.

Remember: The goal is to create a memorable, emotional experience that tells a story from Feb 7 to Feb 14, building from funny/sarcastic to deeply romantic.

Good luck with your implementation! 💕

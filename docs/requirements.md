# Valentine Week Surprise App — Functional & Architecture Spec

## 🎯 Goal

Build a **Flutter multiplatform app (Android, iOS, Web)** that delivers **7 Valentine-week surprises** from **Feb 7 to Feb 14**.

Each day contains:

- Funny sarcastic romantic message
- Lottie animation
- GIF
- Small interaction
- Locked access with countdown timer if opened early

The experience should feel like a **story that starts funny and ends emotionally on Feb 14**.

---

## 🌍 Multiplatform & Responsive Requirement (CRITICAL)

This app MUST:

- Work on **Android**
- Work on **iOS**
- Work on **Flutter Web**
- Be **responsive** for:
  - Mobile portrait
  - Mobile landscape
  - Tablet
  - Desktop browser

Rules:

- Use `LayoutBuilder` / `MediaQuery` for responsive layout
- Avoid fixed heights and widths
- Animations and GIFs must scale with screen size
- Same codebase for all platforms

---

## 🧱 Architecture

Use feature-based structure.

```
lib/
 ├── core/
 │    ├── day_unlock_service.dart
 │    ├── countdown_lock_widget.dart
 │
 ├── data/
 │    └── valentine_days.dart
 │
 ├── features/
 │    ├── home/home_screen.dart
 │    ├── day/day_screen.dart
 │    ├── day/day_interaction.dart
 │
 └── main.dart
```

App must be **data-driven**. No separate screens per day.

---

## 🗓 ValentineDay Model

Create model:

```dart
class ValentineDay {
  final int date;
  final String title;
  final String message;
  final String lottie;
  final String gif;
  final String interactionType;

  ValentineDay({
    required this.date,
    required this.title,
    required this.message,
    required this.lottie,
    required this.gif,
    required this.interactionType,
  });
}
```

---

## 📦 Day Data (valentine_days.dart)

Create a list of 7 days for Feb 7–14.

Each day must include:

- title (Rose Day, Propose Day, etc.)
- sarcastic message
- lottie asset path
- gif asset path
- interaction type (tap, longPress, checkbox, counter, none)

---

## 🔓 Day Unlock Logic

Create `DayUnlockService`.

Rules:

- Day is unlocked if `DateTime.now().day >= date` AND month is February.
- Otherwise locked.
- Provide method to calculate remaining `Duration` until unlock.

```dart
static bool isUnlocked(int date);
static Duration remaining(int date);
```

---

## 🏠 Home Screen Requirements

- Display 7 cards (Feb 7–14).
- Each card shows:
  - Title
  - Lock/Unlock icon
- On tap:
  - If unlocked → open DayScreen
  - If locked → open CountdownLockWidget

---

## ⏳ Countdown Lock Screen

If user opens early:

Show:

- Funny “wait for surprise” message
- Lottie animation
- Countdown timer updating every second
- Button: “I will wait 😏”

When timer reaches zero:

- Show button “Open Surprise 🎉”

---

## 📄 Day Screen Layout (Reusable & Responsive)

Structure:

```
Stack
 ├── Animated background (hearts)
 ├── Column (responsive)
      ├── Lottie animation (flexible size)
      ├── Title
      ├── Message text
      ├── GIF
      ├── Interaction section
```

Must adapt to screen sizes using Flex/Expanded/FractionallySizedBox.

---

## 🎮 Interaction Types

Implement based on `interactionType`:

| Type      | Behavior                                |
| --------- | --------------------------------------- |
| tap       | Tap triggers extra animation            |
| longPress | Long press triggers heart/hug animation |
| checkbox  | Show funny promise checklist            |
| counter   | Tap to increase kiss counter            |
| none      | No interaction                          |

---

## 🧠 Functional Requirements

### FR1 — Day content

Must load content from `valentine_days.dart`.

### FR2 — Unlock rules

Based on device local date/time.

### FR3 — Countdown

Must update every second.

### FR4 — Navigation

Home → Day or Countdown based on unlock state.

### FR5 — Offline

All assets local. No internet needed.

### FR6 — Responsive

UI must scale and look good on Web, Tablet, and Mobile.

---

## 🎞 Assets Structure

```
assets/
 ├── lottie/
 ├── gifs/
```

Use:

- `lottie` package
- `Image.asset` for GIF

---

## 🎨 UX Flow

### App Launch

Splash → Home

### Home

7 day cards

### Locked Day

Countdown screen

### Unlocked Day

Animated wish screen

### Feb 14

No sarcasm. Emotional message + confetti.

---

## ✅ Acceptance Criteria

- Works on Android, iOS, and Web.
- Correct lock/unlock behavior by date.
- Countdown works.
- Same DayScreen reused for all days.
- Fully responsive UI.
- All animations and GIFs load.
- Works offline.

---

## 🧩 Optional Enhancements

- Mark day as “Seen” using shared_preferences
- Background music toggle
- Photo slideshow on Feb 14

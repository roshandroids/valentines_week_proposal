import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Color Palette
  static const Color primaryColor = Color(0xFFC91F5A);
  static const Color accentColor = Color(0xFFE91E63);

  // Dark Theme Colors
  static const Color darkBackgroundColor = Color(0xFF1A1A2E);
  static const Color darkSurfaceColor = Color(0xFF16213E);
  static const Color darkCardColor = Color(0xFF0F3460);
  static const Color darkGradientStart = Color(0xFF1A1A2E);
  static const Color darkGradientMiddle = Color(0xFF16213E);
  static const Color darkGradientEnd = Color(0xFF0F3460);

  // Light Theme Colors
  static const Color lightBackgroundColor = Color(0xFFFFF5F7);
  static const Color lightSurfaceColor = Color(0xFFFFFFFF);
  static const Color lightCardColor = Color(0xFFFFF0F3);
  static const Color lightGradientStart = Color(0xFFFFE5EC);
  static const Color lightGradientMiddle = Color(0xFFFFF0F5);
  static const Color lightGradientEnd = Color(0xFFFFF5F7);

  // Text Colors (Dark Theme)
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Colors.white70;
  static const Color darkTextTertiary = Colors.white60;

  // Text Colors (Light Theme)
  static const Color lightTextPrimary = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF4A4A4A);
  static const Color lightTextTertiary = Color(0xFF757575);

  // Dynamic accessors based on current context
  static Color backgroundColor = darkBackgroundColor;
  static Color surfaceColor = darkSurfaceColor;
  static Color cardColor = darkCardColor;
  static Color textPrimary = darkTextPrimary;
  static Color textSecondary = darkTextSecondary;
  static Color textTertiary = darkTextTertiary;

  // Overlay Colors
  static Color overlayLight = Colors.white.withValues(alpha: 0.1);
  static Color overlayMedium = Colors.white.withValues(alpha: 0.2);
  static Color primaryOverlayLight = primaryColor.withValues(alpha: 0.3);
  static Color primaryOverlayMedium = primaryColor.withValues(alpha: 0.5);

  // Status Colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFF9800);

  // Garden Theme Colors
  static const Color gardenGreen = Color(0xFF2E7D32);
  static const Color gardenDark = Color(0xFF1B5E20);
  static const Color petalColor = Color(0xFFFFC1CC);
  static const Color fireflyColor = Color(0xFFFFF176);

  // Dark Theme Data
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackgroundColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: darkSurfaceColor,
        error: errorColor,
      ),
      textTheme: GoogleFonts.playfairDisplayTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: darkTextPrimary,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: darkTextPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            color: darkTextPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: TextStyle(
            color: darkTextPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: darkTextPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: darkTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            color: darkTextPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(color: darkTextPrimary, fontSize: 16),
          bodyMedium: TextStyle(color: darkTextSecondary, fontSize: 14),
          bodySmall: TextStyle(color: darkTextTertiary, fontSize: 12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: darkTextPrimary,
          elevation: 8,
          shadowColor: primaryColor.withValues(alpha: 0.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      cardTheme: const CardThemeData(
        color: darkCardColor,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(darkTextPrimary),
        side: const BorderSide(color: darkTextSecondary),
      ),
    );
  }

  // Light Theme Data
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackgroundColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: lightSurfaceColor,
        error: errorColor,
      ),
      textTheme: GoogleFonts.playfairDisplayTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: lightTextPrimary,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: lightTextPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
            color: lightTextPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: TextStyle(
            color: lightTextPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: lightTextPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: lightTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            color: lightTextPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(color: lightTextPrimary, fontSize: 16),
          bodyMedium: TextStyle(color: lightTextSecondary, fontSize: 14),
          bodySmall: TextStyle(color: lightTextTertiary, fontSize: 12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: primaryColor.withValues(alpha: 0.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      cardTheme: const CardThemeData(
        color: lightCardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        side: BorderSide(color: lightTextSecondary),
      ),
    );
  }

  // Background Gradient (Dark)
  static BoxDecoration get darkBackgroundGradient {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [darkGradientStart, darkGradientMiddle, darkGradientEnd],
      ),
    );
  }

  // Background Gradient (Light)
  static BoxDecoration get lightBackgroundGradient {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [lightGradientStart, lightGradientMiddle, lightGradientEnd],
      ),
    );
  }

  // Background Gradient (Dynamic)
  static BoxDecoration backgroundGradient(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkBackgroundGradient : lightBackgroundGradient;
  }

  // Card Decoration
  static BoxDecoration cardDecoration(BuildContext context, {Color? color}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor =
        isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.black.withValues(alpha: 0.05);
    return BoxDecoration(
      color: color ?? defaultColor,
      borderRadius: BorderRadius.circular(20),
    );
  }

  // Elevated Card Decoration
  static BoxDecoration elevatedCardDecoration(
    BuildContext context, {
    Color? color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? darkCardColor : lightCardColor;
    return BoxDecoration(
      color: color ?? defaultColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: primaryColor.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}

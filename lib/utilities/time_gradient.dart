import 'package:flutter/material.dart';
import '../constants/app_strings.dart';

class TimeGradient {
  static LinearGradient getGradientForCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour;

    return getGradientForHour(hour);
  }

  static LinearGradient getGradientForHour(int hour) {
    // Early Morning (5 AM - 7 AM): Dawn colors
    if (hour >= 5 && hour < 7) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF4A90E2), // Light blue
          Color(0xFF7B68EE), // Medium slate blue
          Color(0xFF2D1B69), // Dark purple
        ],
      );
    }
    // Morning (7 AM - 10 AM): Bright morning colors
    else if (hour >= 7 && hour < 10) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF87CEEB), // Sky blue
          Color(0xFF4682B4), // Steel blue
          Color(0xFF2D1B69), // Dark purple
        ],
      );
    }
    // Late Morning to Afternoon (10 AM - 4 PM): Daylight colors
    else if (hour >= 10 && hour < 16) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF6495ED), // Cornflower blue
          Color(0xFF483D8B), // Dark slate blue
          Color(0xFF2D1B69), // Dark purple
        ],
      );
    }
    // Evening (4 PM - 6 PM): Sunset colors
    else if (hour >= 16 && hour < 18) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFF7F50), // Coral
          Color(0xFF9370DB), // Medium purple
          Color(0xFF2D1B69), // Dark purple
        ],
      );
    }
    // Dusk (6 PM - 8 PM): Twilight colors
    else if (hour >= 18 && hour < 20) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF8B4513), // Saddle brown
          Color(0xFF663399), // Rebecca purple
          Color(0xFF2D1B69), // Dark purple
        ],
      );
    }
    // Night (8 PM - 11 PM): Deep night colors
    else if (hour >= 20 && hour < 23) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2D1B69), // Dark purple
          Color(0xFF1A0E3D), // Darker purple
          Color(0xFF11052C), // Very dark purple
        ],
      );
    }
    // Late Night (11 PM - 5 AM): Midnight colors
    else {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF191970), // Midnight blue
          Color(0xFF0F0624), // Very dark blue
          Color(0xFF000000), // Black
        ],
      );
    }
  }

  static String getTimeOfDayText(int hour) {
    if (hour >= 5 && hour < 7) {
      return "Dawn";
    } else if (hour >= 7 && hour < 10) {
      return "Morning";
    } else if (hour >= 10 && hour < 16) {
      return "Day";
    } else if (hour >= 16 && hour < 18) {
      return "Evening";
    } else if (hour >= 18 && hour < 20) {
      return "Dusk";
    } else if (hour >= 20 && hour < 23) {
      return "Night";
    } else {
      return "Midnight";
    }
  }

  static Color getTimeBasedAccentColor(int hour) {
    if (hour >= 5 && hour < 7) {
      return const Color(0xFF4A90E2); // Dawn blue
    } else if (hour >= 7 && hour < 10) {
      return const Color(0xFF87CEEB); // Morning sky blue
    } else if (hour >= 10 && hour < 16) {
      return const Color(0xFF6495ED); // Day blue
    } else if (hour >= 16 && hour < 18) {
      return const Color(0xFFFF7F50); // Evening coral
    } else if (hour >= 18 && hour < 20) {
      return const Color(0xFF8B4513); // Dusk brown
    } else if (hour >= 20 && hour < 23) {
      return const Color(0xFF2D1B69); // Night purple
    } else {
      return const Color(0xFF191970); // Midnight blue
    }
  }

  static String getTimeBasedGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 7) {
      return AppStrings.greetingDawn;
    } else if (hour >= 7 && hour < 10) {
      return AppStrings.greetingMorning;
    } else if (hour >= 10 && hour < 16) {
      return AppStrings.greetingDay;
    } else if (hour >= 16 && hour < 18) {
      return AppStrings.greetingEvening;
    } else if (hour >= 18 && hour < 20) {
      return AppStrings.greetingDusk;
    } else if (hour >= 20 && hour < 23) {
      return AppStrings.greetingNight;
    } else {
      return AppStrings.greetingMidnight;
    }
  }
}

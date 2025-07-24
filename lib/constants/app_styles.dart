import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.black54,
  );

  static const TextStyle body = TextStyle(fontSize: 16, color: Colors.black87);
}

class AppButtonStyles {
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.blue,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );

  static final ButtonStyle secondaryButton = OutlinedButton.styleFrom(
    foregroundColor: Colors.blue,
    side: const BorderSide(color: Colors.blue),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  );
}

class AppInputStyles {
  static final InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.blue),
    ),
    hintStyle: const TextStyle(color: Colors.grey),
  );
}

class AppGradients {
  /// Creates a vertical gradient from top to bottom
  static LinearGradient createVerticalGradient(List<Color> colors) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: colors,
    );
  }

  /// Creates a horizontal gradient from left to right
  static LinearGradient createHorizontalGradient(List<Color> colors) {
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: colors,
    );
  }

  /// Creates a diagonal gradient from top-left to bottom-right
  static LinearGradient createDiagonalGradient(List<Color> colors) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
    );
  }

  /// Creates a custom gradient with specified begin and end alignments
  static LinearGradient createCustomGradient({
    required List<Color> colors,
    Alignment begin = Alignment.topCenter,
    Alignment end = Alignment.bottomCenter,
    List<double>? stops,
  }) {
    return LinearGradient(begin: begin, end: end, colors: colors, stops: stops);
  }

  // Predefined gradients for common use cases
  static LinearGradient get purpleGradient => createVerticalGradient([
    const Color(0xFF6A5ACD), // Slate blue
    const Color(0xFF9370DB), // Medium purple
    const Color(0xFFBA55D3), // Medium orchid
  ]);

  static LinearGradient get blueGradient => createVerticalGradient([
    const Color(0xFF4A90E2),
    const Color(0xFF50C9C3),
  ]);

  static LinearGradient get sunsetGradient => createVerticalGradient([
    const Color(0xFFFF7E5F),
    const Color(0xFFFEB47B),
  ]);
}

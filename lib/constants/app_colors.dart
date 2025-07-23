import 'package:flutter/material.dart';

import '../utilities/size_config.dart';

class AppColors {
  static const MaterialColor primarySwatch = Colors.red;

  static const Color primaryColor = Color(0xFF8DAB71);
  static const Color primaryColorTrans = Color(0xFF3A6E69);

  static const Color primaryDarkColor = Color(0xFF5B8C7A);
  static const Color grayDark = Color(0xFF4A4A4A);
  static const Color grayLight = Color(0xFFBDBDBD);
  static const Color textFieldLightColor = Color(0xFFF5F5F5);

  static const Color textFieldDarkColor = Color(0xFF2C2C2C);
  static const Color textFieldDarkColorTrans = Color(0xFF1A1A1A);
  static const Color textFieldLightColorTrans = Color(0xFFF5F5F5);
}

class AppTheme {
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
    ThemeMode.system,
  );
  static ThemeData get currentTheme {
    return themeModeNotifier.value == ThemeMode.light ? lightTheme : darkTheme;
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepPurple,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );
  }

  static ThemeData getLightTheme() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryDarkColor,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        // seedColor: AppColors.primaryColor,
        secondary: AppColors.grayDark,
        primary: AppColors.primaryColor,
      ),
      tabBarTheme: TabBarThemeData(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.grayLight;
          }
          return null;
        }),
        labelColor: Colors.black,
        unselectedLabelColor: AppColors.grayDark,
      ),
      // fontFamily: AppTypography.fontFamily,
      buttonTheme: const ButtonThemeData(buttonColor: AppColors.primaryColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
        ),
      ),
      splashColor: AppColors.primaryColor,
      // scaffoldBackgroundColor: Colors.white,
      focusColor: AppColors.primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: AppColors.grayDark,
          fontSize: SizeConfig.textMultiplier * 2,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: SizeConfig.textMultiplier * 2,
        ),
        filled: true,
        fillColor: AppColors.textFieldLightColor.withValues(alpha: 0.15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.imageSizeMultiplier * 2.2),
          ),

          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.imageSizeMultiplier * 2.2),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
        // // titleTextStyle: AppTypography.poppinsBold.copyWith(
        //   color: Colors.white,
        //   fontSize: SizeConfig.textMultiplier * 2.4,
        // ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizeConfig.imageSizeMultiplier * 0.9,
          ),
        ),
        side: BorderSide(
          color: AppColors.primaryColor,
          width: SizeConfig.widthMultiplier * 0.25,
        ),
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.textFieldLightColor.withValues(alpha: 0.15);
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
      ),
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryDarkColor,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        // seedColor: AppColors.primaryColor,
        secondary: AppColors.grayDark,
        primary: AppColors.primaryColor,
      ),
      tabBarTheme: TabBarThemeData(
        overlayColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.pressed)) {
            return AppColors.grayLight;
          }
          return null;
        }),
        labelColor: Colors.black,
        unselectedLabelColor: AppColors.grayDark,
      ),
      // fontFamily: AppTypography.fontFamily,
      buttonTheme: const ButtonThemeData(buttonColor: AppColors.primaryColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.primaryColor),
        ),
      ),
      splashColor: AppColors.primaryColor,
      // scaffoldBackgroundColor: Colors.white,
      focusColor: AppColors.primaryColor,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: AppColors.grayDark,
          fontSize: SizeConfig.textMultiplier * 2,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: SizeConfig.textMultiplier * 2,
        ),
        filled: true,
        fillColor: AppColors.textFieldDarkColor.withValues(alpha: 0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.imageSizeMultiplier * 2.2),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.imageSizeMultiplier * 2.2),
          ),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
        // titleTextStyle: AppTypography.poppinsBold.copyWith(
        //   color: Colors.white,
        //   fontSize: SizeConfig.textMultiplier * 2.4,
        // ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            SizeConfig.imageSizeMultiplier * 0.9,
          ),
        ),
        side: BorderSide(
          color: AppColors.primaryColor,
          width: SizeConfig.widthMultiplier * 0.25,
        ),
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.textFieldLightColor.withValues(alpha: 0.15);
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
      ),
    );
  }
}

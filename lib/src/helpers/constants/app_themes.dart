import 'package:flutter/material.dart';

// Helpers
import 'app_colors.dart';
import 'app_typography.dart';

/// A utility class that holds themes for the app. It controls
/// how the app looks on different platforms like android, ios etc.
///
/// This class has no constructor and all methods are `static`.
@immutable
class AppThemes {
  const AppThemes._();

  /// The main starting theme for the app.
  ///
  /// Sets the following defaults:
  /// * primaryColor: [AppColors.primaryColor],
  ///
  /// * fontFamily: [AppTypography.primary].fontFamily,
  ///
  /// * textTheme: [AppTypography.primary].textTheme
  ///
  /// * iconTheme: [Colors.white] for default icon
  ///
  /// * textButtonTheme: [TextButtonTheme] without the default padding,
  static final mainTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.primaryColor,
      onPrimary: AppColors.textWhite80Color,
      secondary: AppColors.secondaryColor,
      onSecondary: AppColors.textBlackColor,
      tertiary: AppColors.tertiaryColor,
      onTertiary: AppColors.textGreyColor,
      background: AppColors.backgroundColor,
      onBackground: AppColors.textWhite80Color,
      surface: AppColors.surfaceColor,
      onSurface: AppColors.textWhite80Color,
      error: AppColors.redColor,
      onError: AppColors.textWhite80Color,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      showUnselectedLabels: true,
      unselectedLabelStyle: TextStyle(
        color: AppColors.textWhite80Color,
        fontSize: 14,
      ),
      selectedLabelStyle: TextStyle(
        color: AppColors.textWhite80Color,
        fontSize: 14,
      ),
      backgroundColor: AppColors.backgroundColor,
    ),
    fontFamily: AppTypography.primaryFontFamily,
    textTheme: AppTypography.primary,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: AppColors.fieldFillColor,
    ),
    chipTheme: const ChipThemeData(
      backgroundColor: AppColors.fieldFillColor,
      selectedColor: AppColors.primaryColor,
      labelStyle: TextStyle(
        fontSize: 13,
        color: AppColors.textBlackColor,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.surfaceColor,
      titleTextStyle: AppTypography.primary.displayMedium,
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}

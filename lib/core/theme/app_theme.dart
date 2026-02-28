import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/text_theme.dart';

class AppTheme {
  static ThemeData lightTheme = commonTheme.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: Typography.blackMountainView
        .merge(appTextTheme)
        .apply(bodyColor: Colors.black, displayColor: Colors.black),
    bottomSheetTheme:
        commonTheme.bottomSheetTheme.copyWith(backgroundColor: Colors.white),
    appBarTheme: commonTheme.appBarTheme
        .copyWith(backgroundColor: Colors.white, foregroundColor: Colors.black),
    inputDecorationTheme: commonTheme.inputDecorationTheme
        .copyWith(fillColor: const Color(0xFFF1F1F1)),
    colorScheme: lightColorScheme,
    canvasColor: Colors.white,
    tabBarTheme:  TabBarThemeData(
      unselectedLabelColor: Colors.grey,
      labelColor: const Color(0xFF11142D),
      indicatorSize: TabBarIndicatorSize.label,
    ),
  );

  static ThemeData darkTheme = commonTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    textTheme: Typography.blackMountainView
        .merge(appTextTheme)
        .apply(bodyColor: Colors.white, displayColor: Colors.white),
    bottomSheetTheme: commonTheme.bottomSheetTheme
        .copyWith(backgroundColor: AppColors.mediumGray),
    appBarTheme: commonTheme.appBarTheme.copyWith(
        backgroundColor: const Color(0xFF242731),
        foregroundColor: Colors.white),
    inputDecorationTheme: commonTheme.inputDecorationTheme.copyWith(
      fillColor: AppColors.lightGray.withOpacity(.10),
    ),
    colorScheme: dartColorScheme,
    dividerColor: const Color(0xFFF0F3F6).withOpacity(.1),
    canvasColor: const Color(0xFF2D2F35),
    tabBarTheme: const TabBarThemeData(
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
    ),
  );
}

final commonTheme = ThemeData(
  useMaterial3: false,
  appBarTheme: const AppBarTheme(elevation: 0),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
    filled: true,
    hintStyle: const TextStyle(color: AppColors.textGray),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(18),
      foregroundColor: Colors.white,
    ),
  ),
);

const lightColorScheme = ColorScheme.light(primary: Color(0xFF6C5DD3));
const dartColorScheme = ColorScheme.dark(primary: Color(0xFF6C5DD3));

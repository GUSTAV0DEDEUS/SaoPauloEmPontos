import 'package:flutter/material.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';
import 'package:sp_pontos/core/styles/theme/custom/appbar_theme.dart';
import 'package:sp_pontos/core/styles/theme/custom/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: LAppBarTheme.lightAppBarTheme,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.lightBlue),
    textTheme: AppTextTheme.whiteTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: LAppBarTheme.darkAppBarTheme,
    scaffoldBackgroundColor: AppColors.black,
    textTheme: AppTextTheme.blackTheme,
  );
}

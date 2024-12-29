import 'package:flutter/material.dart';
import 'package:sp_pontos/core/styles/app_colors.dart';

class LAppBarTheme {
  LAppBarTheme._();

  static AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.white,
  );
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    backgroundColor: AppColors.black,
    foregroundColor: AppColors.black,
  );
}

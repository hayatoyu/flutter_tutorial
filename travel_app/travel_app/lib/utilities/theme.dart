import 'package:flutter/material.dart';
import 'package:travel_app/allConstants/allconstants.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.spaceCadet,
  scaffoldBackgroundColor: AppColors.white,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.spaceCadet),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.burgundy)
);
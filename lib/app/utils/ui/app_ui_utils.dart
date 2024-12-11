import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

class AppUIUtils {
  static double get primaryRadius => 10;

  static BorderRadius get primaryBorderRadius =>
      BorderRadius.circular(primaryRadius);

  static BorderRadius get homeBorderRadius => BorderRadius.circular(15);

  static BorderRadius get circleRadius => BorderRadius.circular(100);

  static BorderRadius get bottomNavBarRadius => BorderRadius.circular(0);

  static BorderRadius get loginBorderRadius => BorderRadius.circular(30);

  static double get productHeight => 170;

  static double get homeIconSize => 36;

  static double get homeScreenCardHeight => 120;

  static double get headerShadowElevation => 4;

  static double dropdownFontSize = TextStyles.k18FontSize;

  static TextStyle globalTextStyle = TextStyles.kPrimaryBoldPublicSans(
    fontSize: TextStyles.k18FontSize,
    colors: mColorPrimaryText,
  );
}

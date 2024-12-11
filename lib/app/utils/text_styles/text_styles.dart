// ignore_for_file: constant_identifier_names

import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:flutter/material.dart';

class Font {
  static const Inter = "Inter";
  static const InterBold = "InterBold";
  static const InterExtraBold = "InterExtraBold";
  static const InterMedium = "InterMedium";
  static const InterRegular = "InterRegular";
  static const InterSemiBold = "InterSemiBold";

  static const PublicSans = "PublicSans";
  static const PublicSansBold = "PublicSansBold";
  static const PublicSansExtraBold = "PublicSansExtraBold";
  static const PublicSansMedium = "PublicSansMedium";
  static const PublicSansRegular = "PublicSansRegular";
  static const PublicSansSemiBold = "PublicSansSemiBold";
}

class TextStyles {
  static const double k10FontSize = 10;
  static const double k12FontSize = 12;
  static const double k14FontSize = 14;
  static const double k16FontSize = 16;

  static const double k18FontSize = 18;
  static const double k20FontSize = 20;
  static const double k22FontSize = 22;

  static const double k24FontSize = 24;
  static const double k26FontSize = 26;
  static const double k28FontSize = 28;

  static const double k30FontSize = 30;
  static const double k32FontSize = 32;
  static const double k34FontSize = 34;
  static const double k36FontSize = 36;

  static TextStyle kPrimaryRegularInter({
    double fontSize = k14FontSize,
    Color colors = kColorPrimary,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: colors,
      fontWeight: fontWeight,
      fontFamily: Font.InterRegular,
    );
  }

  static TextStyle kPrimaryMediumInter({
    double fontSize = k14FontSize,
    Color colors = kColorPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: colors,
      fontWeight: fontWeight,
      fontFamily: Font.InterMedium,
    );
  }

  static TextStyle kPrimarySemiBoldInter({
    double fontSize = k14FontSize,
    Color colors = kColorPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: colors,
      fontWeight: fontWeight,
      fontFamily: Font.InterSemiBold,
    );
  }

  static TextStyle kPrimaryBoldInter({
    double fontSize = k36FontSize,
    Color colors = kColorPrimary,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: colors,
      fontWeight: fontWeight,
      fontFamily: Font.InterBold,
    );
  }

  static TextStyle kPrimaryRegularPublicSans({
    double fontSize = k14FontSize,
    Color colors = kColorPrimary,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: colors,
      fontWeight: fontWeight,
      fontFamily: Font.PublicSansRegular,
    );
  }

  static TextStyle kPrimaryMediumPublicSans({
    double fontSize = k14FontSize,
    Color colors = kColorPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: colors,
      fontWeight: fontWeight,
      fontFamily: Font.PublicSansMedium,
    );
  }

  static TextStyle kPrimarySemiBoldPublicSans({
    double fontSize = k14FontSize,
    Color colors = kColorPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: colors,
      fontWeight: fontWeight,
      fontFamily: Font.PublicSansSemiBold,
    );
  }

  static TextStyle kPrimaryBoldPublicSans({
    double fontSize = k36FontSize,
    Color colors = kColorPrimary,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: colors,
      fontWeight: fontWeight,
      fontFamily: Font.PublicSansBold,
    );
  }
}

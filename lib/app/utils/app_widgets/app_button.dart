import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
Widget appButton({
  required VoidCallback onPressed,
  String? buttonText,
  Color? textColor,
  Color? buttonColor,
  Color? buttonBorderColor,
  double? buttonHeight,
  Widget? buttonIcon,
  double? buttonWidth,
  TextStyle? textStyle,
  double? borderRadius,
  bool? isGradient,
  List<Color>? gradientColors,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: buttonHeight ?? 52,
      width: buttonWidth ?? Get.width,
      decoration: isGradient == true
          ? _gradientDecoration(
          gradientColors, buttonColor, borderRadius, buttonBorderColor)
          : _simpleDecoration(buttonColor, borderRadius, buttonBorderColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText ?? "",
            style: textStyle ??
                TextStyles.kPrimaryBoldInter(fontSize: TextStyles.k24FontSize),
            // Theme.of(Get.context!)
            //     .textTheme
            //     .labelLarge
            //     ?.copyWith(color: kColorWhite, fontWeight: FontWeight.w600),
          ),
          buttonIcon != null ? const SizedBox(width: 10) : Container(),
          buttonIcon ?? const SizedBox()
        ],
      ),
    ),
  );
}

_simpleDecoration(buttonColor, borderRadius, buttonBorderColor) {
  return BoxDecoration(
    color: buttonColor ??kColorSecondPrimary,
    borderRadius:
    BorderRadius.circular(borderRadius ?? AppUIUtils.primaryRadius),
    border: Border.all(
        color: buttonBorderColor ?? kColorSecondPrimary,
        width: 2),
  );
}

_gradientDecoration(
    gradientColors, buttonColor, borderRadius, buttonBorderColor) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: gradientColors ?? [kColorWhite, kColorBlack],
    ),
    color: buttonColor ?? Theme.of(Get.context!).primaryColor,
    borderRadius:
    BorderRadius.circular(borderRadius ?? AppUIUtils.primaryRadius),
    border: Border.all(
        color: buttonBorderColor ?? Theme.of(Get.context!).primaryColor,
        width: 2),
  );
}

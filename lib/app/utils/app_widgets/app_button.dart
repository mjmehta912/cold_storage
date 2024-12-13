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
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(
          borderRadius ?? AppUIUtils.primaryRadius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText ?? "",
            style: textStyle ??
                TextStyles.kPrimaryBoldPublicSans(
                  fontSize: TextStyles.k20FontSize,
                  colors: textColor ?? mColorBackground,
                ),
          ),
          buttonIcon != null
              ? const SizedBox(
                  width: 10,
                )
              : Container(),
          buttonIcon ?? const SizedBox()
        ],
      ),
    ),
  );
}

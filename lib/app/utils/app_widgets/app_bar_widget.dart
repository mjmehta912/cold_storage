import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/back_button_with_text.dart';
import 'package:flutter/material.dart';

AppBar appBarWidget({
  required BuildContext context,
  required String titleText,
  required VoidCallback onTap,
  Widget? actions,
  Color? shadowColor,
  double? elevation,
  bool isShowBackButton = true,
  bool automaticallyImplyLeading = false,
}) {
  return AppBar(
    automaticallyImplyLeading: automaticallyImplyLeading,
    surfaceTintColor: mColorAppbar,
    backgroundColor: mColorAppbar,
    shadowColor: shadowColor ?? mColorBlack,
    elevation: elevation ?? 0,
    centerTitle: false,
    leadingWidth: automaticallyImplyLeading ? 15 : 0,
    actions: [
      actions ??
          const SizedBox(
            width: 0,
          ),
    ],
    title: backButtonWithText(
      context,
      text: titleText,
      onTap: onTap,
      isShowBackButton: isShowBackButton,
    ),
  );
}

import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

backButtonWithText(
  BuildContext context, {
  required Function() onTap,
  String? text,
  bool isShowBackButton = true,
  double? fontSize,
}) {
  return Row(
    children: [
      if (isShowBackButton)
        IconButton(
          onPressed: onTap,
          icon: SvgPicture.asset(
            kIconBackArrow,
            height: 15,
            width: 15,
          ),
        ),
      AppSpaces.h10,
      AppText(
        text: text ?? '',
        style: TextStyles.kPrimarySemiBoldPublicSans(
          fontSize: fontSize ?? TextStyles.k18FontSize,
          colors: mColorPrimaryText,
        ),
      ),
    ],
  );
}

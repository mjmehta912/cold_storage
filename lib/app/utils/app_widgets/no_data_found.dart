import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

noDataFound({required String text}) {
  return Center(
    child: AppText(
      text: text,
      style: TextStyles.kPrimarySemiBoldPublicSans(
        fontSize: TextStyles.k18FontSize,
        colors: mColorPrimaryText,
      ),
    ),
  );
}

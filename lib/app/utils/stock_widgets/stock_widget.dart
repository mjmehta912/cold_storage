import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';

Widget titleWidget(
  String text, {
  Color? bgColor = mColorAppbar,
  Color? textColor = mColorBlack,
}) {
  return Card(
    elevation: 5,
    child: Container(
      width: 1.screenWidth,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppText(
        text: text,
        style: TextStyles.kPrimaryBoldPublicSans(
          fontSize: TextStyles.k16FontSize,
          colors: mColorPrimaryText,
        ),
      ),
    ),
  );
}

Widget subTitleWidget(
  String text, {
  Color? bgColor = mColorAppbar,
  Color? textColor = mColorBlack,
}) {
  return Card(
    elevation: 5,
    child: Container(
      width: 1.screenWidth,
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppText(
        text: text,
        style: TextStyles.kPrimaryBoldPublicSans(
          fontSize: TextStyles.k16FontSize,
          colors: mColorPrimaryText,
        ),
      ),
    ),
  );
}

Widget bottomTitleWidget(
  String title,
  String price, {
  Color? color,
  TextStyle? textStyle,
}) {
  return Container(
    width: 1.screenWidth,
    padding: const EdgeInsets.symmetric(
      vertical: 8,
      horizontal: 16,
    ),
    decoration: BoxDecoration(
      color: color ?? mColorAppbar,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 0.65.screenWidth,
          child: AppText(
            text: title,
            maxLines: 2,
            style: textStyle ??
                TextStyles.kPrimaryBoldPublicSans(
                  fontSize: TextStyles.k16FontSize,
                  colors: mColorPrimaryText,
                ),
          ),
        ),
        AppText(
          text: price,
          style: textStyle ??
              TextStyles.kPrimaryBoldPublicSans(
                fontSize: TextStyles.k16FontSize,
                colors: mColorPrimaryText,
              ),
        ),
      ],
    ),
  );
}

Widget subListText(
  String title,
  String value,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      AppText(
        text: title,
        style: TextStyles.kPrimaryRegularPublicSans(
          fontSize: TextStyles.k14FontSize,
          colors: mColorPrimaryText,
        ),
      ),
      AppText(
        text: value,
        style: TextStyles.kPrimaryBoldPublicSans(
          fontSize: TextStyles.k14FontSize,
          colors: mColorPrimaryText,
        ),
      ),
    ],
  );
}

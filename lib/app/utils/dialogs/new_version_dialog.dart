import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showNewVersionDialog(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: kColorBackground,
        surfaceTintColor: kColorBackground,
        insetPadding: const EdgeInsets.symmetric(horizontal: 0),
        shape: RoundedRectangleBorder(
          borderRadius: AppUIUtils.homeBorderRadius,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: kNewVersionDialogTitleText,
                align: TextAlign.center,
                style: TextStyles.kPrimarySemiBoldInter(
                  colors: kColorSecondPrimary,
                  fontSize: TextStyles.k18FontSize,
                ),
              ),
              AppSpaces.v20,
              appButton(
                onPressed: () async {
                  Get.back();
                },
                buttonWidth: 0.4.screenWidth,
                buttonText: kOkay,
              ),
            ],
          ),
        ),
      );
    },
  );
}

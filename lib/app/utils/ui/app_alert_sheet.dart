import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    required this.title,
    required this.alertText,
    required this.actionButtonText,
    required this.positiveClick,
    required this.negativeClick,
    super.key,
  });

  final String title;
  final String alertText;
  final String actionButtonText;
  final void Function() positiveClick;
  final void Function() negativeClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: mColorAppbar,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppUIUtils.primaryRadius),
          topRight: Radius.circular(AppUIUtils.primaryRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: title,
            style: TextStyles.kPrimaryBoldPublicSans(
              colors: mColorPrimaryText,
              fontSize: TextStyles.k28FontSize,
            ),
          ),
          AppSpaces.v8,
          AppText(
            text: alertText,
            style: TextStyles.kPrimarySemiBoldPublicSans(
              colors: mColorPrimaryText,
              fontSize: TextStyles.k20FontSize,
            ),
          ),
          AppSpaces.v32,
          Row(
            children: [
              Expanded(
                child: appButton(
                  onPressed: negativeClick,
                  buttonText: kNo,
                  textStyle: TextStyles.kPrimaryBoldPublicSans(
                    fontSize: TextStyles.k24FontSize,
                    colors: mColorPrimaryText,
                  ),
                ),
              ),
              AppSpaces.h20,
              Expanded(
                child: appButton(
                  onPressed: positiveClick,
                  buttonText: actionButtonText,
                  textStyle: TextStyles.kPrimaryBoldPublicSans(
                    fontSize: TextStyles.k24FontSize,
                    colors: mColorPrimaryText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

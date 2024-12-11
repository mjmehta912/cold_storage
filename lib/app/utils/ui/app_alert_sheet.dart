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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        color: kColorBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppUIUtils.primaryRadius),
          topRight: Radius.circular(AppUIUtils.primaryRadius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title,
          AppSpaces.v8,
          _alertText,
          AppSpaces.v32,
          _actions(context),
        ],
      ),
    );
  }

  Widget get _title {
    return AppText(
      text: title,
      style: TextStyles.kPrimaryBoldInter(
          colors: kColorSecondPrimary, fontSize: TextStyles.k28FontSize),
    );
  }

  Widget get _alertText {
    return AppText(
      text: alertText,
      style: TextStyles.kPrimarySemiBoldInter(
        colors: kColorSecondPrimary,
        fontSize: TextStyles.k20FontSize,
      ),
    );
  }

  Widget _actions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: appButton(
            onPressed: negativeClick,
            buttonText: kNo,
          ),
        ),
        AppSpaces.h20,
        Expanded(
          child: appButton(
            onPressed: positiveClick,
            buttonText: actionButtonText,
          ),
        ),
      ],
    );
  }
}

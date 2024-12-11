import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:flutter/material.dart';

class AppConfirmSheet extends StatelessWidget {
  const AppConfirmSheet({
    required this.title,
    required this.confirmText,
    required this.actionButtonText,
    required this.onConfirm,
    super.key,
  });

  final String title;
  final String confirmText;
  final String actionButtonText;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: kColorPrimary,
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
          _confirmText,
          AppSpaces.v32,
          _actions(context),
        ],
      ),
    );
  }

  Widget get _title {
    return AppText(
      text: title,
      style: TextStyles.kPrimaryRegularInter(colors: kColorWhite),
    );
  }

  Widget get _confirmText {
    return AppText(
      text: confirmText,
      style: TextStyles.kPrimaryRegularInter(colors: kColorWhite),
    );
  }

  Widget _actions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: appButton(
            onPressed: () {},
            buttonText: kNo,
          ),
        ),
        AppSpaces.h20,
        Expanded(
          child: appButton(
            onPressed: () {},
            buttonText: actionButtonText,
          ),
        ),
      ],
    );
  }
}

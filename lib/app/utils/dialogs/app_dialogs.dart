import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_alert_sheet.dart';
import 'package:cold_storage/app/utils/ui/app_confirm_sheet.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:flutter/material.dart';

class AppDialogs {
  static Future<void> selectDate({
    required BuildContext context,
    required void Function(DateTime? date) onSelected,
    required DateTime initialDate,
    required DateTime lastDate,
    required DateTime firstDate,
  }) async {
    ThemeData buildDatePickerTheme(BuildContext context) {
      return ThemeData.light().copyWith(
        primaryColor: mColorPrimaryText,
        colorScheme: const ColorScheme.light(
          primary: mColorPrimaryText,
          onPrimary: mColorBackground,
          surface: mColorBackground,
        ),
        dialogBackgroundColor: mColorBackground,
        textTheme: TextTheme(
          headlineMedium: TextStyles.kPrimaryBoldPublicSans(),
          bodyLarge: TextStyles.kPrimarySemiBoldPublicSans(
            fontSize: TextStyles.k18FontSize,
          ),
        ),
      );
    }

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (
        BuildContext context,
        Widget? child,
      ) {
        return Theme(
          data: buildDatePickerTheme(context),
          child: child!,
        );
      },
    );

    if (date == null) return;

    onSelected(date);
  }

  static Future<void> selectTime({
    required BuildContext context,
    required void Function(TimeOfDay? time) onSelected,
    required TimeOfDay initialTime,
  }) async {
    final time = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );

    if (time == null) return;

    onSelected(time);
  }

  static Future<void> alertSheet({
    required BuildContext context,
    required String title,
    required String alertText,
    required String actionButtonText,
    required void Function() positiveClick,
    required void Function() negativeClick,
  }) async {
    await _showBottomSheet(
      context: context,
      builder: (context) {
        return AppAlertDialog(
          title: title,
          alertText: alertText,
          actionButtonText: actionButtonText,
          negativeClick: negativeClick,
          positiveClick: positiveClick,
        );
      },
    );
  }

  static Future<void> confirmSheet({
    required BuildContext context,
    required String title,
    required String confirmText,
    required String actionButtonText,
    required void Function() onConfirm,
  }) async {
    await _showBottomSheet(
      context: context,
      builder: (context) {
        return AppConfirmSheet(
          title: title,
          confirmText: confirmText,
          actionButtonText: actionButtonText,
          onConfirm: onConfirm,
        );
      },
    );
  }

  static Future<void> _showBottomSheet({
    required BuildContext context,
    required Widget Function(BuildContext context) builder,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppUIUtils.primaryRadius),
          topRight: Radius.circular(AppUIUtils.primaryRadius),
        ),
      ),
      builder: builder,
    );
  }
}

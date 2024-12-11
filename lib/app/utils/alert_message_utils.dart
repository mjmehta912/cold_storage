import 'package:another_flushbar/flushbar.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class AlertMessageUtils {
  /// show success popup snackBar message
  void showSuccessSnackBar(String message) {
    Get.snackbar(
      'Success',
      message,
      titleText: AppText(
          text: 'Success',
          style: TextStyles.kPrimaryRegularInter(colors: kColorWhite)),
      messageText: AppText(
        text: message,
        style: TextStyles.kPrimaryRegularInter(colors: kColorWhite),
      ),
      snackPosition: SnackPosition.BOTTOM,
      colorText: kColorBlack,
      backgroundColor: kColorPrimary,
      margin: const EdgeInsets.all(12),
    );
  }

  /// show error popup snackBar message
  void showErrorSnackBar(String message) {
    Get.snackbar(
      'Error',
      message,
      titleText: AppText(
        text: 'Error',
        style: TextStyles.kPrimaryRegularInter(colors: kColorRedFF0000),
      ),
      messageText: AppText(
        text: message,
        style: TextStyles.kPrimaryRegularInter(colors: kColorWhite),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: kColorWhite,
      margin: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
    );
  }

  void showErrorSnackBar1(String text) {
    Flushbar<void>(
      message: text,
      messageText: AppText(
        text: text,
        style: TextStyles.kPrimaryRegularInter(colors: kColorWhite),
      ),
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      // leftBarIndicatorColor: Colors.white,
      duration: const Duration(seconds: 3),
      backgroundColor: kColorBlack,
    ).show(Get.context!);
  }

  void showSuccessSnackBar1(BuildContext context, String text) {
    Flushbar<void>(
      message: text,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      leftBarIndicatorColor: kColorWhite,
      duration: const Duration(seconds: 3),
      backgroundColor: kColorWhite,
      messageText: AppText(
        text: text,
        style: TextStyles.kPrimaryRegularInter(colors: kColorGreen48A300),
      ),
    ).show(context);
  }

  /// show circular progress bar
  void showProgressDialog() {
    try {
      showDialog(
          context: Get.overlayContext!,
          builder: (_) => WillPopScope(
                child: Container(
                  decoration: BoxDecoration(color: kColorWhite.withOpacity(.5)),
                  child: const SizedBox(
                    width: 60,
                    height: 60,
                    child: SpinKitFadingCircle(
                      color: kColorBlack,
                      size: 50.0,
                    ),
                  ),
                ),
                onWillPop: () async => false,
              ));
    } catch (e) {
      LoggerUtils.logException('showProgressDialog', e);
    }
  }

  /// hider circular progress bar
  void hideProgressDialog() {
    try {
      Navigator.of(Get.overlayContext!).pop();
    } catch (ex) {
      LoggerUtils.logException('hideProgressDialog', ex);
    }
  }
}

import 'dart:io';

import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateToNextScreen() async {
    try {
      try {
        AppConst.packageInfo = await PackageInfo.fromPlatform();
      } catch (e) {
        LoggerUtils.logException('splash screen : packageInfo', e);
      }
      if (Platform.isAndroid) {
        AppConst.androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
      } else {
        /// ios device info
      }

      bool? isLoggedIn =
          await Get.find<LocalStorage>().getBoolFromStorage(kStorageIsLoggedIn);
      if (isLoggedIn == true) {
        AppConst.userName = await Get.find<LocalStorage>()
            .getStringFromStorage(kStorageUserName);
        Get.offAllNamed(kRouteBottomNavView);
      } else {
        Get.offAllNamed(kRouteLoginView);
      }
    } catch (e) {
      LoggerUtils.logException('navigateToNextScreen', e);
    }
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        navigateToNextScreen();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: kColorSecondPrimary,
      body: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: appName,
              style: TextStyles.kPrimaryBoldInter(
                fontSize: TextStyles.k36FontSize,
                colors: kColorBackground,
              ),
            ),
            AppText(
              text: kSplashScreenText,
              style: TextStyles.kPrimaryRegularInter(
                fontSize: TextStyles.k36FontSize,
                colors: kColorBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

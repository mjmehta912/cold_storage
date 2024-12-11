import 'dart:io';

import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

clipToCopy({required String text}) {
  Clipboard.setData(ClipboardData(text: text));
  Get.find<AlertMessageUtils>()
      .showSuccessSnackBar('Copied!, Text copied to clipboard.');
}

Future<String?> getId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    // import 'dart:io'
    var iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.id; // unique ID on Android
  }
  return null;
}

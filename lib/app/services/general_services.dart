import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/utils/general/general_utils.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:get/get.dart';

class GeneralServices {
  static Future<String> getDeviceID() async {
    String deviceId = '';

    deviceId =
        await Get.find<LocalStorage>().getStringFromStorage(kStorageDeviceId);

    if (deviceId.isEmpty || deviceId == '') {
      deviceId = await getId() ?? '';
      return deviceId;
    } else {
      return deviceId;
    }
  }
}

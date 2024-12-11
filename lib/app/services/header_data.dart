import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:get/get.dart';

class HeaderData {
  Future<Map<String, String>> headers() async {
    try {
      var token =
          await Get.find<LocalStorage>().getStringFromStorage(kStorageToken);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      return headers;
    } catch (e) {
      LoggerUtils.logException('common headers', e);
    }
    return <String, String>{};
  }
}

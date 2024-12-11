import 'dart:convert';

import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/screens/auth/login/model/login_res_model.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:get/get.dart';

class SelectCompanyController extends GetxController {
  // RxString selectedCompany = ''.obs;
  Rx<LoginData> selectedCompany = LoginData().obs;
  RxList<LoginData> companiesList = List<LoginData>.empty(growable: true).obs;

  @override
  void onInit() {
    setCompanies();
    super.onInit();
  }

  Future<void> setCompanies() async {
    try {
      var localStrVal = await Get.find<LocalStorage>()
          .getStringFromStorage(kStorageUserCompanies);
      print('companies : ${jsonDecode(localStrVal)}');
      var decodedStr = jsonDecode(localStrVal);

      for (int i = 0; i < decodedStr.length; i++) {
        companiesList.add(LoginData.fromJson(decodedStr[i]));
      }

      // companiesList.addAll(Get.arguments);
    } catch (e) {
      LoggerUtils.logException('setCompanies', e);
    }
  }

  void navigateToBottomNavScreen() {
    String companyData = jsonEncode(selectedCompany.value.toJson());
    Get.find<LocalStorage>()
        .writeStringStorage(kStorageCompanyData, companyData);
    Get.find<LocalStorage>().writeBoolStorage(kStorageIsLoggedIn, true);
    Get.offAllNamed(kRouteBottomNavView);
  }
}

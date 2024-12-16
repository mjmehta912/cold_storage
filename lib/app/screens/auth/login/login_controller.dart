import 'dart:convert';

import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/repositories/auth_repo.dart';
import 'package:cold_storage/app/screens/auth/login/model/login_req_model.dart';
import 'package:cold_storage/app/screens/auth/login/model/login_res_model.dart';
import 'package:cold_storage/app/services/firebase_services.dart';
import 'package:cold_storage/app/utils/general/general_utils.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool visiblePassword = false.obs;
  RxBool isFromNotification = false.obs;

  FirebaseServices firebaseServices = FirebaseServices();

  @override
  void onInit() {
    setIntentData();
    Get.lazyPut(() => AuthRepo(), fenix: true);
    super.onInit();
  }

  @override
  void dispose() {
    formKey = GlobalKey<FormState>();
    super.dispose();
  }

  setIntentData() {
    try {
      if (Get.arguments == null) {
        isFromNotification.value = false;
      } else {
        isFromNotification.value = Get.arguments;
      }
    } catch (e) {
      LoggerUtils.logException('setIntentData - LoginController ', e);
    }
  }

  resetVariables() {
    mobileController.clear();
    passwordController.clear();
    formKey = GlobalKey<FormState>();
    update();
    visiblePassword.value = false;
  }

  void navigateToSelectCompanyScreen(List<LoginData> data) {
    Get.find<LocalStorage>()
        .writeStringStorage(kStorageUserCompanies, jsonEncode(data));
    resetVariables();
    Get.toNamed(kRouteSelectCompanyView, arguments: data);
  }

  void loginApiCall() async {
    try {
      String deviceId = await getId() ?? '';
      String fcmToken = await firebaseServices.getFCMToken();

      Get.find<LocalStorage>().writeStringStorage(
        kStorageDeviceId,
        deviceId,
      );
      LoginRequestModel requestModel = LoginRequestModel(
        mobileNo: mobileController.text.trim(),
        password: passwordController.text.trim(),
        deviceID: deviceId,
        fcmToken: fcmToken,
        version: '',
      );
      var res = await Get.find<AuthRepo>().loginApiCall(
        requestModel: requestModel,
      );

      if (res != null) {
        Get.find<LocalStorage>()
            .writeInStorage(kStorageUserID, res.userId ?? 0);
        Get.find<LocalStorage>()
            .writeStringStorage(kStorageUserName, res.userName ?? '');
        navigateToSelectCompanyScreen(res.data ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('loginApiCall', e);
    }
  }
}

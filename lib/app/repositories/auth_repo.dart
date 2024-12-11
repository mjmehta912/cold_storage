import 'dart:convert';

import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/services/response_codes.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/screens/auth/login/model/login_req_model.dart';
import 'package:cold_storage/app/screens/auth/login/model/login_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/user_register/model/req/user_reg_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/user_register/model/res/user_reg_res_model.dart';
import 'package:cold_storage/app/services/api_constants.dart';
import 'package:cold_storage/app/services/api_service.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/dialogs/app_dialogs.dart';
import 'package:cold_storage/app/utils/dialogs/change_device_dialog.dart';
import 'package:cold_storage/app/utils/dialogs/new_version_dialog.dart';
import 'package:get/get.dart';

class AuthRepo {
  Future<LoginResponseModel?> loginApiCall(
      {required LoginRequestModel requestModel}) async {
    try {
      requestModel.mobileModel =
          '${AppConst.androidDeviceInfo?.brand} ${AppConst.androidDeviceInfo?.manufacturer} ${AppConst.androidDeviceInfo?.model}';
      requestModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.login,
        requestModel: loginRequestModelToJson(requestModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode) {
          Get.find<AlertMessageUtils>()
              .showErrorSnackBar1(kErrorSubscriptionOver);
          // Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == detectedDiffDeviceIDStatusCode) {
          AppDialogs.alertSheet(
            context: Get.context!,
            title: kRequestForLogin,
            alertText: kRequestForLoginSubTxt,
            actionButtonText: 'Yes',
            negativeClick: () {
              Get.back();
            },
            positiveClick: () async {
              Get.back();
              showChangeDeviceReqDialog(Get.context!, requestModel);
              // await changeDeviceRequestApiCall(requestModel: requestModel);
            },
          );
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = loginResponseModelFromJson(res.body);
          if (decodedRes.success == true) {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
            return decodedRes;
          } else {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('loginApiCall', e);
    }
    return null;
  }

  Future<UserRegResModel?> userRegApiCall(
      {required UserRegReqModel requestModel}) async {
    try {
      requestModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.registerUser,
        requestModel: userRegReqModelToJson(requestModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = userRegResModelFromJson(res.body);
          if (decodedRes.success == true) {
            Get.find<AlertMessageUtils>()
                .showSuccessSnackBar1(Get.context!, decodedRes.message ?? '');
            return decodedRes;
          } else {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('loginApiCall', e);
    }
    return null;
  }

  Future<bool?> changeDeviceRequestApiCall(
      {required LoginRequestModel requestModel}) async {
    try {
      requestModel.mobileModel =
          '${AppConst.androidDeviceInfo?.brand} ${AppConst.androidDeviceInfo?.manufacturer} ${AppConst.androidDeviceInfo?.model}';
      requestModel.metadata?.mobileNo = requestModel.mobileNo ?? '';
      requestModel.metadata?.screen = 'notificationScreen';
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.changeDeviceRequest,
        requestModel: loginRequestModelToJson(requestModel),
      );

      if (res != null) {
        var decodedRes = jsonDecode(res.body);
        if (decodedRes['success'] == true) {
          Get.find<AlertMessageUtils>()
              .showSuccessSnackBar1(Get.context!, decodedRes['message'] ?? '');
          return true;
        } else {
          Get.find<AlertMessageUtils>()
              .showErrorSnackBar1(decodedRes['message'] ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('changeDeviceRequestApiCall', e);
    }
    return false;
  }
}

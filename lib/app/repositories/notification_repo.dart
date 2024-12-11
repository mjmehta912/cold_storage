import 'dart:convert';

import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/general_model/req/general_req_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/screens/dashboard/notification/model/res/change_device_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/notification/model/res/change_device_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/notification/model/res/notification_res.dart';
import 'package:cold_storage/app/services/api_constants.dart';
import 'package:cold_storage/app/services/api_service.dart';
import 'package:cold_storage/app/services/response_codes.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/dialogs/new_version_dialog.dart';
import 'package:get/get.dart';

class NotificationRepo {
  Future<NotificationResModel?> getNotificationApiCall(
      {required GeneralReqModel reqModel}) async {
    try {
      reqModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.getNotification,
        requestModel: generalReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = notificationResModelFromJson(res.body);
          return decodedRes;
        }
      }
    } catch (e) {
      LoggerUtils.logException('getNotificationApiCall', e);
    }
    return null;
  }

  Future<bool?> changeDeviceRequestApiCall(
      {required ChangeDeviceReqModel requestModel}) async {
    try {
      requestModel.metadata?.mobileNo = requestModel.mobileNo ?? '';
      requestModel.metadata?.mobileNo = requestModel.mobileNo ?? '';
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.changeDeviceRequest,
        requestModel: changeDeviceReqModelToJson(requestModel),
      );

      if (res != null) {
        var decodedRes = jsonDecode(res.body);
        if (decodedRes['success'] == true) {
          Get.find<AlertMessageUtils>()
              .showSuccessSnackBar1(Get.context!, decodedRes['message'] ?? '');
          return true;
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
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

  Future<bool?> changeDeviceResponseApiCall(
      {required ChangeDeviceResModel requestModel}) async {
    try {
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.changeDeviceResponse,
        requestModel: changeDeviceResModelToJson(requestModel),
      );

      if (res != null) {
        var decodedRes = jsonDecode(res.body);
        if (decodedRes['success'] == true) {
          Get.find<AlertMessageUtils>()
              .showSuccessSnackBar1(Get.context!, decodedRes['message'] ?? '');
          return true;
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          Get.find<AlertMessageUtils>()
              .showErrorSnackBar1(decodedRes['message'] ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('changeDeviceResponseApiCall', e);
    }
    return false;
  }
}

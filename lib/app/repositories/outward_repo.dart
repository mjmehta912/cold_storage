import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/services/response_codes.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/general_model/req/general_req_model.dart';
import 'package:cold_storage/app/general_model/res/general_res_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/screens/dashboard/outward_details/model/req/authorized_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/outward_details/model/res/outward_details_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/model/req/outward_place_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/model/res/inward_no_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/model/res/lot_balance_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/model/res/lot_no_res_model.dart';
import 'package:cold_storage/app/services/api_constants.dart';
import 'package:cold_storage/app/services/api_service.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/dialogs/new_version_dialog.dart';
import 'package:get/get.dart';

class OutwardRepo {
  Future<InwardNoResModel?> getInwardNoFromServer(
      {required GeneralReqModel reqModel}) async {
    try {
      reqModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.getInwardNos,
        requestModel: generalReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = inwardNoResModelFromJson(res.body);
          if (decodedRes.data != null) {
            return decodedRes;
          } else {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('getInwardNoFromServer', e);
    }
    return null;
  }

  Future<LotNoResModel?> getLotNoFromServer(
      {required GeneralReqModel reqModel}) async {
    try {
      reqModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.getLotNos,
        requestModel: generalReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = lotNoResModelFromJson(res.body);
          if (decodedRes.data != null) {
            return decodedRes;
          } else {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('getLotNoFromServer', e);
    }
    return null;
  }

  Future<LotBalanceResModel?> getLotBalanceFromServer(
      {required GeneralReqModel reqModel}) async {
    try {
      reqModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.getLotBalance,
        requestModel: generalReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = lotBalanceResModelFromJson(res.body);
          if (decodedRes.data != null) {
            return decodedRes;
          } else {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('getLotBalanceFromServer', e);
    }
    return null;
  }

  Future<OutwardDetailsResModel?> getOutwardDetailsFromServer(
      {required GeneralReqModel reqModel}) async {
    try {
      reqModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.getAllRequests,
        requestModel: generalReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = outwardDetailsResModelFromJson(res.body);
          if (decodedRes.data != null) {
            return decodedRes;
          } else {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('getOutwardDetailsFromServer', e);
    }
    return null;
  }

  Future<GeneralResModel?> authReqForOutwardDetailsApiCall(
      {required AuthorizedReqModel reqModel}) async {
    try {
      reqModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.authoriseRequest,
        requestModel: authorizedReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = generalResModelFromJson(res.body);
          return decodedRes;
        }
      }
    } catch (e) {
      LoggerUtils.logException('authReqForOutwardDetailsApiCall', e);
    }
    return null;
  }

  Future<GeneralResModel?> placeRequestApiCall(
      {required OutwardPlaceReqModel reqModel}) async {
    try {
      reqModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.placeRequest,
        requestModel: outwardPlaceReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = generalResModelFromJson(res.body);
          return decodedRes;
        }
      }
    } catch (e) {
      LoggerUtils.logException('placeRequestApiCall', e);
    }
    return null;
  }
}

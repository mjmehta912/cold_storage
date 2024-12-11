import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/services/response_codes.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/general_model/req/cust_req_model.dart';
import 'package:cold_storage/app/general_model/res/cust_model.dart';
import 'package:cold_storage/app/general_model/req/items_req_model.dart';
import 'package:cold_storage/app/general_model/res/items_res_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/services/api_constants.dart';
import 'package:cold_storage/app/services/api_service.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/dialogs/new_version_dialog.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:get/get.dart';

class GeneralRepo {
  Future<ItemsResModel?> getItemsFromServer(
      {required List<String> pCodes}) async {
    try {
      var reqModel = ItemsReqModel(
        pCodes: pCodes.join(','),
        dbName: AppConst.companyData.value.dbName ?? '',
        coCode: AppConst.companyData.value.coCode ?? 0,
      );
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.getItems,
        requestModel: itemsReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = itemsResModelFromJson(res.body);
          if (decodedRes.data != null) {
            return decodedRes;
          } else {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('getItemsFromServer', e);
    }
    return null;
  }

  Future<CustResModel?> getCustomersFromServer() async {
    try {
      int userId =
          await Get.find<LocalStorage>().getIntFromStorage(kStorageUserID);
      var reqModel = CustReqModel(
        userId: userId,
        panNo: AppConst.companyData.value.panno ?? '0',
      );
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.getCustomer,
        requestModel: custReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = custResModelFromJson(res.body);
          if (decodedRes.data != null) {
            return decodedRes;
          } else {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('getCustomersFromServer', e);
    }
    return null;
  }
}

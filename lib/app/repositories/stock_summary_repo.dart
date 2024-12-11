import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/services/response_codes.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/req/get_inward_stock_ledger_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/details/model/res/stock_summary_details_res_model.dart';
import 'package:cold_storage/app/services/api_constants.dart';
import 'package:cold_storage/app/services/api_service.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/dialogs/new_version_dialog.dart';
import 'package:get/get.dart';

class StockSummaryRepo {
  Future<StockSummaryDetailsResModel?> getStockSummaryDetailFromServer(
      {required GetInwardStockLedgerReqModel reqModel}) async {
    try {
      reqModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.getStockSummaryDetails,
        requestModel: getInwardStockLedgerReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = stockSummaryDetailsResModelFromJson(res.body);
          if (decodedRes.data != null) {
            return decodedRes;
          } else {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('getStockSummaryDetailFromServer', e);
    }
    return null;
  }
}

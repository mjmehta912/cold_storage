import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/services/response_codes.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/req/get_inward_stock_ledger_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/details/model/stock_ledger_report_res_model.dart';
import 'package:cold_storage/app/services/api_constants.dart';
import 'package:cold_storage/app/services/api_service.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/dialogs/new_version_dialog.dart';
import 'package:get/get.dart';

class StockLedgerRepo {
  Future<StockLedgerReportResModel?> getStockLedgerDetailFromServer(
      {required GetInwardStockLedgerReqModel reqModel}) async {
    try {
      reqModel.version = AppConst.packageInfo?.version;
      var res = await ApiService().postRequest(
        endPoint: ApiConstants.getStockLedgerDetails,
        requestModel: getInwardStockLedgerReqModelToJson(reqModel),
      );

      if (res != null) {
        if (res.statusCode == subscriptionOverStatusCode ||
            res.statusCode == detectedDiffDeviceIDStatusCode) {
          Get.offAllNamed(kRouteLoginView);
        } else if (res.statusCode == newVersionRequiredStatusCode) {
          showNewVersionDialog(Get.context!);
        } else {
          var decodedRes = stockLedgerReportResModelFromJson(res.body);
          if (decodedRes.data != null) {
            return decodedRes;
          } else {
            Get.find<AlertMessageUtils>()
                .showErrorSnackBar1(decodedRes.message ?? '');
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('getStockLedgerDetailFromServer', e);
    }
    return null;
  }
}
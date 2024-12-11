import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/repositories/stock_ledger_repo.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/req/get_inward_stock_ledger_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/details/model/stock_ledger_report_res_model.dart';
import 'package:cold_storage/app/services/general_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockLedgerReportDetailController extends GetxController {
  GetInwardStockLedgerReqModel? inwardStockLedgerReqModel;
  RxList<StockLedgerReportData> stockLedgerReportDataList =
      List<StockLedgerReportData>.empty(growable: true).obs;

  RxBool isDataLoading = true.obs;

  @override
  void onInit() {
    Get.lazyPut(() => StockLedgerRepo(), fenix: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getArguments();
    });
    super.onInit();
  }

  getArguments() async {
    try {
      inwardStockLedgerReqModel = Get.arguments;
      await getInwardStockLedgerReportDetailsFromServer();
    } catch (e) {
      LoggerUtils.logException('getArguments InwardStockLedger', e);
    }
  }

  getInwardStockLedgerReportDetailsFromServer() async {
    try {
      // inwardStockLedgerReqModel?.fromDate = '2018-04-01';
      // inwardStockLedgerReqModel?.toDate = '2024-05-30';
      // inwardStockLedgerReqModel?.viewBy = 0;
      // inwardStockLedgerReqModel?.pCodes = 'A00023';
      // inwardStockLedgerReqModel?.iCodes = '';
      // inwardStockLedgerReqModel?.invno = '';
      // inwardStockLedgerReqModel?.dbName= 'HIMALAYA';
      // inwardStockLedgerReqModel?.coCode = 81;
      inwardStockLedgerReqModel?.deviceID = await GeneralServices.getDeviceID();
      isDataLoading.value = true;
      var res = await Get.find<StockLedgerRepo>()
          .getStockLedgerDetailFromServer(reqModel: inwardStockLedgerReqModel!);

      if (res != null && res.data != null) {
        stockLedgerReportDataList.addAll(res.data ?? []);
      }
      isDataLoading.value = false;
    } catch (e) {
      isDataLoading.value = false;
      LoggerUtils.logException(
          'getInwardStockLedgerReportDetailsFromServer', e);
    }
  }
}

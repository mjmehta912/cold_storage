import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/repositories/stock_summary_repo.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/req/get_inward_stock_ledger_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/details/model/res/stock_summary_details_res_model.dart';
import 'package:cold_storage/app/services/general_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockSummaryDetailController extends GetxController {
  GetInwardStockLedgerReqModel? inwardStockLedgerReqModel;
  RxList<StockSummaryDetailData> stockSummaryDataList =
      List<StockSummaryDetailData>.empty(growable: true).obs;

  RxBool isDataLoading = true.obs;

  @override
  void onInit() {
    Get.lazyPut(() => StockSummaryRepo(), fenix: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getArguments();
    });
    super.onInit();
  }

  getArguments() async {
    try {
      inwardStockLedgerReqModel = Get.arguments;
      await getStockSummaryDetailsDetailsFromServer();
    } catch (e) {
      LoggerUtils.logException('getArguments InwardStockLedger', e);
    }
  }

  getStockSummaryDetailsDetailsFromServer() async {
    try {
      isDataLoading.value = true;
      inwardStockLedgerReqModel?.deviceID = await GeneralServices.getDeviceID();
      var res = await Get.find<StockSummaryRepo>()
          .getStockSummaryDetailFromServer(
              reqModel: inwardStockLedgerReqModel!);

      if (res != null && res.data != null) {
        stockSummaryDataList.addAll(res.data ?? []);
      }
      isDataLoading.value = false;
    } catch (e) {
      isDataLoading.value = false;
      LoggerUtils.logException('getStockSummaryDetailsDetailsFromServer', e);
    }
  }
}

import 'package:cold_storage/app/general_model/res/cust_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/repositories/account_ledger_report_repo.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/details/model/res/account_ledger_detail_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/req/get_inward_stock_ledger_req_model.dart';
import 'package:cold_storage/app/services/general_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountLedgerReportDetailController extends GetxController {
  GetInwardStockLedgerReqModel? inwardStockLedgerReqModel;
  CustomerData custData = CustomerData();
  Rx<AccountLedgerDetailResModel> accountDetails =
      AccountLedgerDetailResModel().obs;
  RxList<AccountLedgerData> accountLedgerDataList =
      List<AccountLedgerData>.empty(growable: true).obs;

  RxBool isDataLoading = true.obs;

  @override
  void onInit() {
    Get.lazyPut(() => AccountLedgerReportRepo(), fenix: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getArguments();
    });
    super.onInit();
  }

  getArguments() async {
    try {
      inwardStockLedgerReqModel = Get.arguments[0];
      custData = Get.arguments[1];
      await getInwardStockLedgerDetailsFromServer();
    } catch (e) {
      LoggerUtils.logException('getArguments InwardStockLedger', e);
    }
  }

  getInwardStockLedgerDetailsFromServer() async {
    try {
      // inwardStockLedgerReqModel?.fromDate = '2019-04-01';
      // inwardStockLedgerReqModel?.toDate = '2024-04-26';
      // inwardStockLedgerReqModel?.PCODE = 'G00016';
      // inwardStockLedgerReqModel?.dbName = 'HIMALAYA';
      // inwardStockLedgerReqModel?.coCode = 81;
      inwardStockLedgerReqModel?.deviceID = await GeneralServices.getDeviceID();
      isDataLoading.value = true;
      var res = await Get.find<AccountLedgerReportRepo>()
          .getAccountLedgerReportFromServer(
              reqModel: inwardStockLedgerReqModel!);

      if (res != null && res.data != null) {
        accountDetails.value = res;
        accountLedgerDataList.addAll(res.data ?? []);
      }
      isDataLoading.value = false;
    } catch (e) {
      isDataLoading.value = false;
      LoggerUtils.logException('getInwardStockLedgerDetailsFromServer', e);
    }
  }
}

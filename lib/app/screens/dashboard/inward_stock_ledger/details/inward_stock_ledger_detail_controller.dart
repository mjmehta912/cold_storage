import 'package:cold_storage/app/repositories/inward_stock_ledger_repo.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/req/get_inward_stock_ledger_req_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/res/inward_stock_ledger_details_res_model.dart';
import 'package:cold_storage/app/services/general_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InwardStockLedgerDetailController extends GetxController {
  GetInwardStockLedgerReqModel? inwardStockLedgerReqModel;
  RxList<InwardStockLedgerData> inwardStockLedgerList =
      List<InwardStockLedgerData>.empty(growable: true).obs;

  RxBool isDataLoading = true.obs;

  @override
  void onInit() {
    Get.lazyPut(() => InwardStockLedgerRepo(), fenix: true);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        getArguments();
      },
    );
    super.onInit();
  }

  getArguments() async {
    try {
      inwardStockLedgerReqModel = Get.arguments;
      await getInwardStockLedgerDetailsFromServer();
    } catch (e) {
      LoggerUtils.logException(
        'getArguments InwardStockLedger',
        e,
      );
    }
  }

  getInwardStockLedgerDetailsFromServer() async {
    try {
      isDataLoading.value = true;
      inwardStockLedgerReqModel?.deviceID = await GeneralServices.getDeviceID();
      var res = await Get.find<InwardStockLedgerRepo>()
          .getInwardStockLedgerDetailFromServer(
              reqModel: inwardStockLedgerReqModel!);

      if (res != null && res.data != null) {
        inwardStockLedgerList.addAll(
          res.data ?? [],
        );
      }
      isDataLoading.value = false;
    } catch (e) {
      isDataLoading.value = false;
      LoggerUtils.logException(
        'getInwardStockLedgerDetailsFromServer',
        e,
      );
    }
  }
}

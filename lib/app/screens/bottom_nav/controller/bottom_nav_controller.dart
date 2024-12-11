import 'dart:convert';

import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/screens/auth/login/model/login_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/base/account_ledger_report_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/base/stock_ledger_report_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/base/stock_summary_base_controller.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  RxInt currentIndex = 0.obs;
  Rx<LoginData> selectedCompanyData = LoginData().obs;

  @override
  void onInit() {
    setCompanyData();
    super.onInit();
  }

  setCompanyData() async {
    try {
      AppConst.userName =
          await Get.find<LocalStorage>().getStringFromStorage(kStorageUserName);
      String companyData = await Get.find<LocalStorage>()
          .getStringFromStorage(kStorageCompanyData);
      AppConst.companyData.value = LoginData.fromJson(jsonDecode(companyData));
      selectedCompanyData = AppConst.companyData;
      update();
    } catch (e) {
      LoggerUtils.logException('setCompanyData', e);
    }
  }

  changeIndex(int i) {
    currentIndex.value = i;
    onIndexChange(i);
  }

  void onIndexChange(int i) {
    switch (i) {
      // case 0:
      //   Get.find<HomeBaseController>().onIndexChange();
      case 1:
        Get.find<StockSummaryBaseController>().onIndexChange();
      case 3:
        Get.find<StockLedgerReportBaseController>().onIndexChange();
      case 4:
        Get.find<AccountLedgerReportBaseController>().onIndexChange();
    }
  }

  navigateToNotificationScreen() {
    Get.toNamed(kRouteNotificationView, arguments: false);
  }
}

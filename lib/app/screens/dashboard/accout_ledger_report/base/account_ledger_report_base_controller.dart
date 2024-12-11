import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/general_model/res/cust_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/repositories/general_repo.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/req/get_inward_stock_ledger_req_model.dart';
import 'package:cold_storage/app/utils/extensions/app_date_time_extension.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountLedgerReportBaseController extends GetxController {
  RxBool isComingFromHome = false.obs;

  EdgeInsets textFieldTitlePadding =
      const EdgeInsets.symmetric(horizontal: 14, vertical: 2);

  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  TextEditingController viewByController = TextEditingController();
  TextEditingController showInwardController = TextEditingController();
  TextEditingController searchByInwardNoController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  Rx<DateTime> dateFrom = DateTime(DateTime.now().year, DateTime.april, 1).obs;
  Rx<DateTime> dateTo = DateTime.now().obs;

  /// customers
  RxList<CustomerData> customers = List<CustomerData>.empty(growable: true).obs;
  Rx<CustomerData> selectedCustomers = CustomerData().obs;

  onIndexChange() {
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        Get.lazyPut(() => GeneralRepo(), fenix: true);
        await getCustomerDataFromServer();
      });
    } catch (e) {
      LoggerUtils.logException('onIndexChange account ledger report base', e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    dateFromController.text = dateFrom.value.dateWithYear;
    dateToController.text = dateTo.value.dateWithYear;
    onIndexChange();
    super.onInit();
  }

  Future<void> getCustomerDataFromServer() async {
    try {
      var res = await Get.find<GeneralRepo>().getCustomersFromServer();
      if (res != null) {
        customers.addAll(res.customerList ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getCustomerDataFromServer', e);
    }
  }

  Future<void> navigateToDetailsScreen() async {
    int userId =
        await Get.find<LocalStorage>().getIntFromStorage(kStorageUserID);

    GetInwardStockLedgerReqModel inwardStockLedgerReqModel =
        GetInwardStockLedgerReqModel(
      fromDate: dateFrom.value.dateForDB,
      toDate: dateTo.value.dateForDB,
      PCODE: selectedCustomers.value.pcode ?? '0',
      dbName: AppConst.companyData.value.dbName ?? '',
      coCode: AppConst.companyData.value.coCode ?? 0,
      userID: userId,
    );
    Get.toNamed(kRouteAccountLedgerReportDetailView,
        arguments: [inwardStockLedgerReqModel, selectedCustomers.value]);
  }
}

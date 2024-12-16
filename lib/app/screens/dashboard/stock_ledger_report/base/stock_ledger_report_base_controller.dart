import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/general_model/res/cust_model.dart';
import 'package:cold_storage/app/general_model/res/items_res_model.dart';
import 'package:cold_storage/app/general_model/view_by_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/repositories/general_repo.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/req/get_inward_stock_ledger_req_model.dart';
import 'package:cold_storage/app/utils/extensions/app_date_time_extension.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockLedgerReportBaseController extends GetxController {
  RxBool isComingFromHome = false.obs;

  EdgeInsets textFieldTitlePadding = const EdgeInsets.symmetric(
    horizontal: 14,
    vertical: 2,
  );

  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  TextEditingController showInwardController = TextEditingController();
  TextEditingController searchByInwardNoController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  Rx<DateTime> dateFrom = DateTime(DateTime.now().year, DateTime.april, 1).obs;
  Rx<DateTime> dateTo = DateTime.now().obs;

  /// items
  RxList<ItemData> itemsList = List<ItemData>.empty(
    growable: true,
  ).obs;
  List<ItemData> selectedItems = [];

  /// customers
  RxList<CustomerData> customers = List<CustomerData>.empty(
    growable: true,
  ).obs;
  RxList<CustomerData> selectedCustomers = <CustomerData>[].obs;

  /// view by
  RxList<ViewByModel> viewByList = List<ViewByModel>.empty(
    growable: true,
  ).obs;
  ViewByModel? selectedViewBy;

  onIndexChange() {
    try {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async {
          Get.lazyPut(() => GeneralRepo(), fenix: true);
          await getCustomerDataFromServer();
        },
      );
    } catch (e) {
      LoggerUtils.logException(
        'onIndexChange stock ledge report base',
        e,
      );
    }
  }

  @override
  void onInit() {
    dateFromController.text = dateFrom.value.dateWithYear;
    dateToController.text = dateTo.value.dateWithYear;
    viewByList.addAll(ViewByModel.viewByList);
    selectedViewBy = viewByList[0];
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

  Future<void> getItemsDataFromServer() async {
    try {
      itemsList.clear();
      selectedItems.clear();
      List<String> pCodes = [];

      for (var element in selectedCustomers) {
        pCodes.add(element.pcode ?? '');
      }

      var res =
          await Get.find<GeneralRepo>().getItemsFromServer(pCodes: pCodes);
      if (res != null) {
        itemsList.addAll(res.data ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getItemsDataFromServer', e);
    }
  }

  Future<void> navigateToDetailsScreen() async {
    List<String> pCodes = [];
    List<String> iCodes = [];

    for (var element in selectedCustomers) {
      pCodes.add(element.pcode ?? '');
    }
    for (var element in selectedItems) {
      iCodes.add(element.icode ?? '');
    }

    int userId =
        await Get.find<LocalStorage>().getIntFromStorage(kStorageUserID);

    GetInwardStockLedgerReqModel inwardStockLedgerReqModel =
        GetInwardStockLedgerReqModel(
      fromDate: dateFrom.value.dateForDB,
      toDate: dateTo.value.dateForDB,
      viewBy: selectedViewBy?.id ?? 0,
      pCodes: pCodes.join(','),
      iCodes: iCodes.join(','),
      invno: searchByInwardNoController.text.trim(),
      dbName: AppConst.companyData.value.dbName ?? '',
      coCode: AppConst.companyData.value.coCode ?? 0,
      userID: userId,
    );
    Get.toNamed(kRouteStockLedgerReportDetailView,
        arguments: inwardStockLedgerReqModel);
  }
}

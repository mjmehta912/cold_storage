import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/general_model/req/general_req_model.dart';
import 'package:cold_storage/app/general_model/res/cust_model.dart';
import 'package:cold_storage/app/general_model/res/items_res_model.dart';
import 'package:cold_storage/app/general_model/vehicle_type_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/repositories/general_repo.dart';
import 'package:cold_storage/app/repositories/outward_repo.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/req/get_inward_stock_ledger_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/model/req/outward_place_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/model/res/inward_no_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/model/res/lot_balance_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/model/res/lot_no_res_model.dart';
import 'package:cold_storage/app/services/general_services.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/extensions/app_date_time_extension.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutwardRequestController extends GetxController {
  RxBool isComingFromHome = false.obs;

  EdgeInsets textFieldTitlePadding =
      const EdgeInsets.symmetric(horizontal: 14, vertical: 2);

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController balanceQtyController = TextEditingController();
  Rx<TextEditingController> outwardQtyController = TextEditingController().obs;

  TextEditingController searchController = TextEditingController();

  Rx<DateTime> selectedDate = DateTime.now().add(const Duration(days: 1)).obs;
  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  RxBool isOutwardQtyGreater = false.obs;

  /// items
  RxList<ItemData> itemsList = List<ItemData>.empty(growable: true).obs;
  List<ItemData> selectedItems = [];

  // /// customers
  // RxList<CustomerData> customers = List<CustomerData>.empty(growable: true).obs;
  // List<CustomerData> selectedCustomers = [];

  /// customers
  RxList<CustomerData> customers = List<CustomerData>.empty(growable: true).obs;
  Rx<CustomerData> selectedCustomers = CustomerData().obs;

  /// vehicle type
  RxList<VehicleTypeModel> vehicleType =
      List<VehicleTypeModel>.empty(growable: true).obs;
  Rx<VehicleTypeModel> selectedVehicleType = VehicleTypeModel().obs;

  /// Inward no
  RxList<InwardNoData> inwardNoList =
      List<InwardNoData>.empty(growable: true).obs;
  Rx<InwardNoData> selectedInwardNo = InwardNoData().obs;

  /// lot no
  RxList<String> lotNoList = List<String>.empty(growable: true).obs;
  Rx<String> selectedLotNo = ''.obs;

  /// lot balance
  RxList<LotBalanceData> lotBalanceList =
      List<LotBalanceData>.empty(growable: true).obs;
  Rx<LotBalanceData> selectedLotBalance = LotBalanceData().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    setData();
    super.onInit();
  }

  setData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      dateController.text = selectedDate.value.dateWithYear;
      timeController.text = selectedTime.value.format(Get.context!);
      balanceQtyController.text = '00';
      outwardQtyController.value.text = '';
      vehicleType.addAll(VehicleTypeModel.vehicleTypeList);
      selectedVehicleType.value = vehicleType[0];
      Get.lazyPut(() => GeneralRepo(), fenix: true);
      Get.lazyPut(() => OutwardRepo(), fenix: true);
      await getCustomerDataFromServer();
    });
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

  Future<void> getInwardNoFromServerApiCall() async {
    try {
      itemsList.clear();
      selectedItems.clear();

      String pCodes = '';
      pCodes = selectedCustomers.value.pcode ?? '';

      GeneralReqModel reqModel = GeneralReqModel(
        database: AppConst.companyData.value.dbName ?? '',
        cocode: AppConst.companyData.value.coCode,
        pcode: pCodes,
      );
      var res = await Get.find<OutwardRepo>()
          .getInwardNoFromServer(reqModel: reqModel);
      if (res != null) {
        inwardNoList.addAll(res.data ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getInwardNoFromServerApiCall', e);
    }
  }

  Future<void> getLotNoFromServerApiCall() async {
    try {
      lotNoList.clear();
      selectedLotNo.value = '';

      String pCodes = '';
      pCodes = selectedCustomers.value.pcode ?? '';

      GeneralReqModel reqModel = GeneralReqModel(
        database: AppConst.companyData.value.dbName ?? '',
        cocode: AppConst.companyData.value.coCode,
        pcode: pCodes,
        invNo: selectedInwardNo.value.invno ?? '',
      );
      var res =
          await Get.find<OutwardRepo>().getLotNoFromServer(reqModel: reqModel);
      if (res != null) {
        lotNoList.addAll(res.data ?? []);
        if (lotNoList.isNotEmpty) {
          selectedLotNo.value = lotNoList[0];
          getLotBalanceFromServerApiCall();
        }
      }
      print('selectedLotNo ::${selectedLotNo.value}');
    } catch (e) {
      LoggerUtils.logException('getLotNoFromServerApiCall', e);
    }
  }

  Future<void> getLotBalanceFromServerApiCall() async {
    try {
      lotBalanceList.clear();
      selectedLotBalance.value = LotBalanceData();

      String pCodes = '';
      pCodes = selectedCustomers.value.pcode ?? '';

      GeneralReqModel reqModel = GeneralReqModel(
        database: AppConst.companyData.value.dbName ?? '',
        cocode: AppConst.companyData.value.coCode,
        invNo: selectedLotNo.value,
      );
      var res = await Get.find<OutwardRepo>()
          .getLotBalanceFromServer(reqModel: reqModel);
      if (res != null) {
        lotBalanceList.addAll(res.data ?? []);
        if (lotBalanceList.isNotEmpty) {
          balanceQtyController.text = lotBalanceList[0].balance ?? '0';
          selectedLotBalance.value = lotBalanceList[0];
        }
      }
    } catch (e) {
      LoggerUtils.logException('getLotNoFromServerApiCall', e);
    }
  }

  Future<void> getItemsDataFromServer() async {
    try {
      itemsList.clear();
      selectedItems.clear();
      List<String> pCodes = [];

      pCodes.add(selectedCustomers.value.pcode ?? '');

      var res =
          await Get.find<GeneralRepo>().getItemsFromServer(pCodes: pCodes);
      if (res != null) {
        itemsList.addAll(res.data ?? []);
      }
    } catch (e) {
      LoggerUtils.logException('getItemsDataFromServer', e);
    }
  }

  Future<void> placeRequestApiCall() async {
    try {
      final localizations = MaterialLocalizations.of(Get.context!);
      final formattedTimeOfDay =
          localizations.formatTimeOfDay(selectedTime.value);
      int userId =
          await Get.find<LocalStorage>().getIntFromStorage(kStorageUserID);

      String pCodes = '';
      pCodes = selectedCustomers.value.pcode ?? '';

      String deviceID = await GeneralServices.getDeviceID();

      List<Dtlxml> dtlxml = [
        Dtlxml(
          inwno: selectedInwardNo.value.invno ?? '',
          lotno: selectedLotNo.value,
          icode: selectedLotBalance.value.icode ?? '',
          balqty: double.parse(balanceQtyController.text.trim()),
          qty: double.parse(outwardQtyController.value.text.trim()),
        ),
      ];

      OutwardPlaceReqModel reqModel = OutwardPlaceReqModel(
        database: AppConst.companyData.value.dbName ?? '',
        cocode: AppConst.companyData.value.coCode ?? 0,
        date: selectedDate.value.dateForDB,
        pcode: pCodes,
        vehicletype: selectedVehicleType.value.typeName ?? '',
        outwardtime: formattedTimeOfDay,
        entryDate: DateTime.now().dateForDB,
        userId: userId,
        dtlxml: dtlxml,
        deviceID: deviceID,
      );
      var res =
          await Get.find<OutwardRepo>().placeRequestApiCall(reqModel: reqModel);

      if (res != null) {
        Get.back();
        Get.find<AlertMessageUtils>()
            .showSuccessSnackBar1(Get.context!, res.message ?? '');
      }
    } catch (e) {
      LoggerUtils.logException('placeRequestApiCall', e);
    }
  }

  bool isTimeInFuture(TimeOfDay pickedTime) {
    final now = DateTime.now();
    final TimeOfDay currentTime = TimeOfDay.now();
    final pickedDateTime = DateTime(
        selectedDate.value.year,
        selectedDate.value.month,
        selectedDate.value.day,
        pickedTime.hour,
        pickedTime.minute);
    final currentDateTime = DateTime(
        now.year, now.month, now.day, currentTime.hour, currentTime.minute);

    return pickedDateTime.isAfter(currentDateTime);
  }

  void resetObjects() {
    inwardNoList.value = [];
    lotBalanceList.value = [];
    selectedInwardNo.value.invno = '';
    selectedLotNo.value = '';
    selectedLotBalance.value.iname = '';
    inwardNoList.refresh();
    update();
  }
}

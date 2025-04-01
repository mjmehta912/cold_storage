import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/general_model/req/general_req_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/repositories/outward_repo.dart';
import 'package:cold_storage/app/screens/dashboard/outward_details/model/req/authorized_req_model.dart';
import 'package:cold_storage/app/screens/dashboard/outward_details/model/res/outward_details_res_model.dart';
import 'package:cold_storage/app/services/general_services.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/extensions/app_date_time_extension.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: constant_identifier_names
enum Status { Accept, Pending, Reject }

class OutwardDetailsBaseController extends GetxController {
  TextEditingController remarkController = TextEditingController();

  RxList<OutwardDetailsData> outwardDetailsList = <OutwardDetailsData>[].obs;
  RxList<OutwardDetailsData> filterOutwardDetailsList =
      <OutwardDetailsData>[].obs;
  RxList<RxBool> expandedList = <RxBool>[].obs; // Track expansion states

  RxBool isViewRequest = false.obs;
  RxInt selectedFilterIndex = 0.obs;
  RxBool isDataLoading = true.obs;

  @override
  void onInit() {
    Get.lazyPut(() => OutwardRepo(), fenix: true);
    setIntentData();

    // Ensure expansion states update when filtered list changes
    ever(filterOutwardDetailsList, (_) => initializeExpansionStates());

    super.onInit();
  }

  /// ✅ Initialize Expansion List (Keeps it in sync with `filterOutwardDetailsList`)
  void initializeExpansionStates() {
    expandedList.value =
        List.generate(filterOutwardDetailsList.length, (_) => false.obs);
  }

  /// ✅ Toggle Expansion for a Specific Card
  void toggleExpansion(int index) {
    if (index < expandedList.length) {
      expandedList[index].value = !expandedList[index].value;
    }
  }

  /// ✅ Set Initial Data
  void setIntentData() {
    try {
      isViewRequest.value = Get.arguments as bool;
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await getOutwardDetailsFromApiCall();
      });
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }

  /// ✅ Fetch Data from API
  Future<void> getOutwardDetailsFromApiCall() async {
    try {
      isDataLoading.value = true;
      outwardDetailsList.clear();
      filterOutwardDetailsList.clear();

      int userId =
          await Get.find<LocalStorage>().getIntFromStorage(kStorageUserID);
      String deviceID = await GeneralServices.getDeviceID();

      GeneralReqModel reqModel = GeneralReqModel(
        database: AppConst.companyData.value.dbName ?? '',
        cocode: AppConst.companyData.value.coCode ?? 0,
        userId: userId,
        panNO: AppConst.companyData.value.panno ?? '',
        deviceID: deviceID,
      );

      var res = await Get.find<OutwardRepo>()
          .getOutwardDetailsFromServer(reqModel: reqModel);
      if (res != null) {
        outwardDetailsList.addAll(res.data ?? []);
        filterOutwardDetailsList.addAll(res.data ?? []);
      }

      initializeExpansionStates(); // ✅ Initialize expansion states
      isDataLoading.value = false;
    } catch (e) {
      isDataLoading.value = false;
      LoggerUtils.logException('getOutwardDetailsFromApiCall', e);
    }
  }

  /// ✅ Return Status Color
  Color returnStatusColor(OutwardDetailsData data) {
    if (data.status == 'Accept' || data.status == 'Accepted') {
      return kColorGreen;
    } else if (data.status == 'Pending') {
      return kColor1B68FF;
    } else {
      return kColorRejectButton;
    }
  }

  /// ✅ Filter Data
  void updateListWithFilterData(String filterStr) {
    filterOutwardDetailsList.clear();

    if (filterStr == kPending) {
      filterOutwardDetailsList
          .assignAll(outwardDetailsList.where((e) => e.status == 'Pending'));
    } else if (filterStr == kAccepted) {
      filterOutwardDetailsList.assignAll(outwardDetailsList
          .where((e) => e.status == 'Accept' || e.status == 'Accepted'));
    } else if (filterStr == kRejected) {
      filterOutwardDetailsList.assignAll(outwardDetailsList.where((e) =>
          e.status?.split('(').first == 'Reject' ||
          e.status?.split('(').first == 'Rejected'));
    } else {
      filterOutwardDetailsList.assignAll(outwardDetailsList);
    }

    initializeExpansionStates(); // ✅ Ensure expansion states match filtered list
  }

  /// ✅ Handle Reject Request
  Future<void> rejectReqApiCall(
      OutwardDetailsData data, int dataStatusCode) async {
    try {
      String dateString = data.date ?? '';
      DateFormat format = DateFormat("dd-MM-yyyy");
      DateTime dateTime = format.parse(dateString);

      int userId =
          await Get.find<LocalStorage>().getIntFromStorage(kStorageUserID);
      String deviceID = await GeneralServices.getDeviceID();

      AuthorizedReqModel reqModel = AuthorizedReqModel(
        database: AppConst.companyData.value.dbName ?? '',
        cocode: AppConst.companyData.value.coCode ?? 0,
        date: dateTime.dateForDB,
        entryDate:
            DateFormat("dd-MM-yyyy").parse(data.entryDate ?? '').dateForDB,
        remarks: remarkController.text.trim(),
        invNo: data.invno ?? '',
        status: dataStatusCode,
        id: data.id,
        userID: userId,
        deviceID: deviceID,
      );

      var res = await Get.find<OutwardRepo>()
          .authReqForOutwardDetailsApiCall(reqModel: reqModel);

      if (res != null) {
        remarkController.clear();
        Get.find<AlertMessageUtils>()
            .showSuccessSnackBar1(Get.context!, res.message ?? '');
        getOutwardDetailsFromApiCall(); // ✅ Refresh Data After Update
      }
    } catch (e) {
      LoggerUtils.logException('rejectReqApiCall', e);
    }
  }

  /// ✅ Convert Status to Integer Code
  int returnStatusFromString(OutwardDetailsData data) {
    if (data.status == Status.Accept.name) {
      return 1;
    } else if (data.status == Status.Pending.name) {
      return 0;
    } else {
      return 2;
    }
  }
}

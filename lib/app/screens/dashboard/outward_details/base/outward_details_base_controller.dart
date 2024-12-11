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

enum Status { Accept, Pending, Reject }

class OutwardDetailsBaseController extends GetxController {
  TextEditingController remarkController = TextEditingController();

  RxBool isViewRequest = false.obs;
  RxList<OutwardDetailsData> outwardDetailsList =
      List<OutwardDetailsData>.empty(growable: true).obs;

  RxList<OutwardDetailsData> filterOutwardDetailsList =
      List<OutwardDetailsData>.empty(growable: true).obs;

  RxInt selectedFilterIndex = 0.obs;
  RxBool isDataLoading = true.obs;

  @override
  void onInit() {
    Get.lazyPut(() => OutwardRepo(), fenix: true);
    setIntentData();
    super.onInit();
  }

  setIntentData() {
    try {
      isViewRequest.value = Get.arguments as bool;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await getOutwardDetailsFromApiCall();
      });
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }

  getOutwardDetailsFromApiCall() async {
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
      isDataLoading.value = false;
    } catch (e) {
      isDataLoading.value = false;
      LoggerUtils.logException('getOutwardDetailsFromApiCall', e);
    }
  }

  returnStatusColor(OutwardDetailsData data) {
    if (data.status == 'Accept' || data.status == 'Accepted') {
      return kColorGreen;
    } else if (data.status == 'Pending') {
      return kColor1B68FF;
    } else {
      return kColorRejectButton;
    }
  }

  void updateListWithFilterData(String filterStr) {
    if (filterStr == kPending) {
      filterOutwardDetailsList.clear();
      for (var element in outwardDetailsList) {
        if (element.status == 'Pending') {
          filterOutwardDetailsList.add(element);
        }
      }
      filterOutwardDetailsList.refresh();
    } else if (filterStr == kAccepted) {
      filterOutwardDetailsList.clear();
      for (var element in outwardDetailsList) {
        if (element.status == 'Accept' || element.status == 'Accepted') {
          filterOutwardDetailsList.add(element);
        }
      }
      filterOutwardDetailsList.refresh();
    } else if (filterStr == kRejected) {
      filterOutwardDetailsList.clear();
      for (var element in outwardDetailsList) {
        if (element.status?.split('(').first == 'Reject' ||
            element.status?.split('(').first == 'Rejected') {
          filterOutwardDetailsList.add(element);
        }
      }
      filterOutwardDetailsList.refresh();
    } else {
      filterOutwardDetailsList.clear();
      filterOutwardDetailsList.addAll(outwardDetailsList);
      filterOutwardDetailsList.refresh();
    }
  }

  void rejectReqApiCall(OutwardDetailsData data, int dataStatusCode) async {
    try {
      String dateString = data.date ?? '';
      DateFormat format = DateFormat("dd-MM-yyyy");
      DateTime dateTime = format.parse(dateString);

      // int status = returnStatusFromString(data);
      int status = dataStatusCode;

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
        status: status,
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
        getOutwardDetailsFromApiCall();
      }
    } catch (e) {
      LoggerUtils.logException('rejectReqApiCall', e);
    }
  }

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

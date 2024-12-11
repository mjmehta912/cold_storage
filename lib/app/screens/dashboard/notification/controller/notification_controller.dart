import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/general_model/req/general_req_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/repositories/notification_repo.dart';
import 'package:cold_storage/app/screens/dashboard/notification/model/res/change_device_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/notification/model/res/notification_res.dart';
import 'package:cold_storage/app/services/firebase_services.dart';
import 'package:cold_storage/app/utils/general/general_utils.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<NotificationData> notificationDataList =
      List<NotificationData>.empty(growable: true).obs;
  RxList<NotificationData> filterNotificationDataList =
      List<NotificationData>.empty(growable: true).obs;

  TextEditingController remarkController = TextEditingController();

  RxBool isFromNotification = false.obs;
  RxInt selectedFilterIndex = 1.obs;

  RxBool isDataLoading = true.obs;

  double titleWidth = 0.26;
  double titleValueWidth = 0.6;

  @override
  void onInit() {
    setIntentData();
    Get.lazyPut(() => NotificationRepo(), fenix: true);
    getNotificationFromServer();
    super.onInit();
  }

  setIntentData() {
    try {
      isFromNotification.value = Get.arguments as bool;
    } catch (e) {
      LoggerUtils.logException('setIntentData - notification controller :', e);
    }
  }

  getNotificationFromServer() async {
    try {
      selectedFilterIndex.value = 1;
      filterNotificationDataList.clear();
      notificationDataList.clear();
      int userId =
          await Get.find<LocalStorage>().getIntFromStorage(kStorageUserID);
      GeneralReqModel reqModel = GeneralReqModel(
        userId: userId,
        panNO: AppConst.companyData.value.panno ?? '0',
      );
      var res = await Get.find<NotificationRepo>()
          .getNotificationApiCall(reqModel: reqModel);

      if (res != null) {
        filterNotificationDataList.addAll(res.data ?? []);
        notificationDataList.addAll(res.data ?? []);
        updateListWithFilterData(kPending);
      }
      isDataLoading.value = false;
    } catch (e) {
      isDataLoading.value = false;
      LoggerUtils.logException('getNotificationFromServer', e);
    }
  }

  String returnStatusText(int i) {
    if (i == 1) {
      return kAccepted;
    } else if (i == 2) {
      return kRejected;
    } else {
      return kPending;
    }
  }

  returnStatusColor(NotificationData data) {
    if (data.status == 1) {
      return kColorGreen;
    } else if (data.status == 2) {
      return kColorRejectButton;
    } else {
      return kColor1B68FF;
    }
  }

  void updateListWithFilterData(String filterStr) {
    if (filterStr == kPending) {
      filterNotificationDataList.clear();
      for (var element in notificationDataList) {
        if (element.status == 0 || element.status == null) {
          filterNotificationDataList.add(element);
        }
      }
      filterNotificationDataList.refresh();
    } else if (filterStr == kAccepted) {
      filterNotificationDataList.clear();
      for (var element in notificationDataList) {
        if (element.status == 1) {
          filterNotificationDataList.add(element);
        }
      }
      filterNotificationDataList.refresh();
    } else if (filterStr == kRejected) {
      filterNotificationDataList.clear();
      for (var element in notificationDataList) {
        if (element.status == 2) {
          filterNotificationDataList.add(element);
        }
      }
      filterNotificationDataList.refresh();
    } else {
      filterNotificationDataList.clear();
      filterNotificationDataList.addAll(notificationDataList);
      filterNotificationDataList.refresh();
    }
  }

  Future<void> rejectReqApiCall(NotificationData data, int i) async {
    try {
      String deviceId = await getId() ?? '';
      String fcmToken = await FirebaseServices().getFCMToken();
      int userId =
          await Get.find<LocalStorage>().getIntFromStorage(kStorageUserID);

      ChangeDeviceMetadata metadata = ChangeDeviceMetadata(
        screenName: 'notificationScreen',
        key1: data.requestId.toString(),
        key2: '',
      );
      ChangeDeviceResModel requestModel = ChangeDeviceResModel(
        userId: userId,
        requestId: data.requestId,
        status: i,
        metadata: metadata,
      );
      var res = await Get.find<NotificationRepo>()
          .changeDeviceResponseApiCall(requestModel: requestModel);
      if (res == true) {
        isDataLoading.value = true;
        notificationDataList.clear();
        await getNotificationFromServer();
      }
    } catch (e) {
      LoggerUtils.logException('rejectReqApiCall', e);
    }
  }

  void navigateToBack() {
    if (isFromNotification.value) {
      Get.offAllNamed(kRouteBottomNavView);
    } else {
      Get.back();
    }
  }

  String returnText(String? str) {
    if ((str ?? '').isEmpty) {
      return '-';
    } else {
      return str ?? '';
    }
  }
}

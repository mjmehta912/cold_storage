import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/local_storage_constants.dart';
import 'package:cold_storage/app/general_model/res/cust_model.dart';
import 'package:cold_storage/app/general_model/user_type_model.dart';
import 'package:cold_storage/app/helper/dev/logger_utils.dart';
import 'package:cold_storage/app/repositories/auth_repo.dart';
import 'package:cold_storage/app/repositories/general_repo.dart';
import 'package:cold_storage/app/screens/dashboard/user_register/model/req/user_reg_req_model.dart';
import 'package:cold_storage/app/services/general_services.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRegisterController extends GetxController {
  EdgeInsets textFieldTitlePadding =
      const EdgeInsets.symmetric(horizontal: 14, vertical: 2);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController mobileController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool visiblePassword = false.obs;

  /// user type
  RxList<UserTypeModel> userType =
      List<UserTypeModel>.empty(growable: true).obs;
  Rx<UserTypeModel> selectedUserType = UserTypeModel('').obs;

  /// customers
  RxList<CustomerData> customers = List<CustomerData>.empty(growable: true).obs;
  RxList<CustomerData> selectedCustomers = <CustomerData>[].obs;

  @override
  void onInit() {
    setIntentData();
    super.onInit();
  }

  @override
  void dispose() {
    formKey = GlobalKey();
    super.dispose();
  }

  setIntentData() {
    userType.addAll(UserTypeModel.userTypeModelList);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Get.lazyPut(() => GeneralRepo(), fenix: true);
      Get.lazyPut(() => AuthRepo(), fenix: true);
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

  userRegApiCall() async {
    List<String> pCodes = [];
    // ignore: unused_local_variable
    int userId =
        await Get.find<LocalStorage>().getIntFromStorage(kStorageUserID);
    try {
      for (var element in selectedCustomers) {
        pCodes.add(element.pcode ?? '');
      }

      int userId =
          await Get.find<LocalStorage>().getIntFromStorage(kStorageUserID);

      String deviceID = await GeneralServices.getDeviceID();

      UserRegReqModel requestModel = UserRegReqModel(
        userName: userNameController.text.trim(),
        mobileNo: mobileController.text.trim(),
        password: passwordController.text.trim(),
        pcodEs: pCodes.join(','),
        panNo: AppConst.companyData.value.panno ?? '',
        userType: returnUserType(),
        userID: userId,
        deviceID: deviceID,
      );
      var res =
          await Get.find<AuthRepo>().userRegApiCall(requestModel: requestModel);
      if (res != null) {
        clearAllObjects();
      }
    } catch (e) {
      LoggerUtils.logException('userRegApiCall', e);
    }
  }

  void clearAllObjects() {
    userNameController.clear();
    mobileController.clear();
    passwordController.clear();
    selectedUserType = UserTypeModel('').obs;
    selectedCustomers.clear();
    // customers.clear();
    // userType.clear();
    // setIntentData();
  }

  int returnUserType() {
    ///  0-ADMIN, 1 - STAFF, 2 - USER
    if (selectedUserType.value.type == kAdmin) {
      return 0;
    } else if (selectedUserType.value.type == kStaffMember) {
      return 1;
    } else {
      return 2;
    }
  }
}

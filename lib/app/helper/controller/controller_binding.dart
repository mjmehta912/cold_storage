import 'package:cold_storage/app/screens/auth/login/login_controller.dart';
import 'package:cold_storage/app/screens/auth/select_company/select_company_controller.dart';
import 'package:cold_storage/app/screens/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/base/account_ledger_report_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/details/account_ledger_report_detail_controller.dart';
import 'package:cold_storage/app/screens/dashboard/home/base/home_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/base/inward_stock_ledger_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/inward_stock_ledger_detail_controller.dart';
import 'package:cold_storage/app/screens/dashboard/notification/controller/notification_controller.dart';
import 'package:cold_storage/app/screens/dashboard/outward_details/base/outward_details_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/outward_request_controller.dart';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/base/stock_ledger_report_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/details/stock_ledger_report_detail_controller.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/base/stock_summary_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/details/stock_summary_detail_controller.dart';
import 'package:cold_storage/app/screens/dashboard/user_register/user_register_controller.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AlertMessageUtils>(AlertMessageUtils(), permanent: true);
    Get.put<LocalStorage>(LocalStorage(), permanent: true);
    Get.lazyPut<BottomNavController>(() => BottomNavController(), fenix: true);
    Get.lazyPut<BottomNavController>(() => BottomNavController(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<SelectCompanyController>(() => SelectCompanyController(),
        fenix: true);

    Get.lazyPut<HomeBaseController>(() => HomeBaseController(), fenix: true);
    Get.lazyPut<InwardStockLedgerBaseController>(
        () => InwardStockLedgerBaseController(),
        fenix: true);
    Get.lazyPut<InwardStockLedgerDetailController>(
        () => InwardStockLedgerDetailController(),
        fenix: true);
    Get.lazyPut<StockSummaryBaseController>(() => StockSummaryBaseController(),
        fenix: true);
    Get.lazyPut<StockSummaryDetailController>(
        () => StockSummaryDetailController(),
        fenix: true);
    Get.lazyPut<StockLedgerReportBaseController>(
        () => StockLedgerReportBaseController(),
        fenix: true);
    Get.lazyPut<StockLedgerReportDetailController>(
        () => StockLedgerReportDetailController(),
        fenix: true);
    Get.lazyPut<AccountLedgerReportBaseController>(
        () => AccountLedgerReportBaseController(),
        fenix: true);
    Get.lazyPut<AccountLedgerReportDetailController>(
        () => AccountLedgerReportDetailController(),
        fenix: true);
    Get.lazyPut<OutwardDetailsBaseController>(
        () => OutwardDetailsBaseController(),
        fenix: true);
    Get.lazyPut<OutwardRequestController>(() => OutwardRequestController(),
        fenix: true);
    Get.lazyPut<UserRegisterController>(() => UserRegisterController(),
        fenix: true);
    Get.lazyPut<NotificationController>(() => NotificationController(),
        fenix: true);
  }
}

import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/screens/auth/login/login_view.dart';
import 'package:cold_storage/app/screens/auth/select_company/select_company_view.dart';
import 'package:cold_storage/app/screens/bottom_nav/view/bottom_nav_view.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/base/accout_ledger_report_base_view.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/details/account_ledger_report_detail_view.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/base/inward_stock_ledger_base_view.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/inward_stock_ledger_details_view.dart';
import 'package:cold_storage/app/screens/dashboard/notification/view/notification_view.dart';
import 'package:cold_storage/app/screens/dashboard/outward_details/base/outward_details_base_view.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/outward_request_view.dart';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/base/stock_ledger_report_base_view.dart';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/details/stock_ledger_report_detail_view.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/base/stock_summary_base_view.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/details/stock_summary_detail_view.dart';
import 'package:cold_storage/app/screens/dashboard/user_register/user_register_view.dart';
import 'package:get/get.dart';

class GetRoutePages {
  static List<GetPage>? routePage = [
    GetPage(
      name: kRouteBottomNavView,
      page: () => BottomNavView(),
    ),
    GetPage(
      name: kRouteLoginView,
      page: () => const LoginView(),
    ),
    GetPage(
      name: kRouteSelectCompanyView,
      page: () => const SelectCompanyView(),
    ),
    GetPage(
      name: kRouteInwardStockLedgerBaseView,
      page: () => const InwardStockLedgerBaseView(),
    ),
    GetPage(
      name: kRouteInwardStockLedgerDetailView,
      page: () => const InwardStockLedgerDetailView(),
    ),
    GetPage(
      name: kRouteStockSummaryBaseView,
      page: () => StockSummaryBaseView(),
    ),
    GetPage(
      name: kRouteStockSummaryDetailView,
      page: () => const StockSummaryDetailView(),
    ),
    GetPage(
      name: kRouteStockLedgerReportBaseView,
      page: () => StockLedgerReportBaseView(),
    ),
    GetPage(
      name: kRouteStockLedgerReportDetailView,
      page: () => const StockLedgerReportDetailView(),
    ),
    GetPage(
      name: kRouteAccountLedgerReportBaseView,
      page: () => AccountLedgerReportBaseView(),
    ),
    GetPage(
      name: kRouteAccountLedgerReportDetailView,
      page: () => const AccountLedgerReportDetailView(),
    ),
    GetPage(
      name: kRouteOutwardDetailsBaseView,
      page: () => const OutwardDetailsBaseView(),
    ),
    GetPage(
      name: kRouteOutwardRequestView,
      page: () => OutwardRequestView(),
    ),
    GetPage(
      name: kRouteUserRegisterView,
      page: () => const UserRegisterView(),
    ),
    GetPage(
      name: kRouteNotificationView,
      page: () => const NotificationView(),
    ),
  ];
}

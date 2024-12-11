import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/base/account_ledger_report_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/details/account_ledger_report_detail_controller.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/details/model/res/account_ledger_detail_res_model.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/app_widgets/show_loader_text.dart';
import 'package:cold_storage/app/utils/stock_widgets/stock_widget.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountLedgerReportDetailView
    extends GetView<AccountLedgerReportDetailController> {
  const AccountLedgerReportDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AccountLedgerReportDetailController(),
      builder: (controller) {
        return AppScaffold(
          resizeToAvoidBottomInset: true,
          appBar: appBarWidget(
            context: context,
            titleText: kAccountLedgerReport,
            onTap: () {
              Get.back();
            },
          ),
          body: _stockLegerReportListView(),
        );
      },
    );
  }

  _stockLegerReportListView() {
    return Obx(
      () {
        return controller.isDataLoading.value
            ? showLoaderText()
            : Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleWidget(controller.custData.pname ?? ''),
                    Container(
                      width: 1.screenWidth,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: const BoxDecoration(
                        color: kColorPrimary,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: controller
                                    .inwardStockLedgerReqModel?.fromDate ??
                                '',
                            style: TextStyles.kPrimaryBoldInter(
                              fontSize: TextStyles.k14FontSize,
                              colors: kColorBlack,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: '$kOpening $kBalance',
                                style: TextStyles.kPrimaryBoldInter(
                                  fontSize: TextStyles.k14FontSize,
                                  colors: kColorBlack,
                                ),
                              ),
                              AppText(
                                text: controller.accountDetails.value.opening ??
                                    '0',
                                style: TextStyles.kPrimaryBoldInter(
                                  fontSize: TextStyles.k14FontSize,
                                  colors: kColorBlack,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.56.screenHeight,
                      child: ListView.builder(
                        itemCount: controller.accountLedgerDataList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var data = controller.accountLedgerDataList[index];
                          return _subListView(data);
                        },
                      ),
                    ),
                    AppSpaces.v4,
                    bottomTitleWidget(
                      // '$kDebit 5KG',
                      kDebit,
                      controller.accountDetails.value.debit ?? '0',
                      color: kColorSecondPrimary,
                      textStyle: TextStyles.kPrimaryBoldInter(
                        fontSize: TextStyles.k14FontSize,
                      ),
                    ),
                    bottomTitleWidget(
                      // '$kCredit 5KG',
                      kCredit,
                      controller.accountDetails.value.credit ?? '0',
                      color: kColorSecondPrimary,
                      textStyle: TextStyles.kPrimaryBoldInter(
                        fontSize: TextStyles.k14FontSize,
                      ),
                    ),
                    Container(
                      width: 1.screenWidth,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: const BoxDecoration(
                        color: kColorPrimary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text:
                                controller.inwardStockLedgerReqModel?.toDate ??
                                    '',
                            style: TextStyles.kPrimaryBoldInter(
                              fontSize: TextStyles.k14FontSize,
                              colors: kColorBlack,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: kCLOSINGBALANCE,
                                style: TextStyles.kPrimaryBoldInter(
                                  fontSize: TextStyles.k14FontSize,
                                  colors: kColorBlack,
                                ),
                              ),
                              AppText(
                                text: controller.accountDetails.value.closing ??
                                    '0',
                                style: TextStyles.kPrimaryBoldInter(
                                  fontSize: TextStyles.k14FontSize,
                                  colors: kColorBlack,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  _subListView(AccountLedgerData data) {
    return Container(
      decoration: const BoxDecoration(
        color: kColorWhite,
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              subListText(kDate, data.date ?? '0'),
              AppSpaces.h20,
              subListText(kDoc, data.docno ?? '0'),
              AppSpaces.h20,
              SizedBox(
                width: 0.4.screenWidth,
                child: subListText(kNarration, data.narration ?? ''),
              ),
            ],
          ),
          AppSpaces.v8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subListText(kBook, data.book ?? ''),
              subListText(kDebit, data.debit ?? '0'),
              subListText(kCredit, data.credit ?? '0'),
              subListText(kBalance, data.balance ?? '0'),
            ],
          ),
        ],
      ),
    );
  }
}

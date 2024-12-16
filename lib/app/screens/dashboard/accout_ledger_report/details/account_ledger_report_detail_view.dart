import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/details/account_ledger_report_detail_controller.dart';
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
  const AccountLedgerReportDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AccountLedgerReportDetailController(),
      builder: (controller) {
        return AppScaffold(
          bgColor: mColorAppbar,
          resizeToAvoidBottomInset: true,
          appBar: appBarWidget(
            context: context,
            titleText: kAccountLedgerReport,
            onTap: () {
              Get.back();
            },
          ),
          body: Obx(
            () {
              return controller.isDataLoading.value
                  ? showLoaderText()
                  : Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleWidget(
                            controller.custData.pname ?? '',
                            bgColor: mColorCard4Primary,
                            textColor: mColorCard4Secondary,
                          ),
                          AppSpaces.v10,
                          Container(
                            width: 1.screenWidth,
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: mColorBackground,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: controller.inwardStockLedgerReqModel
                                          ?.fromDate ??
                                      '',
                                  style: TextStyles.kPrimaryBoldPublicSans(
                                    fontSize: TextStyles.k16FontSize,
                                    colors: mColorPrimaryText,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: '$kOpening $kBalance',
                                      style: TextStyles.kPrimaryBoldPublicSans(
                                        fontSize: TextStyles.k16FontSize,
                                        colors: mColorPrimaryText,
                                      ),
                                    ),
                                    AppText(
                                      text: controller
                                              .accountDetails.value.opening ??
                                          '0',
                                      style: TextStyles.kPrimaryBoldPublicSans(
                                        fontSize: TextStyles.k16FontSize,
                                        colors: mColorPrimaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 0.5.screenHeight,
                            child: ListView.builder(
                              itemCount:
                                  controller.accountLedgerDataList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var data =
                                    controller.accountLedgerDataList[index];
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: mColorBackground,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 12,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          subListText(
                                            kDate,
                                            data.date ?? '0',
                                          ),
                                          AppSpaces.h20,
                                          subListText(
                                            kDoc,
                                            data.docno ?? '0',
                                          ),
                                          AppSpaces.h20,
                                          SizedBox(
                                            width: 0.4.screenWidth,
                                            child: subListText(
                                              kNarration,
                                              data.narration ?? '',
                                            ),
                                          ),
                                        ],
                                      ),
                                      AppSpaces.v8,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          subListText(
                                            kBook,
                                            data.book ?? '',
                                          ),
                                          subListText(
                                            kDebit,
                                            data.debit ?? '0',
                                          ),
                                          subListText(
                                            kCredit,
                                            data.credit ?? '0',
                                          ),
                                          subListText(
                                            kBalance,
                                            data.balance ?? '0',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          AppSpaces.v10,
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: mColorBackground,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  bottomTitleWidget(
                                    kDebit,
                                    controller.accountDetails.value.debit ??
                                        '0',
                                    color: mColorBackground,
                                    textStyle:
                                        TextStyles.kPrimaryBoldPublicSans(
                                      fontSize: TextStyles.k16FontSize,
                                      colors: mColorPrimaryText,
                                    ).copyWith(
                                      height: 1,
                                    ),
                                  ),
                                  bottomTitleWidget(
                                    kCredit,
                                    controller.accountDetails.value.credit ??
                                        '0',
                                    color: mColorBackground,
                                    textStyle:
                                        TextStyles.kPrimaryBoldPublicSans(
                                      fontSize: TextStyles.k16FontSize,
                                      colors: mColorPrimaryText,
                                    ).copyWith(
                                      height: 1,
                                    ),
                                  ),
                                  const Divider(
                                    color: mColorCard1Secondary,
                                    thickness: 0.5,
                                  ),
                                  Container(
                                    width: 1.screenWidth,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: mColorBackground,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: controller
                                                  .inwardStockLedgerReqModel
                                                  ?.toDate ??
                                              '',
                                          style:
                                              TextStyles.kPrimaryBoldPublicSans(
                                            fontSize: TextStyles.k16FontSize,
                                            colors: mColorPrimaryText,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AppText(
                                              text: 'Closing Balance',
                                              style: TextStyles
                                                  .kPrimaryBoldPublicSans(
                                                fontSize:
                                                    TextStyles.k16FontSize,
                                                colors: mColorPrimaryText,
                                              ),
                                            ),
                                            AppText(
                                              text: controller.accountDetails
                                                      .value.closing ??
                                                  '0',
                                              style: TextStyles
                                                  .kPrimaryBoldPublicSans(
                                                fontSize:
                                                    TextStyles.k16FontSize,
                                                colors: mColorPrimaryText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            },
          ),
        );
      },
    );
  }
}

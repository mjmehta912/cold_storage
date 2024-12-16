import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/details/model/stock_ledger_report_res_model.dart';
import 'package:cold_storage/app/screens/dashboard/stock_ledger_report/details/stock_ledger_report_detail_controller.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/no_data_found.dart';
import 'package:cold_storage/app/utils/app_widgets/show_loader_text.dart';
import 'package:cold_storage/app/utils/general/general_utils.dart';
import 'package:cold_storage/app/utils/stock_widgets/stock_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockLedgerReportDetailView
    extends GetView<StockLedgerReportDetailController> {
  const StockLedgerReportDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StockLedgerReportDetailController(),
      builder: (controller) {
        return AppScaffold(
          bgColor: mColorAppbar,
          resizeToAvoidBottomInset: true,
          appBar: appBarWidget(
            context: context,
            titleText: kStockLedgerReport,
            onTap: () {
              Get.back();
            },
          ),
          body: Obx(
            () {
              return controller.isDataLoading.value
                  ? showLoaderText()
                  : controller.stockLedgerReportDataList.isEmpty
                      ? noDataFound(
                          text: kNoDataFound,
                        )
                      : ListView.builder(
                          itemCount:
                              controller.stockLedgerReportDataList.length,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            var data =
                                controller.stockLedgerReportDataList[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleWidget(
                                  data.companyName ?? '',
                                  bgColor: mColorCard3Primary,
                                  textColor: mColorCard3Secondary,
                                ),
                                AppSpaces.v10,
                                for (StockItem element in data.stockItems ?? [])
                                  Column(
                                    children: [
                                      Card(
                                        color: mColorBackground,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            subTitleWidget(
                                              element.itemName ?? '',
                                              bgColor: mColorBackground,
                                              textColor: mColorPrimaryText,
                                            ),
                                            Column(
                                              children: (StockItem subList) {
                                                List<Widget>
                                                    listOfSubItemsWidgets = [];
                                                for (ItemStockDetail element
                                                    in subList
                                                            .itemStockDetails ??
                                                        []) {
                                                  listOfSubItemsWidgets.add(
                                                    Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: mColorBackground,
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 4,
                                                        horizontal: 12,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  subListText(
                                                                    '$kInwardNo.',
                                                                    element.inwno ??
                                                                        '0',
                                                                  ),
                                                                  IconButton(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    visualDensity:
                                                                        const VisualDensity(
                                                                      horizontal:
                                                                          -4,
                                                                      vertical:
                                                                          -4,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      clipToCopy(
                                                                          text: element.inwno ??
                                                                              '');
                                                                    },
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .copy_rounded,
                                                                      size: 20,
                                                                      color:
                                                                          mColorCard3Secondary,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              AppSpaces.h20,
                                                              subListText(
                                                                kDate,
                                                                element.idate ??
                                                                    '0',
                                                              ),
                                                              AppSpaces.h20,
                                                              subListText(
                                                                kQty,
                                                                element.iqty ??
                                                                    '0',
                                                              ),
                                                            ],
                                                          ),
                                                          AppSpaces.v4,
                                                          for (int i = 0;
                                                              i <
                                                                  (element.outwardList ??
                                                                          [])
                                                                      .length;
                                                              i++)
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                subListText(
                                                                  '$kOutwardNo.',
                                                                  element
                                                                          .outwardList?[
                                                                              i]
                                                                          .outno ??
                                                                      '0',
                                                                ),
                                                                subListText(
                                                                  kDate,
                                                                  element
                                                                          .outwardList?[
                                                                              i]
                                                                          .odate ??
                                                                      '0',
                                                                ),
                                                                subListText(
                                                                  kQty,
                                                                  element
                                                                          .outwardList?[
                                                                              i]
                                                                          .oqty ??
                                                                      '0',
                                                                ),
                                                                subListText(
                                                                  kBalance,
                                                                  element
                                                                          .outwardList?[
                                                                              i]
                                                                          .bqty ??
                                                                      '0',
                                                                ),
                                                              ],
                                                            ),
                                                          const Divider(
                                                            color:
                                                                mColorCard1Secondary,
                                                            thickness: 0.5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return listOfSubItemsWidgets;
                                              }(element),
                                            ),
                                            bottomTitleWidget(
                                              '${element.itemName ?? ''} : CLOSING STOCK',
                                              element.closingStock ?? '0',
                                              color: mColorBackground,
                                            ),
                                          ],
                                        ),
                                      ),
                                      AppSpaces.v4,
                                    ],
                                  ),
                                AppSpaces.v6,
                              ],
                            );
                          },
                        );
            },
          ),
        );
      },
    );
  }
}

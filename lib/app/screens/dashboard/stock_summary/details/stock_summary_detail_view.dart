import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/details/stock_summary_excel.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/details/stock_summary_pdf.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/no_data_found.dart';
import 'package:cold_storage/app/utils/app_widgets/show_loader_text.dart';
import 'package:cold_storage/app/utils/stock_widgets/stock_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'stock_summary_detail_controller.dart';

class StockSummaryDetailView extends GetView<StockSummaryDetailController> {
  const StockSummaryDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StockSummaryDetailController(),
      builder: (controller) {
        return AppScaffold(
          bgColor: mColorAppbar,
          resizeToAvoidBottomInset: true,
          appBar: appBarWidget(
            context: context,
            titleText: 'Stock Summary',
            onTap: () {
              Get.back();
            },
            actions: Row(
              children: [
                InkWell(
                  onTap: () async {
                    await generateAndOpenStockSummaryPDF(
                      controller.stockSummaryDataList,
                    );
                  },
                  child: SvgPicture.asset(
                    kIconPdf,
                    height: 25,
                    width: 25,
                  ),
                ),
                AppSpaces.h10,
                InkWell(
                  onTap: () async {
                    await generateAndOpenStockSummaryExcel(
                      controller.stockSummaryDataList,
                    );
                  },
                  child: SvgPicture.asset(
                    kIconExcel,
                    height: 25,
                    width: 25,
                  ),
                ),
                AppSpaces.h10,
              ],
            ),
          ),
          body: Obx(
            () {
              return controller.isDataLoading.value
                  ? showLoaderText()
                  : controller.stockSummaryDataList.isEmpty
                      ? noDataFound(
                          text: kNoDataFound,
                        )
                      : ListView.builder(
                          itemCount: controller.stockSummaryDataList.length,
                          padding: const EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            var data = controller.stockSummaryDataList[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleWidget(
                                  data.companyName ?? '',
                                  bgColor: mColorCard2Primary,
                                  textColor: mColorCard2Secondary,
                                ),
                                AppSpaces.v10,
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: (data.itemData ?? []).length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, subIndex) {
                                    var subCatData = data.itemData?[subIndex];
                                    return Column(
                                      children: [
                                        Card(
                                          color: mColorBackground,
                                          child: Column(
                                            children: [
                                              subTitleWidget(
                                                subCatData?.itemName ?? '',
                                                bgColor: mColorBackground,
                                                textColor: mColorPrimaryText,
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  color: mColorBackground,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 8,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        subListText(
                                                          kOpeningQty,
                                                          subCatData?.opqty ??
                                                              '0',
                                                        ),
                                                        subListText(
                                                          kIWQty,
                                                          subCatData?.iqty ??
                                                              '0',
                                                        ),
                                                        subListText(
                                                          kOW,
                                                          subCatData?.oqty ??
                                                              '0',
                                                        ),
                                                        subListText(
                                                          '$kQty $kBalance',
                                                          subCatData?.bqty ??
                                                              '0',
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        AppSpaces.v4,
                                      ],
                                    );
                                  },
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

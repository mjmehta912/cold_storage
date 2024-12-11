import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/details/model/res/stock_summary_details_res_model.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/no_data_found.dart';
import 'package:cold_storage/app/utils/app_widgets/show_loader_text.dart';
import 'package:cold_storage/app/utils/stock_widgets/stock_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'stock_summary_detail_controller.dart';

class StockSummaryDetailView extends GetView<StockSummaryDetailController> {
  const StockSummaryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: StockSummaryDetailController(),
      builder: (controller) {
        return AppScaffold(
          resizeToAvoidBottomInset: true,
          appBar: appBarWidget(
            context: context,
            titleText: kStockSummary,
            onTap: () {
              Get.back();
            },
          ),
          body: _stockSummaryListView(),
        );
      },
    );
  }

  _stockSummaryListView() {
    return Obx(() {
      return controller.isDataLoading.value
          ? showLoaderText()
          : controller.stockSummaryDataList.isEmpty
              ? noDataFound(text: kNoDataFound)
              : ListView.builder(
                  itemCount: controller.stockSummaryDataList.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    var data = controller.stockSummaryDataList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          titleWidget(data.companyName ?? ''),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: (data.itemData ?? []).length,
                            shrinkWrap: true,
                            itemBuilder: (context, subIndex) {
                              var subCatData = data.itemData?[subIndex];
                              return Column(
                                children: [
                                  subTitleWidget(subCatData?.itemName ?? ''),
                                  _subListView(subCatData),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
    });
  }

  _subListView(ItemDatum? subCatData) {
    return Container(
      decoration: const BoxDecoration(
        color: kColorWhite,
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              subListText(kOpeningQty, subCatData?.opqty ?? '0'),
              subListText(kIWQty, subCatData?.iqty ?? '0'),
              subListText(kOW, subCatData?.oqty ?? '0'),
              subListText('$kQty $kBalance', subCatData?.bqty ?? '0'),
            ],
          ),
        ],
      ),
    );
  }
}

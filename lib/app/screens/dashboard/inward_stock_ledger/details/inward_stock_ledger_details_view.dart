import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/inward_stock_ledger_detail_controller.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/inward_stock_ledger_pdf.dart';
import 'package:cold_storage/app/screens/dashboard/inward_stock_ledger/details/model/res/inward_stock_ledger_details_res_model.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/no_data_found.dart';
import 'package:cold_storage/app/utils/app_widgets/show_loader_text.dart';
import 'package:cold_storage/app/utils/general/general_utils.dart';
import 'package:cold_storage/app/utils/stock_widgets/stock_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InwardStockLedgerDetailView
    extends GetView<InwardStockLedgerDetailController> {
  const InwardStockLedgerDetailView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InwardStockLedgerDetailController(),
      builder: (controller) {
        return AppScaffold(
          bgColor: mColorAppbar,
          resizeToAvoidBottomInset: true,
          appBar: appBarWidget(
            context: context,
            titleText: 'Inward Stock Ledger',
            onTap: () {
              Get.back();
            },
            actions: IconButton(
              onPressed: () async {
                await generateAndOpenInwardStockLedgerPDF(
                    controller.inwardStockLedgerList);
              },
              icon: const Icon(
                Icons.file_download_outlined,
                size: 25,
                color: mColorPrimaryText,
              ),
            ),
          ),
          body: Obx(
            () {
              return controller.isDataLoading.value
                  ? showLoaderText()
                  : controller.inwardStockLedgerList.isEmpty
                      ? noDataFound(
                          text: kNoDataFound,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12),
                          child: ListView.builder(
                            itemCount: controller.inwardStockLedgerList.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              var data =
                                  controller.inwardStockLedgerList[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleWidget(
                                    data.companyName ?? '',
                                    bgColor: mColorCard1Primary,
                                    textColor: mColorCard1Secondary,
                                  ),
                                  AppSpaces.v10,
                                  for (InwardItemsDetail element
                                      in data.inwardItemsDetail ?? [])
                                    Column(
                                      children: [
                                        Card(
                                          color: mColorBackground,
                                          child: Column(
                                            children: [
                                              subTitleWidget(
                                                element.itemName ?? '',
                                                bgColor: mColorBackground,
                                                textColor: mColorPrimaryText,
                                              ),
                                              Column(
                                                children: (List<InwardDetail>
                                                    subItems) {
                                                  List<Widget>
                                                      listOfSubItemsWidgets =
                                                      [];
                                                  for (var data in subItems) {
                                                    listOfSubItemsWidgets.add(
                                                      Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              mColorBackground,
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 12,
                                                          vertical: 4,
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    subListText(
                                                                      '$kInwardNo.',
                                                                      data.inwno ??
                                                                          '',
                                                                    ),
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        clipToCopy(
                                                                          text: data.inwno ??
                                                                              '',
                                                                        );
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .copy_rounded,
                                                                        size:
                                                                            20,
                                                                        color:
                                                                            mColorCard1Secondary,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                AppSpaces.h20,
                                                                subListText(
                                                                  kDate,
                                                                  data.idate ??
                                                                      '',
                                                                ),
                                                              ],
                                                            ),
                                                            AppSpaces.v4,
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                subListText(
                                                                  kOpeningQty,
                                                                  data.opqty ??
                                                                      '0',
                                                                ),
                                                                subListText(
                                                                  kInward,
                                                                  data.iqty ??
                                                                      '0',
                                                                ),
                                                                subListText(
                                                                  kOutward,
                                                                  data.oqty ??
                                                                      '0',
                                                                ),
                                                                subListText(
                                                                  kBalance,
                                                                  data.bqty ??
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
                                                }(
                                                  element.inwardDetail ?? [],
                                                ),
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
                          ),
                        );
            },
          ),
        );
      },
    );
  }
}

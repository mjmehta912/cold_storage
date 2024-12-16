import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/screens/dashboard/home/base/home_base_view.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/base/stock_summary_base_controller.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_drop_down.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text_field.dart';
import 'package:cold_storage/app/utils/app_widgets/custom_drop_down_widgets/cust_drop_down.dart';
import 'package:cold_storage/app/utils/app_widgets/custom_drop_down_widgets/items_drop_down.dart';
import 'package:cold_storage/app/utils/dialogs/app_dialogs.dart';
import 'package:cold_storage/app/utils/extensions/app_date_time_extension.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockSummaryBaseView extends GetView<StockSummaryBaseController> {
  final bool? isComingFromHome;

  StockSummaryBaseView({
    super.key,
    this.isComingFromHome,
  }) {
    controller.isComingFromHome.value = isComingFromHome ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return AppScaffold(
          bgColor: mColorBackground,
          resizeToAvoidBottomInset: true,
          appBar: appBarWidget(
            context: context,
            titleText: 'Stock Summary',
            isShowBackButton: !controller.isComingFromHome.value,
            onTap: () {
              Get.back();
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: controller.textFieldTitlePadding,
                        child: AppText(
                          text: kFromDate,
                          style: TextStyles.kPrimarySemiBoldPublicSans(
                            fontSize: TextStyles.k18FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ),
                      AppTextField(
                        controller: controller.dateFromController,
                        readOnly: true,
                        onTap: () {
                          AppDialogs.selectDate(
                            context: context,
                            onSelected: (date) {
                              if (date == null) return;
                              controller.dateFrom.value = date;

                              controller.dateFromController.text =
                                  date.dateWithYear;
                            },
                            initialDate: controller.dateFrom.value,
                            lastDate: DateTime(2050),
                            firstDate: DateTime(1900),
                          );
                        },
                      ),
                    ],
                  ),
                  AppSpaces.v10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: controller.textFieldTitlePadding,
                        child: AppText(
                          text: kToDate,
                          style: TextStyles.kPrimarySemiBoldPublicSans(
                            fontSize: TextStyles.k18FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ),
                      AppTextField(
                        controller: controller.dateToController,
                        readOnly: true,
                        onTap: () {
                          AppDialogs.selectDate(
                            context: context,
                            onSelected: (date) {
                              if (date == null) return;
                              controller.dateTo.value = date;
                              controller.dateToController.text =
                                  date.dateWithYear;
                            },
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2050),
                            firstDate: DateTime(
                              controller.dateFrom.value.year,
                              controller.dateFrom.value.month,
                              controller.dateFrom.value.day + 1,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  AppSpaces.v12,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: controller.textFieldTitlePadding,
                        child: AppText(
                          text: kCustomers,
                          style: TextStyles.kPrimarySemiBoldPublicSans(
                            fontSize: TextStyles.k18FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ),
                      Obx(
                        () {
                          return CustDropdown(
                            items: controller.customers.map((e) => e).toList(),
                            hintText: kAll,
                            callBack: (p0) {
                              controller.selectedCustomers.clear();
                              controller.selectedCustomers.addAll(p0);
                              if (controller.selectedCustomers.isNotEmpty) {
                                controller.getItemsDataFromServer();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  Obx(
                    () => controller.selectedCustomers.isNotEmpty
                        ? AppSpaces.v10
                        : const SizedBox(),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.selectedCustomers.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: controller.textFieldTitlePadding,
                            child: AppText(
                              text: kItems,
                              style: TextStyles.kPrimarySemiBoldPublicSans(
                                fontSize: TextStyles.k18FontSize,
                                colors: mColorPrimaryText,
                              ),
                            ),
                          ),
                          ItemsDropdown(
                            items: controller.itemsList
                                .map(
                                  (element) => element,
                                )
                                .toList(),
                            hintText: controller.selectedCustomers.isEmpty
                                ? ''
                                : kAll,
                            callBack: (p0) {
                              controller.selectedItems.clear();
                              controller.selectedItems.addAll(p0);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  AppSpaces.v10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: controller.textFieldTitlePadding,
                        child: AppText(
                          text: kViewBy,
                          style: TextStyles.kPrimarySemiBoldPublicSans(
                            fontSize: TextStyles.k18FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ),
                      Obx(
                        () {
                          return AppDropDown(
                            showSearchBox: false,
                            selectedItem: controller.selectedViewBy?.name,
                            items: controller.viewByList
                                .map(
                                  (element) => element.name,
                                )
                                .toList(),
                            onChanged: (String? value) {
                              controller.selectedViewBy = controller.viewByList
                                  .where(
                                    (e) => (e.name) == (value ?? ''),
                                  )
                                  .first;
                            },
                            string: (item) =>
                                controller.viewByList
                                    .where(
                                      (v) => v.name.toString() == item,
                                    )
                                    .firstOrNull
                                    ?.name ??
                                '',
                          );
                        },
                      ),
                    ],
                  ),
                  AppSpaces.v10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: controller.textFieldTitlePadding,
                        child: AppText(
                          text: kClosingBal,
                          style: TextStyles.kPrimarySemiBoldPublicSans(
                            fontSize: TextStyles.k18FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ),
                      Obx(
                        () {
                          return AppDropDown(
                            showSearchBox: false,
                            selectedItem: controller.selectedClosingBal?.name,
                            items: controller.closingBalList
                                .map(
                                  (element) => element.name,
                                )
                                .toList(),
                            onChanged: (String? value) {
                              controller.selectedClosingBal =
                                  controller.closingBalList
                                      .where(
                                        (e) => (e.name) == (value ?? ''),
                                      )
                                      .first;
                            },
                            string: (item) =>
                                controller.closingBalList
                                    .where(
                                      (v) => v.name.toString() == item,
                                    )
                                    .firstOrNull
                                    ?.name ??
                                '',
                          );
                        },
                      ),
                    ],
                  ),
                  AppSpaces.v16,
                  CustomHomeCard(
                    onTap: () {
                      controller.navigateToDetailsScreen();
                    },
                    bgColor: mColorCard2Primary,
                    title: 'Search $kStockSummary',
                    titleColor: mColorCard2Secondary,
                    image: mIconStockSummary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

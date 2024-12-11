import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/screens/dashboard/stock_summary/base/stock_summary_base_controller.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_drop_down.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
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

  StockSummaryBaseView({super.key, this.isComingFromHome}) {
    controller.isComingFromHome.value = isComingFromHome ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppScaffold(
        resizeToAvoidBottomInset: true,
        appBar: appBarWidget(
          context: context,
          titleText: kStockSummary,
          isShowBackButton: !controller.isComingFromHome.value,
          onTap: () {
            Get.back();
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                _fromDate(context),
                AppSpaces.v12,
                _toDate(context),
                AppSpaces.v12,
                _customerDropdown(context),
                AppSpaces.v12,
                _itemsDropdown(context),
                AppSpaces.v12,
                _viewBy(context),
                AppSpaces.v12,
                _closingBal(context),
                AppSpaces.v12,
                appButton(
                  buttonWidth: 0.45.screenWidth,
                  onPressed: () {
                    controller.navigateToDetailsScreen();
                  },
                  buttonText: kSearch,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _fromDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kFromDate,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        AppTextField(
          labelText: '',
          controller: controller.dateFromController,
          readOnly: true,
          onTap: () {
            AppDialogs.selectDate(
              context: context,
              onSelected: (date) {
                if (date == null) return;
                controller.dateFrom.value = date;

                controller.dateFromController.text = date.dateWithYear;
              },
              initialDate: controller.dateFrom.value,
              lastDate: DateTime(2050),
              // firstDate: DateTime(DateTime.now().year, DateTime.april, 1),
              firstDate: DateTime(1900),
            );
          },
        ),
      ],
    );
  }

  Widget _toDate(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kToDate,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
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
                controller.dateToController.text = date.dateWithYear;
              },
              initialDate: DateTime.now(),
              lastDate: DateTime(2050),
              // firstDate: DateTime.now(),
              firstDate: DateTime(
                  controller.dateFrom.value.year,
                  controller.dateFrom.value.month,
                  controller.dateFrom.value.day + 1),
            );
          },
        ),
      ],
    );
  }

  Widget _viewBy(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kViewBy,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        Obx(
          () {
            return AppDropDown(
              showSearchBox: false,
              selectedItem: controller.selectedViewBy?.name,
              items: controller.viewByList
                  .map((element) => element.name ?? '')
                  .toList(),
              onChanged: (String? value) {
                controller.selectedViewBy = controller.viewByList
                    .where((e) => (e.name ?? '') == (value ?? ''))
                    .first;
              },
              string: (item) =>
                  controller.viewByList
                      .where((v) => v.name.toString() == item)
                      .firstOrNull
                      ?.name ??
                  '',
            );
          },
        ),
      ],
    );
  }

  Widget _closingBal(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kClosingBal,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        Obx(
          () {
            return AppDropDown(
              showSearchBox: false,
              selectedItem: controller.selectedClosingBal?.name,
              items: controller.closingBalList
                  .map((element) => element.name ?? '')
                  .toList(),
              onChanged: (String? value) {
                controller.selectedClosingBal = controller.closingBalList
                    .where((e) => (e.name ?? '') == (value ?? ''))
                    .first;
              },
              string: (item) =>
                  controller.closingBalList
                      .where((v) => v.name.toString() == item)
                      .firstOrNull
                      ?.name ??
                  '',
            );
          },
        ),
      ],
    );
  }

  _customerDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kCustomers,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        Obx(() {
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
        }),
      ],
    );
  }

  _itemsDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kItems,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        Obx(() {
          return ItemsDropdown(
            items: controller.itemsList.map((element) => element).toList(),
            dropdownBGColor: controller.selectedCustomers.isEmpty
                ? kColorB9B5B2
                : kColorSecondPrimary,
            hintText: controller.selectedCustomers.isEmpty ? '' : kAll,
            callBack: (p0) {
              controller.selectedItems.clear();
              controller.selectedItems.addAll(p0);
            },
          );
        }),
      ],
    );
  }
}

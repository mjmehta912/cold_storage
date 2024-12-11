import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/base/account_ledger_report_base_controller.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_drop_down.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text_field.dart';
import 'package:cold_storage/app/utils/dialogs/app_dialogs.dart';
import 'package:cold_storage/app/utils/extensions/app_date_time_extension.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountLedgerReportBaseView
    extends GetView<AccountLedgerReportBaseController> {
  final bool? isComingFromHome;

  AccountLedgerReportBaseView({super.key, this.isComingFromHome}) {
    controller.isComingFromHome.value = isComingFromHome ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AccountLedgerReportBaseController(),
      builder: (controller) {
        return Obx(() {
          return AppScaffold(
            resizeToAvoidBottomInset: true,
            appBar: appBarWidget(
              context: context,
              titleText: kAccountLedgerReport,
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
                    Obx(() {
                      return appButton(
                        buttonWidth: 0.45.screenWidth,
                        onPressed: () {
                          if (controller.selectedCustomers.value.pname != '' &&
                              (controller.selectedCustomers.value.pname ?? '')
                                  .isNotEmpty) {
                            controller.navigateToDetailsScreen();
                          }
                        },
                        buttonText: kSearch,
                        buttonBorderColor:
                            controller.selectedCustomers.value.pname != '' &&
                                    (controller.selectedCustomers.value.pname ??
                                            '')
                                        .isNotEmpty
                                ? kColorBlack
                                : kColorCBD2DC,
                        buttonColor: controller.selectedCustomers.value.pname !=
                                    '' &&
                                (controller.selectedCustomers.value.pname ?? '')
                                    .isNotEmpty
                            ? kColorBlack
                            : kColorCBD2DC,
                        textStyle: TextStyles.kPrimaryBoldInter(
                                fontSize: TextStyles.k24FontSize)
                            .copyWith(
                          color: controller.selectedCustomers.value.pname !=
                                      '' &&
                                  (controller.selectedCustomers.value.pname ??
                                          '')
                                      .isNotEmpty
                              ? kColorPrimary //
                              : kColor8C8B8A,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
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
              // firstDate: DateTime(DateTime
              //     .now()
              //     .year, DateTime.april, 1),
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

  _customerDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
          return AppDropDown(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            items:
                controller.customers.map((cust) => cust.pname ?? '').toList(),
            string: (item) =>
                controller.customers
                    .where((cust) => cust.pname.toString() == item)
                    .firstOrNull
                    ?.pname ??
                '',
            onChanged: (String? value) {
              controller.selectedCustomers.value = controller.customers
                  .where((e) => (e.pname ?? '') == (value ?? ''))
                  .first;
            },
          );
        }),
      ],
    );
  }
}

import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/screens/dashboard/accout_ledger_report/base/account_ledger_report_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/home/base/home_base_view.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_drop_down.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
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
            bgColor: mColorBackground,
            resizeToAvoidBottomInset: true,
            appBar: appBarWidget(
              context: context,
              titleText: kAccountLedgerReport,
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
                    AppSpaces.v10,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            return AppDropDown(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              items: controller.customers
                                  .map(
                                    (cust) => cust.pname ?? '',
                                  )
                                  .toList(),
                              string: (item) =>
                                  controller.customers
                                      .where(
                                        (cust) => cust.pname.toString() == item,
                                      )
                                      .firstOrNull
                                      ?.pname ??
                                  '',
                              onChanged: (String? value) {
                                controller.selectedCustomers.value =
                                    controller.customers
                                        .where(
                                          (e) =>
                                              (e.pname ?? '') == (value ?? ''),
                                        )
                                        .first;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    AppSpaces.v16,
                    CustomHomeCard(
                      onTap: () {
                        if (controller.selectedCustomers.value.pname != '' &&
                            (controller.selectedCustomers.value.pname ?? '')
                                .isNotEmpty) {
                          controller.navigateToDetailsScreen();
                        }
                      },
                      bgColor: mColorCard4Primary,
                      title: 'Search $kAccountLedger',
                      titleColor: mColorCard4Secondary,
                      image: mIconAccountLedger,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

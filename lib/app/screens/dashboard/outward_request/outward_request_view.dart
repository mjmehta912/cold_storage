import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/screens/dashboard/home/base/home_base_view.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/outward_request_controller.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
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
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OutwardRequestView extends GetView<OutwardRequestController> {
  final bool? isComingFromHome;

  OutwardRequestView({
    super.key,
    this.isComingFromHome,
  }) {
    controller.isComingFromHome.value = isComingFromHome ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OutwardRequestController(),
      builder: (controller) {
        return AppScaffold(
          bgColor: mColorBackground,
          resizeToAvoidBottomInset: true,
          appBar: appBarWidget(
            context: context,
            titleText: 'Outward Request',
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
                              controller.resetObjects();
                              controller.selectedCustomers.value =
                                  controller.customers
                                      .where(
                                        (e) => (e.pname ?? '') == (value ?? ''),
                                      )
                                      .first;
                              if ((controller.selectedCustomers.value.pname ??
                                      '')
                                  .isNotEmpty) {
                                controller.getInwardNoFromServerApiCall();
                                // controller.getItemsDataFromServer();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  AppSpaces.v10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 0.44.screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: controller.textFieldTitlePadding,
                              child: AppText(
                                text: kDeliveryDate,
                                style: TextStyles.kPrimarySemiBoldPublicSans(
                                  fontSize: TextStyles.k18FontSize,
                                  colors: mColorPrimaryText,
                                ),
                              ),
                            ),
                            AppTextField(
                              controller: controller.dateController,
                              readOnly: true,
                              padding: const EdgeInsets.all(8),
                              onTap: () {
                                AppDialogs.selectDate(
                                  context: context,
                                  onSelected: (date) {
                                    if (date == null) return;
                                    controller.selectedDate.value = date;

                                    controller.dateController.text =
                                        date.dateWithYear;
                                  },
                                  initialDate: controller.selectedDate.value,
                                  lastDate: DateTime(2050),
                                  firstDate: DateTime.now().add(
                                    const Duration(
                                      days: 1,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0.44.screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: controller.textFieldTitlePadding,
                              child: AppText(
                                text: kTime,
                                style: TextStyles.kPrimarySemiBoldPublicSans(
                                  fontSize: TextStyles.k18FontSize,
                                  colors: mColorPrimaryText,
                                ),
                              ),
                            ),
                            AppTextField(
                              controller: controller.timeController,
                              readOnly: true,
                              onTap: () {
                                AppDialogs.selectTime(
                                  context: context,
                                  onSelected: (time) {
                                    if (time != null &&
                                        controller.isTimeInFuture(time)) {
                                      controller.isTimeInFuture(time);
                                      controller.selectedTime.value = time;

                                      controller.timeController.text =
                                          time.format(context);
                                    } else {
                                      return;
                                    }
                                  },
                                  initialTime: controller.selectedTime.value,
                                );
                              },
                            ),
                          ],
                        ),
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
                          text: '$kInwardNo.',
                          style: TextStyles.kPrimarySemiBoldPublicSans(
                            fontSize: TextStyles.k18FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ),
                      Obx(
                        () {
                          return AppDropDown(
                            items: controller.inwardNoList,
                            selectedItem: controller.selectedInwardNo.value,
                            string: (item) =>
                                controller.inwardNoList
                                    .where(
                                      (data) =>
                                          data.invno.toString() == item.invno,
                                    )
                                    .firstOrNull
                                    ?.invno ??
                                '',
                            onChanged: (value) {
                              controller.selectedInwardNo.value = value!;
                              controller.getLotNoFromServerApiCall();
                            },
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
                          text: '$kLotNo.',
                          style: TextStyles.kPrimarySemiBoldPublicSans(
                            fontSize: TextStyles.k18FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ),
                      Obx(() {
                        return AppDropDown(
                          items: controller.lotNoList,
                          selectedItem: controller.selectedLotNo.value,
                          string: (item) =>
                              controller.lotNoList
                                  .where(
                                    (data) => data.toString() == item,
                                  )
                                  .firstOrNull ??
                              '',
                          onChanged: (value) {
                            controller.selectedLotNo.value = value!;
                            controller.getLotBalanceFromServerApiCall();
                          },
                        );
                      }),
                    ],
                  ),
                  AppSpaces.v10,
                  Column(
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
                      Obx(
                        () {
                          return AppDropDown(
                            items: controller.lotBalanceList,
                            selectedItem: controller.selectedLotBalance.value,
                            string: (item) =>
                                controller.lotBalanceList
                                    .where(
                                      (data) =>
                                          data.iname.toString() == item.iname,
                                    )
                                    .firstOrNull
                                    ?.iname ??
                                '',
                            onChanged: (value) {
                              controller.selectedLotBalance.value = value!;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  AppSpaces.v10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 0.44.screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: controller.textFieldTitlePadding,
                              child: AppText(
                                text: '$kOutward $kQty',
                                style: TextStyles.kPrimarySemiBoldPublicSans(
                                  fontSize: TextStyles.k18FontSize,
                                  colors: mColorPrimaryText,
                                ),
                              ),
                            ),
                            Obx(() {
                              return AppTextField(
                                controller:
                                    controller.outwardQtyController.value,
                                textInputType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    if (int.parse(value) >
                                        int.parse(controller
                                            .balanceQtyController.text
                                            .trim())) {
                                      Get.find<AlertMessageUtils>()
                                          .showErrorSnackBar1(
                                              kEnterQtyLessThanBalanceQty
                                                      .capitalizeFirst ??
                                                  '');
                                      controller.outwardQtyController.value
                                          .clear();
                                      controller.isOutwardQtyGreater.value =
                                          false;
                                    } else {
                                      controller.isOutwardQtyGreater.value =
                                          true;
                                    }
                                  } else {
                                    controller.isOutwardQtyGreater.value =
                                        false;
                                  }
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 0.44.screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: controller.textFieldTitlePadding,
                              child: AppText(
                                text: '$kBalance $kQty',
                                style: TextStyles.kPrimarySemiBoldPublicSans(
                                  fontSize: TextStyles.k18FontSize,
                                  colors: mColorPrimaryText,
                                ),
                              ),
                            ),
                            AppTextField(
                              controller: controller.balanceQtyController,
                              readOnly: true,
                            ),
                          ],
                        ),
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
                          text: kVehicleType,
                          style: TextStyles.kPrimarySemiBoldPublicSans(
                            fontSize: TextStyles.k18FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ),
                      AppDropDown(
                        showSearchBox: false,
                        items: controller.vehicleType,
                        selectedItem: controller.selectedVehicleType.value,
                        string: (item) =>
                            controller.vehicleType
                                .where(
                                  (data) =>
                                      data.typeName.toString() == item.typeName,
                                )
                                .firstOrNull
                                ?.typeName ??
                            '',
                        onChanged: (value) {
                          controller.selectedVehicleType.value =
                              controller.vehicleType
                                  .where(
                                    (e) =>
                                        (e.typeName ?? '') ==
                                        (value?.typeName ?? ''),
                                  )
                                  .first;
                        },
                      ),
                    ],
                  ),
                  AppSpaces.v16,
                  Obx(
                    () => CustomHomeCard(
                      onTap: () {
                        if ((controller.selectedCustomers.value.pname ?? '')
                                .isNotEmpty &&
                            ((controller.selectedInwardNo.value.invno ?? '')
                                .isNotEmpty) &&
                            ((controller.selectedLotBalance.value.iname ?? '')
                                .isNotEmpty) &&
                            controller.isOutwardQtyGreater.value == true) {
                          controller.placeRequestApiCall();
                        }
                      },
                      bgColor: ((controller.selectedCustomers.value.pname ?? '')
                                  .isNotEmpty &&
                              ((controller.selectedInwardNo.value.invno ?? '')
                                  .isNotEmpty) &&
                              ((controller.selectedLotBalance.value.iname ?? '')
                                  .isNotEmpty) &&
                              controller.isOutwardQtyGreater.value == true)
                          ? mColorCard5Primary
                          : const Color(0xFFE9E9E9),
                      title: kOutwardRequest,
                      titleColor: ((controller.selectedCustomers.value.pname ??
                                      '')
                                  .isNotEmpty &&
                              ((controller.selectedInwardNo.value.invno ?? '')
                                  .isNotEmpty) &&
                              ((controller.selectedLotBalance.value.iname ?? '')
                                  .isNotEmpty) &&
                              controller.isOutwardQtyGreater.value == true)
                          ? mColorCard5Secondary
                          : const Color(0xFF525252),
                      image: mIconOutwardRequests,
                    ),
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

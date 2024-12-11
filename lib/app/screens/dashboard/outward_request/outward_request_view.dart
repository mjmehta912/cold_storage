import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/screens/dashboard/outward_request/outward_request_controller.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
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
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OutwardRequestView extends GetView<OutwardRequestController> {
  final bool? isComingFromHome;

  OutwardRequestView({super.key, this.isComingFromHome}) {
    controller.isComingFromHome.value = isComingFromHome ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OutwardRequestController(),
      builder: (controller) {
        return AppScaffold(
          resizeToAvoidBottomInset: true,
          appBar: appBarWidget(
            context: context,
            titleText: kOutwardRequest,
            isShowBackButton: !controller.isComingFromHome.value,
            onTap: () {
              Get.back();
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  _customerDropdown(context),
                  AppSpaces.v12,
                  _dateAndTime(context),
                  AppSpaces.v12,
                  _inwardNoDropdown(context),
                  AppSpaces.v12,
                  _lotNoDropdown(context),
                  AppSpaces.v12,
                  _itemsDropdown(context),
                  AppSpaces.v12,
                  _outwardQtyAndBalanceQty(context),
                  AppSpaces.v12,
                  _vehicleTypeDropdown(context),
                  AppSpaces.v12,
                  Obx(
                    () {
                      return appButton(
                        buttonWidth: 0.45.screenWidth,
                        onPressed: () {
                          if ((controller.selectedCustomers.value.pname ?? '')
                                  .isNotEmpty &&
                              ((controller.selectedInwardNo.value.invno ?? '')
                                  .isNotEmpty) &&
                              ((controller.selectedLotBalance.value.iname ?? '')
                                  .isNotEmpty) &&
                              // ((controller.selectedVehicleType.value.typeName ??
                              //         '')
                              //     .isNotEmpty) &&

                              // controller.outwardQtyController.value.text
                              //     .trim()
                              //     .isNotEmpty &&
                              // int.parse(controller.outwardQtyController.value.text
                              //         .trim()) >
                              //     0 &&
                              controller.isOutwardQtyGreater.value == true) {
                            controller.placeRequestApiCall();
                          }
                        },
                        buttonText: kSave,
                        buttonColor: ((controller
                                            .selectedCustomers.value.pname ??
                                        '')
                                    .isNotEmpty &&
                                ((controller.selectedInwardNo.value.invno ?? '')
                                    .isNotEmpty) &&
                                ((controller.selectedLotBalance.value.iname ??
                                        '')
                                    .isNotEmpty) &&
                                // ((controller.selectedVehicleType.value.typeName ??
                                //         '')
                                //     .isNotEmpty) &&

                                // controller.outwardQtyController.value.text
                                //     .trim()
                                //     .isNotEmpty &&
                                // int.parse(controller
                                //         .outwardQtyController.value.text
                                //         .trim()) >
                                //     0 &&
                                controller.isOutwardQtyGreater.value == true)
                            ? kColorBlack
                            : kColorCBD2DC,
                        buttonBorderColor: ((controller
                                            .selectedCustomers.value.pname ??
                                        '')
                                    .isNotEmpty &&
                                ((controller.selectedInwardNo.value.invno ?? '')
                                    .isNotEmpty) &&
                                ((controller.selectedLotBalance.value.iname ??
                                        '')
                                    .isNotEmpty) &&
                                // ((controller.selectedVehicleType.value.typeName ??
                                //         '')
                                //     .isNotEmpty) &&

                                // controller.outwardQtyController.value.text
                                //     .trim()
                                //     .isNotEmpty &&
                                // controller.outwardQtyController.value.text
                                //     .trim()
                                //     .isNotEmpty &&
                                // int.parse(controller
                                //         .outwardQtyController.value.text
                                //         .trim()) >
                                //     0 &&
                                controller.isOutwardQtyGreater.value == true)
                            ? kColorBlack
                            : kColorCBD2DC,
                        textStyle: TextStyles.kPrimaryBoldInter(
                                fontSize: TextStyles.k24FontSize)
                            .copyWith(
                          color: ((controller.selectedCustomers.value.pname ??
                                          '')
                                      .isNotEmpty &&
                                  ((controller.selectedInwardNo.value.invno ??
                                          '')
                                      .isNotEmpty) &&
                                  ((controller.selectedLotBalance.value.iname ??
                                          '')
                                      .isNotEmpty) &&
                                  // ((controller.selectedVehicleType.value
                                  //             .typeName ??
                                  //         '')
                                  //     .isNotEmpty) &&
                                  controller.outwardQtyController.value.text
                                      .trim()
                                      .isNotEmpty &&
                                  int.parse(controller
                                          .outwardQtyController.value.text
                                          .trim()) >
                                      0 &&
                                  controller.isOutwardQtyGreater.value == true)
                              ? kColorPrimary
                              : kColor8C8B8A,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _dateAndTime(BuildContext context) {
    return Row(
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
                  style: TextStyles.kPrimaryBoldInter(
                    fontSize: TextStyles.k16FontSize,
                    colors: kColorSecondPrimary,
                  ),
                ),
              ),
              AppTextField(
                labelText: '',
                controller: controller.dateController,
                readOnly: true,
                padding: const EdgeInsets.all(8),
                onTap: () {
                  AppDialogs.selectDate(
                    context: context,
                    onSelected: (date) {
                      if (date == null) return;
                      controller.selectedDate.value = date;

                      controller.dateController.text = date.dateWithYear;
                    },
                    initialDate: controller.selectedDate.value,
                    lastDate: DateTime(2050),
                    firstDate: DateTime.now().add(const Duration(days: 1)),
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
                  style: TextStyles.kPrimaryBoldInter(
                    fontSize: TextStyles.k16FontSize,
                    colors: kColorSecondPrimary,
                  ),
                ),
              ),
              AppTextField(
                labelText: '',
                controller: controller.timeController,
                readOnly: true,
                onTap: () {
                  AppDialogs.selectTime(
                    context: context,
                    onSelected: (time) {
                      if (time != null && controller.isTimeInFuture(time)) {
                        controller.isTimeInFuture(time);
                        controller.selectedTime.value = time;

                        controller.timeController.text = time.format(context);
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
        Obx(
          () {
            return AppDropDown(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
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
                controller.resetObjects();
                controller.selectedCustomers.value = controller.customers
                    .where((e) => (e.pname ?? '') == (value ?? ''))
                    .first;
                if ((controller.selectedCustomers.value.pname ?? '')
                    .isNotEmpty) {
                  controller.getInwardNoFromServerApiCall();
                  // controller.getItemsDataFromServer();
                }
              },
            );
          },
        ),
      ],
    );
  }

  _inwardNoDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: '$kInwardNo.',
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        Obx(() {
          return AppDropDown(
            items: controller.inwardNoList,
            selectedItem: controller.selectedInwardNo.value,
            string: (item) =>
                controller.inwardNoList
                    .where((data) => data.invno.toString() == item.invno)
                    .firstOrNull
                    ?.invno ??
                '',
            onChanged: (value) {
              controller.selectedInwardNo.value = value!;
              controller.getLotNoFromServerApiCall();
            },
          );
        }),
      ],
    );
  }

  _lotNoDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: '$kLotNo.',
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        Obx(() {
          return AppDropDown(
            items: controller.lotNoList,
            selectedItem: controller.selectedLotNo.value,
            string: (item) =>
                controller.lotNoList
                    .where((data) => data.toString() == item)
                    .firstOrNull ??
                '',
            onChanged: (value) {
              controller.selectedLotNo.value = value!;
              controller.getLotBalanceFromServerApiCall();
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
          return AppDropDown(
            items: controller.lotBalanceList,
            selectedItem: controller.selectedLotBalance.value,
            string: (item) =>
                controller.lotBalanceList
                    .where((data) => data.iname.toString() == item.iname)
                    .firstOrNull
                    ?.iname ??
                '',
            onChanged: (value) {
              controller.selectedLotBalance.value = value!;
            },
          );
        }),
        // Obx(() {
        //   return ItemsDropdown(
        //     items: controller.itemsList.map((element) => element).toList(),
        //     hintText: '',
        //     callBack: (p0) {
        //       controller.selectedItems.clear();
        //       controller.selectedItems.addAll(p0);
        //     },
        //   );
        // }),
      ],
    );
  }

  _vehicleTypeDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kVehicleType,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        AppDropDown(
          showSearchBox: false,
          items: controller.vehicleType,
          selectedItem: controller.selectedVehicleType.value,
          string: (item) =>
              controller.vehicleType
                  .where((data) => data.typeName.toString() == item.typeName)
                  .firstOrNull
                  ?.typeName ??
              '',
          onChanged: (value) {
            controller.selectedVehicleType.value = controller.vehicleType
                .where((e) => (e.typeName ?? '') == (value?.typeName ?? ''))
                .first;
          },
        ),
      ],
    );
  }

  _outwardQtyAndBalanceQty(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 0.45.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: controller.textFieldTitlePadding,
                child: AppText(
                  text: '$kOutward $kQty',
                  style: TextStyles.kPrimaryBoldInter(
                    fontSize: TextStyles.k16FontSize,
                    colors: kColorSecondPrimary,
                  ),
                ),
              ),
              Obx(() {
                return AppTextField(
                  labelText: '',
                  controller: controller.outwardQtyController.value,
                  textInputType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (int.parse(value) >
                          int.parse(
                              controller.balanceQtyController.text.trim())) {
                        Get.find<AlertMessageUtils>().showErrorSnackBar1(
                            kEnterQtyLessThanBalanceQty.capitalizeFirst ?? '');
                        controller.outwardQtyController.value.clear();
                        controller.isOutwardQtyGreater.value = false;
                      } else {
                        controller.isOutwardQtyGreater.value = true;
                      }
                    } else {
                      controller.isOutwardQtyGreater.value = false;
                    }
                    print(
                        'controller.isOutwardQtyGreater.value ${controller.isOutwardQtyGreater.value}');
                  },
                );
              }),
            ],
          ),
        ),
        SizedBox(
          width: 0.45.screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: controller.textFieldTitlePadding,
                child: AppText(
                  text: '$kBalance $kQty',
                  style: TextStyles.kPrimaryBoldInter(
                    fontSize: TextStyles.k16FontSize,
                    colors: kColorSecondPrimary,
                  ),
                ),
              ),
              AppTextField(
                labelText: '',
                controller: controller.balanceQtyController,
                readOnly: true,
                fillColor: kColorPrimary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

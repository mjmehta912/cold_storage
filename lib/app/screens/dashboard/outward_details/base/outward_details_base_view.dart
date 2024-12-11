import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/screens/dashboard/outward_details/base/outward_details_base_controller.dart';
import 'package:cold_storage/app/screens/dashboard/outward_details/model/res/outward_details_res_model.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text_field.dart';
import 'package:cold_storage/app/utils/app_widgets/no_data_found.dart';
import 'package:cold_storage/app/utils/app_widgets/show_loader_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OutwardDetailsBaseView extends GetView<OutwardDetailsBaseController> {
  const OutwardDetailsBaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: appBarWidget(
        context: context,
        titleText: kOutwardDetails,
        onTap: () {
          Get.back();
        },
        actions: PopupMenuButton(
          onSelected: (value) {
            // your logic
          },
          color: kColorBackground,
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                value: '/$kAll',
                onTap: () {
                  controller.selectedFilterIndex.value = 0;
                  controller.updateListWithFilterData(kAll);
                },
                child: Obx(() {
                  return Row(
                    children: [
                      controller.selectedFilterIndex.value == 0
                          ? _fillCircleSvg()
                          : _emptyCircleSvg(),
                      AppText(
                        text: kAll,
                        style: TextStyles.kPrimaryBoldInter(
                          fontSize: TextStyles.k24FontSize,
                          colors: kColorBlack,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              PopupMenuItem(
                value: '/$kPending',
                onTap: () {
                  controller.selectedFilterIndex.value = 1;
                  controller.updateListWithFilterData(kPending);
                },
                child: Obx(() {
                  return Row(
                    children: [
                      controller.selectedFilterIndex.value == 1
                          ? _fillCircleSvg()
                          : _emptyCircleSvg(),
                      AppText(
                        text: kPending,
                        style: TextStyles.kPrimaryBoldInter(
                          fontSize: TextStyles.k24FontSize,
                          colors: kColorBlack,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              PopupMenuItem(
                value: '/$kAccepted',
                onTap: () {
                  controller.selectedFilterIndex.value = 2;
                  controller.updateListWithFilterData(kAccepted);
                },
                child: Obx(() {
                  return Row(
                    children: [
                      controller.selectedFilterIndex.value == 2
                          ? _fillCircleSvg()
                          : _emptyCircleSvg(),
                      AppText(
                        text: kAccepted,
                        style: TextStyles.kPrimaryBoldInter(
                          fontSize: TextStyles.k24FontSize,
                          colors: kColorBlack,
                        ),
                      ),
                    ],
                  );
                }),
              ),
              PopupMenuItem(
                value: '/$kRejected',
                onTap: () {
                  controller.selectedFilterIndex.value = 3;
                  controller.updateListWithFilterData(kRejected);
                },
                child: Obx(() {
                  return Row(
                    children: [
                      controller.selectedFilterIndex.value == 3
                          ? _fillCircleSvg()
                          : _emptyCircleSvg(),
                      AppText(
                        text: kRejected,
                        style: TextStyles.kPrimaryBoldInter(
                          fontSize: TextStyles.k24FontSize,
                          colors: kColorBlack,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ];
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SvgPicture.asset(kIconFilter),
          ),
        ),
      ),
      body: _outwardDetailsListView(),
    );
  }

  _outwardDetailsListView() {
    return Obx(
      () {
        return controller.isDataLoading.value
            ? showLoaderText()
            : controller.filterOutwardDetailsList.isEmpty
                ? noDataFound(text: kNoDataFound)
                : ListView.builder(
                    itemCount: controller.filterOutwardDetailsList.length,
                    itemBuilder: (context, index) {
                      var data = controller.filterOutwardDetailsList[index];
                      return Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: kColorWhite,
                          borderRadius: AppUIUtils.homeBorderRadius,
                          border: Border.all(color: kColorSecondPrimary),
                          boxShadow: [
                            BoxShadow(
                              color: kColorBlack.withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Visibility(
                              visible:
                                  controller.isViewRequest.value == false &&
                                      data.status != 'Pending',
                              child: _statusWidget(context, data),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _rowWidget(
                                        title: '$kRequestNo.',
                                        value: data.invno ?? '0'),
                                    AppSpaces.v2,
                                    _rowWidget(
                                        title: kDeliveryDate,
                                        value: data.date ?? ''),
                                    AppSpaces.v2,
                                    _rowWidget(
                                        title: kTime,
                                        value: data.outwardTime ?? ''),
                                    AppSpaces.v2,
                                    _rowWidget(
                                        title: kItem, value: data.iname ?? ''),
                                    AppSpaces.v2,
                                    _rowWidget(
                                        title: '$kInwardNo.',
                                        value: data.inwno ?? '0'),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    _rowWidget(
                                        title: '$kLotNo.',
                                        value: data.lotno ?? '0'),
                                    AppSpaces.v2,
                                    _rowWidget(
                                        title: kQty, value: data.qty ?? '0'),
                                    AppSpaces.v2,
                                    _rowWidget(
                                        title: kBalance,
                                        value: data.balqty ?? '0'),
                                    AppSpaces.v2,
                                    _rowWidget(
                                        title: kEntryDate,
                                        value: data.entryDate ?? ''),
                                    AppSpaces.v2,
                                    _rowWidget(
                                        title: kVehicleType,
                                        value: data.vehicleType ?? ''),
                                  ],
                                ),
                              ],
                            ),
                            AppSpaces.v2,
                            Visibility(
                              visible: controller.isViewRequest.value,
                              child: _statusWidget(context, data),
                            ),
                            Obx(
                              () {
                                return Visibility(
                                  visible:
                                      controller.isViewRequest.value == false &&
                                          data.status == 'Pending',
                                  child: _rejectAndAcceptRow(context, data),
                                );
                              },
                            ),
                            // Obx(
                            //   () {
                            //     return controller.isViewRequest.value
                            //         ? _statusWidget(context, data)
                            //         : _rejectAndAcceptRow(context, data);
                            //   },
                            // ),
                          ],
                        ),
                      );
                    },
                  );
      },
    );
  }

  _rowWidget({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 0.22.screenWidth,
          child: AppText(
            text: title,
            style: TextStyles.kPrimaryRegularInter(
              fontWeight: FontWeight.w400,
              colors: kColorSecondPrimary,
              fontSize: TextStyles.k12FontSize,
            ),
          ),
        ),
        // AppSpaces.h12,
        SizedBox(
          width: 0.22.screenWidth,
          child: AppText(
            text: value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k12FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
      ],
    );
  }

  _statusWidget(BuildContext context, OutwardDetailsData data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 0.22.screenWidth,
          child: AppText(
            text: kStatus,
            style: TextStyles.kPrimaryRegularInter(
              fontWeight: FontWeight.w400,
              colors: kColorSecondPrimary,
              fontSize: TextStyles.k12FontSize,
            ),
          ),
        ),
        // AppSpaces.h12,
        AppText(
          text: data.status ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyles.kPrimaryBoldInter(
            fontSize: TextStyles.k12FontSize,
            colors: controller.returnStatusColor(data),
          ),
        ),
      ],
    );
  }

  _rejectAndAcceptRow(BuildContext context, OutwardDetailsData data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 0.22.screenWidth,
              child: AppText(
                text: kCustomer,
                style: TextStyles.kPrimaryRegularInter(
                  fontWeight: FontWeight.w400,
                  colors: kColorSecondPrimary,
                ),
              ),
            ),
            // AppSpaces.h12,
            SizedBox(
              width: 0.32.screenWidth,
              child: AppText(
                text: data.pname ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.kPrimaryBoldInter(
                  fontSize: TextStyles.k12FontSize,
                  colors: kColorSecondPrimary,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            appButton(
              buttonWidth: 0.14.screenWidth,
              buttonHeight: 22,
              buttonColor: kColorRejectButton,
              buttonBorderColor: kColorRejectButton,
              buttonText: kReject,
              textStyle: TextStyles.kPrimaryBoldInter(
                fontSize: TextStyles.k10FontSize,
                colors: kColorBackground,
              ),
              borderRadius: 8,
              onPressed: () {
                _showRejectDialog(context, data);
              },
            ),
            AppSpaces.h6,
            appButton(
              buttonWidth: 0.14.screenWidth,
              buttonHeight: 22,
              buttonColor: kColorGreen,
              buttonBorderColor: kColorGreen,
              buttonText: kAccept,
              textStyle: TextStyles.kPrimaryBoldInter(
                fontSize: TextStyles.k10FontSize,
                colors: kColorBackground,
              ),
              borderRadius: 8,
              onPressed: () {
                controller.rejectReqApiCall(data, 1);
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showRejectDialog(BuildContext context, OutwardDetailsData data) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: kColorBackground,
          surfaceTintColor: kColorBackground,
          insetPadding: const EdgeInsets.symmetric(horizontal: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dialogHeader(context),
                AppSpaces.v16,
                _dialogRemarkTextField(context),
                AppSpaces.v16,
                appButton(
                  onPressed: () {
                    Get.back();
                    controller.rejectReqApiCall(data, 2);
                  },
                  buttonWidth: 0.4.screenWidth,
                  buttonText: kReject,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _dialogHeader(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: kRejectedReqText,
            style: TextStyles.kPrimaryRegularInter(
              fontSize: TextStyles.k14FontSize,
              colors: kColorBlack,
            ),
          ),
          TextSpan(
            text: 'CustomerName ',
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k14FontSize,
              colors: kColorBlack,
            ),
          ),
          TextSpan(
            text: kRejectedReqText2,
            style: TextStyles.kPrimaryRegularInter(
              fontSize: TextStyles.k14FontSize,
              colors: kColorBlack,
            ),
          ),
          TextSpan(
            text: ' A0135-1/330',
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k14FontSize,
              colors: kColorBlack,
            ),
          ),
        ],
      ),
    );
  }

  _dialogRemarkTextField(BuildContext context) {
    return AppTextField(
      controller: controller.remarkController,
      labelText: '$kRemarksHere...',
      labelStyle: TextStyles.kPrimaryRegularInter(
        colors: kColorD9D9D9,
      ),
      maxLines: 5,
      minLines: 2,
    );
  }

  _fillCircleSvg() {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: SvgPicture.asset(
        kIconFillCircle,
        height: 22,
        width: 22,
      ),
    );
  }

  _emptyCircleSvg() {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: SvgPicture.asset(
        kIconEmptyCircle,
        height: 22,
        width: 22,
      ),
    );
  }
}

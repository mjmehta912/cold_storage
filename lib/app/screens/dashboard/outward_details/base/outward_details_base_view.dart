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
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OutwardDetailsBaseView extends GetView<OutwardDetailsBaseController> {
  const OutwardDetailsBaseView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      bgColor: mColorAppbar,
      appBar: appBarWidget(
        context: context,
        titleText: kOutwardDetails,
        onTap: () {
          Get.back();
        },
        actions: PopupMenuButton(
          position: PopupMenuPosition.under,
          onSelected: (value) {},
          color: mColorCard6Primary,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: mColorCard6Secondary,
            ),
          ),
          itemBuilder: (BuildContext bc) {
            return [
              PopupMenuItem(
                value: '/$kAll',
                onTap: () {
                  controller.selectedFilterIndex.value = 0;
                  controller.updateListWithFilterData(kAll);
                },
                child: Obx(
                  () {
                    return Row(
                      children: [
                        controller.selectedFilterIndex.value == 0
                            ? _fillCircleSvg()
                            : _emptyCircleSvg(),
                        AppText(
                          text: kAll,
                          style: TextStyles.kPrimaryBoldPublicSans(
                            fontSize: TextStyles.k22FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
                value: '/$kPending',
                onTap: () {
                  controller.selectedFilterIndex.value = 1;
                  controller.updateListWithFilterData(kPending);
                },
                child: Obx(
                  () {
                    return Row(
                      children: [
                        controller.selectedFilterIndex.value == 1
                            ? _fillCircleSvg()
                            : _emptyCircleSvg(),
                        AppText(
                          text: kPending,
                          style: TextStyles.kPrimaryBoldPublicSans(
                            fontSize: TextStyles.k22FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
                value: '/$kAccepted',
                onTap: () {
                  controller.selectedFilterIndex.value = 2;
                  controller.updateListWithFilterData(kAccepted);
                },
                child: Obx(
                  () {
                    return Row(
                      children: [
                        controller.selectedFilterIndex.value == 2
                            ? _fillCircleSvg()
                            : _emptyCircleSvg(),
                        AppText(
                          text: kAccepted,
                          style: TextStyles.kPrimaryBoldPublicSans(
                            fontSize: TextStyles.k22FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              PopupMenuItem(
                value: '/$kRejected',
                onTap: () {
                  controller.selectedFilterIndex.value = 3;
                  controller.updateListWithFilterData(kRejected);
                },
                child: Obx(
                  () {
                    return Row(
                      children: [
                        controller.selectedFilterIndex.value == 3
                            ? _fillCircleSvg()
                            : _emptyCircleSvg(),
                        AppText(
                          text: kRejected,
                          style: TextStyles.kPrimaryBoldPublicSans(
                            fontSize: TextStyles.k22FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ];
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Icon(
              Icons.filter_alt_rounded,
              size: 25,
              color: mColorPrimaryText,
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          return controller.isDataLoading.value
              ? showLoaderText()
              : controller.filterOutwardDetailsList.isEmpty
                  ? noDataFound(
                      text: kNoDataFound,
                    )
                  : ListView.builder(
                      itemCount: controller.filterOutwardDetailsList.length,
                      itemBuilder: (context, index) {
                        var data = controller.filterOutwardDetailsList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: mColorCard6Secondary,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.55,
                                        child: AppText(
                                          text: data.pname ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              TextStyles.kPrimaryBoldPublicSans(
                                            fontSize: TextStyles.k18FontSize,
                                            colors: mColorPrimaryText,
                                          ).copyWith(
                                            height: 1.25,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: AppText(
                                          text: controller.isViewRequest.value
                                              ? data.status!
                                              : data.status != 'Pending'
                                                  ? data.status!
                                                  : '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              TextStyles.kPrimaryBoldPublicSans(
                                            fontSize: TextStyles.k18FontSize,
                                            colors: controller
                                                .returnStatusColor(data),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  AppSpaces.v4,
                                  _rowWidget(
                                    title: '$kRequestNo.',
                                    value: data.invno ?? '0',
                                  ),
                                  AppSpaces.v2,
                                  _rowWidget(
                                    title: kItem,
                                    value: data.iname ?? '',
                                  ),
                                  AppSpaces.v2,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _rowWidget(
                                        title: kDeliveryDate,
                                        value: data.date ?? '',
                                      ),
                                      _rowWidget(
                                        title: kTime,
                                        value: data.outwardTime ?? '',
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppSpaces.v2,
                                      _rowWidget(
                                        title: '$kInwardNo.',
                                        value: data.inwno ?? '0',
                                      ),
                                      _rowWidget(
                                        title: '$kLotNo.',
                                        value: data.lotno ?? '0',
                                      ),
                                      AppSpaces.v2,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _rowWidget(
                                            title: kQty,
                                            value: data.qty ?? '0',
                                          ),
                                          _rowWidget(
                                            title: kBalance,
                                            value: data.balqty ?? '0',
                                          ),
                                        ],
                                      ),
                                      AppSpaces.v2,
                                      _rowWidget(
                                        title: kVehicleType,
                                        value: data.vehicleType ?? '',
                                      ),
                                      AppSpaces.v2,
                                      _rowWidget(
                                        title: kEntryDate,
                                        value: data.entryDate ?? '',
                                      ),
                                    ],
                                  ),
                                  if (AppConst.companyData.value.userType ==
                                          '0' &&
                                      data.status == 'Pending')
                                    AppSpaces.v10,
                                  Obx(
                                    () {
                                      return Visibility(
                                        visible: AppConst.companyData.value
                                                    .userType ==
                                                '0' &&
                                            data.status == 'Pending',
                                        child:
                                            _rejectAndAcceptRow(context, data),
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
        },
      ),
    );
  }

  _rowWidget({
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          text: title,
          style: TextStyles.kPrimaryRegularPublicSans(
            fontWeight: FontWeight.w400,
            colors: mColorPrimaryText,
            fontSize: TextStyles.k14FontSize,
          ).copyWith(
            height: 1.25,
          ),
        ),
        AppSpaces.h10,
        Flexible(
          child: AppText(
            text: value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.kPrimaryBoldPublicSans(
              fontSize: TextStyles.k14FontSize,
              colors: mColorPrimaryText,
            ).copyWith(
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }

  _rejectAndAcceptRow(
    BuildContext context,
    OutwardDetailsData data,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            appButton(
              buttonWidth: 0.25.screenWidth,
              buttonHeight: 0.035.screenHeight,
              buttonColor: kColorRejectButton,
              buttonBorderColor: kColorRejectButton,
              buttonText: kReject,
              textStyle: TextStyles.kPrimaryBoldPublicSans(
                fontSize: TextStyles.k16FontSize,
                colors: mColorBackground,
              ),
              borderRadius: 10,
              onPressed: () {
                _showRejectDialog(context, data);
              },
            ),
            AppSpaces.h10,
            appButton(
              buttonWidth: 0.25.screenWidth,
              buttonHeight: 0.035.screenHeight,
              buttonColor: kColorGreen,
              buttonBorderColor: kColorGreen,
              buttonText: kAccept,
              textStyle: TextStyles.kPrimaryBoldPublicSans(
                fontSize: TextStyles.k16FontSize,
                colors: mColorBackground,
              ),
              borderRadius: 10,
              onPressed: () {
                controller.rejectReqApiCall(data, 1);
              },
            ),
          ],
        ),
      ],
    );
  }

  void _showRejectDialog(
    BuildContext context,
    OutwardDetailsData data,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: mColorCard6Primary,
          surfaceTintColor: mColorCard6Primary,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 14,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: mColorCard6Secondary,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: kRejectedReqText,
                        style: TextStyles.kPrimaryMediumPublicSans(
                          fontSize: TextStyles.k16FontSize,
                          colors: mColorPrimaryText,
                        ),
                      ),
                      TextSpan(
                        text: '${data.pname} ',
                        style: TextStyles.kPrimaryBoldPublicSans(
                          fontSize: TextStyles.k16FontSize,
                          colors: mColorPrimaryText,
                        ),
                      ),
                      TextSpan(
                        text: kRejectedReqText2,
                        style: TextStyles.kPrimaryMediumPublicSans(
                          fontSize: TextStyles.k16FontSize,
                          colors: mColorPrimaryText,
                        ),
                      ),
                      TextSpan(
                        text: ' ${data.lotno} ',
                        style: TextStyles.kPrimaryBoldPublicSans(
                          fontSize: TextStyles.k16FontSize,
                          colors: mColorPrimaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpaces.v16,
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        text: 'Remarks',
                        style: TextStyles.kPrimaryBoldPublicSans(
                          colors: mColorPrimaryText,
                          fontSize: TextStyles.k18FontSize,
                        ).copyWith(
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                AppTextField(
                  controller: controller.remarkController,
                  maxLines: 5,
                  minLines: 2,
                ),
                AppSpaces.v16,
                appButton(
                  buttonWidth: 0.25.screenWidth,
                  buttonHeight: 0.035.screenHeight,
                  buttonColor: kColorRejectButton,
                  buttonBorderColor: kColorRejectButton,
                  buttonText: kReject,
                  textStyle: TextStyles.kPrimaryBoldPublicSans(
                    fontSize: TextStyles.k16FontSize,
                    colors: mColorBackground,
                  ),
                  borderRadius: 10,
                  onPressed: () {
                    Get.back();
                    controller.rejectReqApiCall(data, 2);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _fillCircleSvg() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
      ),
      child: SvgPicture.asset(
        kIconFillCircle,
        height: 20,
        width: 20,
        colorFilter: const ColorFilter.mode(
          mColorCard6Secondary,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  _emptyCircleSvg() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
      ),
      child: SvgPicture.asset(
        kIconEmptyCircle,
        height: 20,
        width: 20,
        colorFilter: const ColorFilter.mode(
          mColorCard6Secondary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

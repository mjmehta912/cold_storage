import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/screens/dashboard/notification/controller/notification_controller.dart';
import 'package:cold_storage/app/screens/dashboard/notification/model/res/notification_res.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/app_widgets/no_data_found.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.navigateToBack();
        return false;
      },
      child: AppScaffold(
        appBar: appBarWidget(
          context: context,
          elevation: 0,
          titleText: kNotifications,
          onTap: () {
            controller.navigateToBack();
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
        body: Obx(
          () {
            return Visibility(
              visible: !controller.isDataLoading.value,
              child: notificationListView(),
            );
          },
        ),
      ),
    );
  }

  notificationListView() {
    return controller.filterNotificationDataList.isEmpty
        ? noDataFound(text: kNoDataFound)
        : ListView.builder(
            itemCount: controller.filterNotificationDataList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var data = controller.filterNotificationDataList[index];
              // ListTile(
              //   title: Text(
              //       'UserName, MobileNo, Reason, Status, Name of the accepted/rejecter. Time'),
              // ),
              return Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 0.7.screenWidth,
                              child: Text(
                                '${data.userName ?? ''} $kHasChangedDevice',
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k16FontSize,
                                ),
                              ),
                            ),
                            Text(
                              controller.returnStatusText(data.status ?? 0),
                              style:
                                  TextStyles.kPrimarySemiBoldInter().copyWith(
                                color: controller.returnStatusColor(data),
                                fontSize: TextStyles.k14FontSize,
                              ),
                            )
                          ],
                        ),
                        AppSpaces.v4,
                        Row(
                          children: [
                            SizedBox(
                              width: controller.titleWidth.screenWidth,
                              child: Text(
                                '$kReason ',
                                maxLines: 3,
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k14FontSize,
                                  fontFamily: Font.InterRegular,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: controller.titleValueWidth.screenWidth,
                              child: Text(
                                controller.returnText(data.reason),
                                maxLines: 3,
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k14FontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSpaces.v4,
                        Row(
                          children: [
                            SizedBox(
                              width: controller.titleWidth.screenWidth,
                              child: Text(
                                '$kTimestamp ',
                                maxLines: 3,
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k14FontSize,
                                  fontFamily: Font.InterRegular,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: controller.titleValueWidth.screenWidth,
                              child: Text(
                                data.timeStamp ?? '',
                                maxLines: 3,
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k14FontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSpaces.v4,
                        Row(
                          children: [
                            SizedBox(
                              width: controller.titleWidth.screenWidth,
                              child: Text(
                                '$kMobileNo ',
                                maxLines: 3,
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k14FontSize,
                                  fontFamily: Font.InterRegular,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: controller.titleValueWidth.screenWidth,
                              child: Text(
                                data.mobileNo ?? '',
                                maxLines: 3,
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k14FontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSpaces.v4,
                        Row(
                          children: [
                            SizedBox(
                              width: controller.titleWidth.screenWidth,
                              child: Text(
                                '$kDevice ',
                                maxLines: 3,
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k14FontSize,
                                  fontFamily: Font.InterRegular,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: controller.titleValueWidth.screenWidth,
                              child: Text(
                                controller.returnText(data.mobileModel),
                                maxLines: 3,
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k14FontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSpaces.v4,
                        Row(
                          children: [
                            SizedBox(
                              width: controller.titleWidth.screenWidth,
                              child: Text(
                                '$kActionBy ',
                                maxLines: 3,
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k14FontSize,
                                  fontFamily: Font.InterRegular,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: controller.titleValueWidth.screenWidth,
                              child: Text(
                                controller.returnText(data.updateBy),
                                maxLines: 3,
                                style:
                                    TextStyles.kPrimarySemiBoldInter().copyWith(
                                  color: kColorSecondPrimary,
                                  fontSize: TextStyles.k14FontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                        AppSpaces.v4,
                      ],
                    ),
                    Visibility(
                      visible: AppConst.companyData.value.userType == '0' &&
                          data.status == 0,
                      child: _rejectAndAcceptRow(context, data),
                    ),
                  ],
                ),
              );
            },
          );
  }

  _rejectAndAcceptRow(BuildContext context, NotificationData data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        appButton(
          buttonWidth: 0.20.screenWidth,
          buttonHeight: 26,
          buttonColor: kColorRejectButton,
          buttonBorderColor: kColorRejectButton,
          buttonText: kReject,
          textStyle: TextStyles.kPrimaryBoldInter(
            fontSize: TextStyles.k12FontSize,
            colors: kColorWhite,
          ),
          borderRadius: 8,
          onPressed: () {
            controller.rejectReqApiCall(data, 2);
          },
        ),
        AppSpaces.h6,
        appButton(
          buttonWidth: 0.20.screenWidth,
          buttonHeight: 26,
          buttonColor: kColorGreen,
          buttonBorderColor: kColorGreen,
          buttonText: kAccept,
          textStyle: TextStyles.kPrimaryBoldInter(
            fontSize: TextStyles.k12FontSize,
            colors: kColorWhite,
          ),
          borderRadius: 8,
          onPressed: () {
            controller.rejectReqApiCall(data, 1);
          },
        ),
      ],
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

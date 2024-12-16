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
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.navigateToBack();
        return false;
      },
      child: AppScaffold(
        bgColor: mColorBackground,
        appBar: appBarWidget(
          context: context,
          elevation: 0,
          titleText: kNotifications,
          onTap: () {
            controller.navigateToBack();
          },
          actions: PopupMenuButton(
            onSelected: (value) {},
            color: mColorAppbar,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: mColorBlack,
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
                  child: Obx(() {
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
                          style: TextStyles.kPrimaryBoldPublicSans(
                            fontSize: TextStyles.k22FontSize,
                            colors: mColorPrimaryText,
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
                horizontal: 15,
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
        ? noDataFound(
            text: kNoDataFound,
          )
        : ListView.builder(
            itemCount: controller.filterNotificationDataList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              var data = controller.filterNotificationDataList[index];

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Card(
                  elevation: 5,
                  color: mColorBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: mColorPrimaryText,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 0.55.screenWidth,
                              child: Text(
                                '${data.userName ?? ''} $kHasChangedDevice',
                                style: TextStyles.kPrimarySemiBoldPublicSans()
                                    .copyWith(
                                  color: mColorPrimaryText,
                                  fontSize: TextStyles.k18FontSize,
                                  height: 1.25,
                                ),
                              ),
                            ),
                            Text(
                              controller.returnStatusText(
                                data.status ?? 0,
                              ),
                              style: TextStyles.kPrimarySemiBoldPublicSans()
                                  .copyWith(
                                color: controller.returnStatusColor(data),
                                fontSize: TextStyles.k18FontSize,
                              ),
                            )
                          ],
                        ),
                        AppSpaces.v4,
                        CustomNotificationRow(
                          title: '$kReason ',
                          value: controller.returnText(data.reason),
                        ),
                        AppSpaces.v2,
                        CustomNotificationRow(
                          title: '$kTimestamp ',
                          value: data.timeStamp ?? '',
                        ),
                        AppSpaces.v2,
                        CustomNotificationRow(
                          title: '$kMobileNo ',
                          value: data.mobileNo ?? '',
                        ),
                        AppSpaces.v2,
                        CustomNotificationRow(
                          title: '$kDevice ',
                          value: controller.returnText(data.mobileModel),
                        ),
                        AppSpaces.v2,
                        CustomNotificationRow(
                          title: '$kActionBy ',
                          value: controller.returnText(data.updateBy),
                        ),
                        Visibility(
                          visible: AppConst.companyData.value.userType == '0' &&
                              data.status == 0,
                          child: _rejectAndAcceptRow(context, data),
                        ),
                      ],
                    ),
                  ),
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
          buttonWidth: 0.25.screenWidth,
          buttonHeight: 30,
          buttonColor: kColorRejectButton,
          buttonBorderColor: kColorRejectButton,
          buttonText: kReject,
          textStyle: TextStyles.kPrimaryBoldPublicSans(
            fontSize: TextStyles.k16FontSize,
            colors: kColorWhite,
          ),
          borderRadius: 8,
          onPressed: () {
            controller.rejectReqApiCall(data, 2);
          },
        ),
        AppSpaces.h6,
        appButton(
          buttonWidth: 0.25.screenWidth,
          buttonHeight: 30,
          buttonColor: kColorGreen,
          buttonBorderColor: kColorGreen,
          buttonText: kAccept,
          textStyle: TextStyles.kPrimaryBoldPublicSans(
            fontSize: TextStyles.k16FontSize,
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
      padding: const EdgeInsets.only(
        right: 10,
      ),
      child: SvgPicture.asset(
        kIconFillCircle,
        height: 20,
        width: 20,
        colorFilter: const ColorFilter.mode(
          mColorPrimaryText,
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
          mColorPrimaryText,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class CustomNotificationRow extends StatelessWidget {
  const CustomNotificationRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          maxLines: 3,
          style: TextStyles.kPrimarySemiBoldPublicSans().copyWith(
            color: mColorPrimaryText,
            fontSize: TextStyles.k14FontSize,
            height: 1.25,
          ),
        ),
        AppSpaces.h10,
        Flexible(
          child: Text(
            value,
            maxLines: 3,
            style: TextStyles.kPrimarySemiBoldPublicSans().copyWith(
              color: mColorPrimaryText,
              fontSize: TextStyles.k16FontSize,
              height: 1.25,
            ),
          ),
        ),
      ],
    );
  }
}

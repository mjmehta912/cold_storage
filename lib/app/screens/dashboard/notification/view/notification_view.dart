import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
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
import 'package:get/get.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
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
            position: PopupMenuPosition.under,
            onSelected: (value) {},
            color: mColorBackground,
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
                  child: AppText(
                    text: kAll,
                    style: TextStyles.kPrimaryMediumPublicSans(
                      fontSize: TextStyles.k18FontSize,
                      colors: mColorPrimaryText,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: '/$kPending',
                  onTap: () {
                    controller.selectedFilterIndex.value = 1;
                    controller.updateListWithFilterData(kPending);
                  },
                  child: AppText(
                    text: kPending,
                    style: TextStyles.kPrimaryMediumPublicSans(
                      fontSize: TextStyles.k18FontSize,
                      colors: mColorPrimaryText,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: '/$kAccepted',
                  onTap: () {
                    controller.selectedFilterIndex.value = 2;
                    controller.updateListWithFilterData(kAccepted);
                  },
                  child: AppText(
                    text: kAccepted,
                    style: TextStyles.kPrimaryMediumPublicSans(
                      fontSize: TextStyles.k18FontSize,
                      colors: mColorPrimaryText,
                    ),
                  ),
                ),
                PopupMenuItem(
                  value: '/$kRejected',
                  onTap: () {
                    controller.selectedFilterIndex.value = 3;
                    controller.updateListWithFilterData(kRejected);
                  },
                  child: AppText(
                    text: kRejected,
                    style: TextStyles.kPrimaryMediumPublicSans(
                      fontSize: TextStyles.k18FontSize,
                      colors: mColorPrimaryText,
                    ),
                  ),
                ),
              ];
            },
            child: Obx(
              () {
                /// ✅ Inline logic to get selected filter value
                String selectedFilter =
                    controller.selectedFilterIndex.value == 1
                        ? kPending
                        : controller.selectedFilterIndex.value == 2
                            ? kAccepted
                            : controller.selectedFilterIndex.value == 3
                                ? kRejected
                                : kAll;

                return Card(
                  elevation: 0,
                  color: mColorAppbar,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: kColorBlack,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Row(
                      children: [
                        Text(
                          selectedFilter,
                          style: TextStyles.kPrimaryRegularPublicSans(
                            fontSize: TextStyles.k16FontSize,
                            colors: mColorPrimaryText,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 25,
                          color: mColorPrimaryText,
                        ),
                      ],
                    ),
                  ),
                );
              },
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.userName ?? ''} $kHasChangedDevice',
                          style:
                              TextStyles.kPrimarySemiBoldPublicSans().copyWith(
                            color: mColorPrimaryText,
                            fontSize: TextStyles.k18FontSize,
                            height: 1.25,
                          ),
                        ),
                        Text(
                          controller.returnStatusText(
                            data.status ?? 0,
                          ),
                          style:
                              TextStyles.kPrimarySemiBoldPublicSans().copyWith(
                            color: controller.returnStatusColor(data),
                            fontSize: TextStyles.k18FontSize,
                          ),
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

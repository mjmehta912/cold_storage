import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/route_constants.dart';
import 'package:cold_storage/app/screens/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:cold_storage/app/screens/dashboard/home/base/home_base_view.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/app_widgets/drawer_widget.dart';
import 'package:cold_storage/app/utils/local_storage/local_storage.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavView extends GetView<BottomNavController> {
  BottomNavView({
    super.key,
  }) {
    controller.setCompanyData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BottomNavController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            surfaceTintColor: mColorAppbar,
            backgroundColor: mColorAppbar,
            shadowColor: kColorBlack,
            leadingWidth: 50,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.navigateToNotificationScreen(),
                      child: const Icon(
                        Icons.notifications_outlined,
                        size: 25,
                        color: mColorPrimaryText,
                      ),
                    ),
                  ],
                ),
              )
            ],
            title: Obx(
              () {
                return AppText(
                  text: controller.selectedCompanyData.value.companyName ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.kPrimarySemiBoldPublicSans(
                    fontSize: TextStyles.k18FontSize,
                    colors: mColorPrimaryText,
                  ),
                );
              },
            ),
          ),
          drawer: DrawerWidget(
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: mColorAppbar,
                    surfaceTintColor: mColorAppbar,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppUIUtils.primaryBorderRadius,
                    ),
                    title: AppText(
                      text: '$kAreYouSure $kYouWantToLogOut?',
                      style: TextStyles.kPrimaryMediumPublicSans(
                        colors: mColorPrimaryText,
                        fontSize: TextStyles.k18FontSize,
                      ),
                    ),
                    actions: [
                      appButton(
                        onPressed: () {
                          Get.back();
                        },
                        buttonText: kNo,
                        buttonWidth: 0.24.screenWidth,
                        buttonHeight: 32,
                        textStyle: TextStyles.kPrimaryBoldPublicSans(
                          colors: mColorPrimaryText,
                          fontSize: TextStyles.k16FontSize,
                        ),
                      ),
                      appButton(
                        onPressed: () {
                          Get.find<LocalStorage>().clearAllData();
                          Get.offAllNamed(kRouteLoginView);
                        },
                        buttonText: kLogout,
                        buttonWidth: 0.24.screenWidth,
                        buttonHeight: 32,
                        buttonColor: mColorPrimaryText,
                        buttonBorderColor: mColorPrimaryText,
                        textStyle: TextStyles.kPrimaryBoldPublicSans(
                          colors: mColorAppbar,
                          fontSize: TextStyles.k16FontSize,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          body: const HomeBaseView(),
        );
      },
    );
  }
}

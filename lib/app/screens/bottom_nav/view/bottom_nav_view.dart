import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
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
                  vertical: 4,
                  horizontal: 18,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.navigateToNotificationScreen(),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Icon(
                          Icons.notifications_outlined,
                          size: 26,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: kColorBackground,
                              surfaceTintColor: kColorBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: AppUIUtils.primaryBorderRadius,
                              ),
                              title: AppText(
                                text: '$kAreYouSure $kYouWantToLogOut?',
                                style: TextStyles.kPrimaryMediumInter(
                                    colors: kColorSecondPrimary,
                                    fontSize: TextStyles.k16FontSize),
                              ),
                              actions: [
                                appButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  buttonText: kNo,
                                  buttonWidth: 0.24.screenWidth,
                                  buttonHeight: 32,
                                  textStyle: TextStyles.kPrimaryBoldInter(
                                      colors: kColorWhite,
                                      fontSize: TextStyles.k14FontSize),
                                ),
                                appButton(
                                  onPressed: () {
                                    Get.find<LocalStorage>().clearAllData();
                                    Get.offAllNamed(kRouteLoginView);
                                  },
                                  buttonText: kLogout,
                                  buttonWidth: 0.24.screenWidth,
                                  buttonHeight: 32,
                                  buttonColor: kColorWhite,
                                  buttonBorderColor: kColorWhite,
                                  textStyle: TextStyles.kPrimaryBoldInter(
                                    colors: kColorRedFF0000,
                                    fontSize: TextStyles.k14FontSize,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        kIconUserProfile,
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
          drawer: const DrawerWidget(),
          body: const HomeBaseView(),
        );
      },
    );
  }
}

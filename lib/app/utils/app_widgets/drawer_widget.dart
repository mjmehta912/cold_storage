import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/general_model/drawer_model.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 0.6.screenWidth,
      backgroundColor: kColorSecondPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: SafeArea(
        child: Column(
          // Important: Remove any padding from the ListView.
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 0.4.screenWidth,
                    child: AppText(
                      text: AppConst.userName,
                      style: TextStyles.kPrimaryBoldInter(
                        fontSize: TextStyles.k24FontSize,
                        colors: kColorBackground,
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(kIconDrawerClose)),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: AppConst.companyData.value.userType == '0'
                    ? DrawerData.drawerList2.length
                    : DrawerData.drawerList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  var data = AppConst.companyData.value.userType == '0'
                      ? DrawerData.drawerList2[index]
                      : DrawerData.drawerList[index];
                  if (data.isHeader == false || data.isHeader == null) {
                    return GestureDetector(
                      onTap: () {
                        if ((data.navigateTo ?? '').isNotEmpty) {
                          Get.back();
                          Get.toNamed(data.navigateTo ?? '',
                              arguments: index == 0 ? false : null);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 18),
                        decoration: const BoxDecoration(
                          color: kColorBackground,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(data.iconName ?? ''),
                            AppSpaces.h8,
                            AppText(
                              text: data.name ?? '',
                              style: TextStyles.kPrimaryBoldInter(
                                fontSize: TextStyles.k14FontSize,
                                colors: kColorSecondPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return AppText(
                      text: data.name ?? '',
                      align: TextAlign.center,
                      style: TextStyles.kPrimaryRegularInter(
                        fontSize: TextStyles.k14FontSize,
                        colors: kColorBackground,
                      ),
                    );
                  }
                },
              ),
            ),
            Column(
              children: [
                AppText(
                  text:
                      'v${AppConst.packageInfo?.version ?? ''} | $kMadeInIndia',
                  style: TextStyles.kPrimaryRegularInter(
                      colors: kColorWhite, fontSize: TextStyles.k12FontSize),
                ),
                SizedBox(
                  width: 0.5.screenWidth,
                  child: AppText(
                    text: kCopyRightText,
                    align: TextAlign.center,
                    style: TextStyles.kPrimaryRegularInter(
                        colors: kColorWhite, fontSize: TextStyles.k12FontSize),
                  ),
                ),
                AppSpaces.v12,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

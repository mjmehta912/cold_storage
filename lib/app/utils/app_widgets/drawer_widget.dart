import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/general_model/drawer_model.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 0.7.screenWidth,
      backgroundColor: mColorAppbar,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.4.screenWidth,
                    child: AppText(
                      text: 'Hi,',
                      style: TextStyles.kPrimarySemiBoldPublicSans(
                        fontSize: TextStyles.k24FontSize,
                        colors: mColorPrimaryText,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.4.screenWidth,
                    child: AppText(
                      text: AppConst.userName,
                      style: TextStyles.kPrimarySemiBoldPublicSans(
                        fontSize: TextStyles.k24FontSize,
                        colors: mColorPrimaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSpaces.v12,
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
                          Get.toNamed(
                            data.navigateTo ?? '',
                            arguments: index == 0 ? false : null,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  data.icon,
                                  color: mColorPrimaryText,
                                  size: 35,
                                ),
                                AppSpaces.h12,
                                AppText(
                                  text: data.name ?? '',
                                  style: TextStyles.kPrimarySemiBoldPublicSans(
                                    fontSize: TextStyles.k18FontSize,
                                    colors: kColorSecondPrimary,
                                  ),
                                ),
                              ],
                            ),
                            AppSpaces.v10,
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
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onTap,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.logout,
                          size: 35,
                          color: mColorPrimaryText,
                        ),
                        AppSpaces.h20,
                        AppText(
                          text: 'Log Out',
                          style: TextStyles.kPrimarySemiBoldPublicSans(
                            fontSize: TextStyles.k22FontSize,
                            colors: kColorSecondPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpaces.v16,
                  AppText(
                    text:
                        'v${AppConst.packageInfo?.version ?? ''} | $kMadeInIndia',
                    style: TextStyles.kPrimarySemiBoldPublicSans(
                      colors: mColorPrimaryText,
                      fontSize: TextStyles.k14FontSize,
                    ),
                  ),
                  SizedBox(
                    width: 0.5.screenWidth,
                    child: AppText(
                      text: kCopyRightText,
                      style: TextStyles.kPrimarySemiBoldPublicSans(
                        colors: mColorPrimaryText,
                        fontSize: TextStyles.k14FontSize,
                      ),
                    ),
                  ),
                  AppSpaces.v12,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

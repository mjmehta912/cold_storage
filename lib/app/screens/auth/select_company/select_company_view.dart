import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/screens/auth/select_company/select_company_controller.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/app_widgets/app_drop_down.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SelectCompanyView extends GetView<SelectCompanyController> {
  const SelectCompanyView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: kSelectYourCompany,
              style: TextStyles.kPrimaryBoldInter(
                fontSize: TextStyles.k30FontSize,
                colors: kColorSecondPrimary,
              ),
            ),
            AppSpaces.v10,
            _companyDropDown(context),
            AppSpaces.v10,
            GestureDetector(
              onTap: () {
                if ((controller.selectedCompany.value.companyName??'').isNotEmpty) {
                  controller.navigateToBottomNavScreen();
                }
                else{
                  Get.find<AlertMessageUtils>().showErrorSnackBar1(kPleaseSelectCompany);
                }
              },
              child: Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(kIconForwardWithBgArrow),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _companyDropDown(BuildContext context) {
    return Obx(
          () {
        return AppDropDown(
          items: controller.companiesList
              .map((element) => element.companyName ?? '')
              .toList(),
          onChanged: (String? value) {
            controller.selectedCompany.value = controller.companiesList
                .where((e) => (e.companyName ?? '') == (value ?? ''))
                .first;
          },
          string: (item) =>
          controller.companiesList
              .where((company) => company.companyName.toString() == item)
              .firstOrNull
              ?.companyName ??
              '',
        );
      },
    );
  }
}

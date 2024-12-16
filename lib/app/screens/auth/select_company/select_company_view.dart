import 'package:carousel_slider/carousel_slider.dart';
import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/screens/auth/login/login_view.dart';
import 'package:cold_storage/app/screens/auth/select_company/select_company_controller.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_drop_down.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCompanyView extends GetView<SelectCompanyController> {
  const SelectCompanyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CarouselSliderController carouselController =
        CarouselSliderController();
    final RxInt activeIndex = 0.obs; // Observable to track active slide index
    final List<Color> buttonColors = [
      mColorCard1Primary,
      mColorCard2Primary,
      mColorCard3Primary,
      mColorCard4Primary,
      mColorCard5Primary,
      mColorCard6Primary,
    ];

    final List<Color> buttonTextColors = [
      mColorCard1Secondary,
      mColorCard2Secondary,
      mColorCard3Secondary,
      mColorCard4Secondary,
      mColorCard5Secondary,
      mColorCard6Secondary,
    ];

    return AppScaffold(
      bgColor: mColorAppbar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.335,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 36,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Cold Storage',
                  style: TextStyles.kPrimarySemiBoldPublicSans(
                    colors: mColorPrimaryText,
                    fontSize: TextStyles.k30FontSize,
                  ),
                ),
                AppSpaces.v24,
                CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: 120,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(
                      seconds: 2,
                    ),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      activeIndex.value = index;
                    },
                  ),
                  items: const [
                    CustomCarouselCard(
                      bgColor: mColorCard1Primary,
                      title: kInwardStockLedger,
                      titleColor: mColorCard1Secondary,
                      image: mIconInwardStock,
                    ),
                    CustomCarouselCard(
                      bgColor: mColorCard2Primary,
                      title: kStockSummary,
                      titleColor: mColorCard2Secondary,
                      image: mIconStockSummary,
                    ),
                    CustomCarouselCard(
                      bgColor: mColorCard3Primary,
                      title: kStockLedger,
                      titleColor: mColorCard3Secondary,
                      image: mIconStockLedger,
                    ),
                    CustomCarouselCard(
                      bgColor: mColorCard4Primary,
                      title: kAccountLedger,
                      titleColor: mColorCard4Secondary,
                      image: mIconAccountLedger,
                    ),
                    CustomCarouselCard(
                      bgColor: mColorCard5Primary,
                      title: kOutwardRequest,
                      titleColor: mColorCard5Secondary,
                      image: mIconOutwardRequests,
                    ),
                    CustomCarouselCard(
                      bgColor: mColorCard6Primary,
                      title: kViewOutwardRequest,
                      titleColor: mColorCard6Secondary,
                      image: mIconViewRequests,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              decoration: const BoxDecoration(
                color: mColorBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpaces.v24,
                  AppText(
                    text: kSelectYourCompany,
                    style: TextStyles.kPrimarySemiBoldPublicSans(
                      colors: mColorPrimaryText,
                      fontSize: TextStyles.k30FontSize,
                    ),
                  ),
                  AppSpaces.v24,
                  Obx(
                    () {
                      return AppDropDown(
                        items: controller.companiesList
                            .map(
                              (element) => element.companyName ?? '',
                            )
                            .toList(),
                        onChanged: (String? value) {
                          controller.selectedCompany.value =
                              controller.companiesList
                                  .where(
                                    (e) =>
                                        (e.companyName ?? '') == (value ?? ''),
                                  )
                                  .first;
                        },
                        string: (item) =>
                            controller.companiesList
                                .where(
                                  (company) =>
                                      company.companyName.toString() == item,
                                )
                                .firstOrNull
                                ?.companyName ??
                            '',
                      );
                    },
                  ),
                  AppSpaces.v24,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Obx(
                      () => appButton(
                        onPressed: () {
                          if ((controller.selectedCompany.value.companyName ??
                                  '')
                              .isNotEmpty) {
                            controller.navigateToBottomNavScreen();
                          } else {
                            Get.find<AlertMessageUtils>()
                                .showErrorSnackBar1(kPleaseSelectCompany);
                          }
                        },
                        buttonText: 'Let\'s Start',
                        buttonColor: buttonColors[activeIndex.value],
                        textColor: buttonTextColors[activeIndex.value],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

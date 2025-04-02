import 'package:carousel_slider/carousel_slider.dart';
import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/screens/auth/login/login_controller.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text_field.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/validations/text_field_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({
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

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: AppScaffold(
        resizeToAvoidBottomInset: true,
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
                  vertical: 36,
                ),
                decoration: const BoxDecoration(
                  color: mColorBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'Welcome Back!',
                          style: TextStyles.kPrimarySemiBoldPublicSans(
                            colors: mColorPrimaryText,
                            fontSize: TextStyles.k30FontSize,
                          ),
                        ),
                        AppSpaces.v20,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                ),
                                child: AppText(
                                  text: '$kMobileNo.',
                                  style: TextStyles.kPrimarySemiBoldPublicSans(
                                    fontSize: TextStyles.k18FontSize,
                                    colors: mColorPrimaryText,
                                  ),
                                ),
                              ),
                              AppSpaces.v4,
                              AppTextField(
                                controller: controller.mobileController,
                                textInputType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                maxLength: 10,
                                validator: (v) {
                                  return Validate.phoneValidation(
                                      context, v ?? '');
                                },
                              ),
                              AppSpaces.v8,
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: AppText(
                                  text: kPassword,
                                  style: TextStyles.kPrimarySemiBoldPublicSans(
                                    fontSize: TextStyles.k18FontSize,
                                    colors: mColorPrimaryText,
                                  ),
                                ),
                              ),
                              AppSpaces.v4,
                              Obx(
                                () {
                                  return AppTextField(
                                    controller: controller.passwordController,
                                    obscureText:
                                        !controller.visiblePassword.value,
                                    validator: (v) {
                                      return Validate.passwordValidation(
                                          context, v ?? '');
                                    },
                                    suffix: GestureDetector(
                                      onTap: () {
                                        controller.visiblePassword.value =
                                            !controller.visiblePassword.value;
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        child: Icon(
                                          controller.visiblePassword.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        AppSpaces.v36,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Obx(
                            () => appButton(
                              buttonColor: buttonColors[activeIndex.value],
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.loginApiCall();
                                }
                              },
                              buttonText: kLogin,
                              textColor: buttonTextColors[activeIndex.value],
                            ),
                          ),
                        ),
                        AppSpaces.v8,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCarouselCard extends StatelessWidget {
  const CustomCarouselCard({
    super.key,
    required this.bgColor,
    required this.title,
    required this.titleColor,
    required this.image,
  });

  final Color bgColor;
  final String title;
  final Color titleColor;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.39,
              child: AppText(
                text: title,
                align: TextAlign.start,
                style: TextStyles.kPrimarySemiBoldPublicSans(
                  fontSize: TextStyles.k28FontSize,
                  colors: titleColor,
                ).copyWith(
                  height: 1,
                ),
              ),
            ),
            Image.asset(
              image,
            ),
          ],
        ),
      ),
    );
  }
}

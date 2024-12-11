import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/screens/auth/login/login_controller.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text_field.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:cold_storage/app/utils/validations/text_field_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: AppScaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: kLogin,
                  style:
                      TextStyles.kPrimaryBoldInter(colors: kColorSecondPrimary),
                ),
                AppSpaces.v10,
                _textFieldsContainer(context),
                AppSpaces.v36,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: appButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.loginApiCall();
                      }
                    },
                    buttonText: kLogin,
                  ),
                ),
                AppSpaces.v8,
                Center(
                  child: AppText(
                    text: kForgotPassword,
                    style: TextStyles.kPrimaryRegularInter(
                      fontSize: TextStyles.k12FontSize,
                      colors: kColorSecondPrimary,
                    ).copyWith(decoration: TextDecoration.underline),
                  ),
                ),
                AppSpaces.v36,
              ],
            ),
          ),
        ),
      ),
    );
  }

  _textFieldsContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
          color: kColorSecondPrimary,
          borderRadius: AppUIUtils.loginBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: AppText(
              text: '$kMobileNo.',
              style: TextStyles.kPrimarySemiBoldInter(colors: kColorPrimary),
            ),
          ),
          AppSpaces.v8,
          AppTextField(
            controller: controller.mobileController,
            labelText: '',
            hintText: '',
            fillColor: kColorBackground,
            textInputType: TextInputType.phone,
            textStyle: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k24FontSize,
              colors: kColorBlack,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            maxLength: 10,
            validator: (v) {
              return Validate.phoneValidation(context, v ?? '');
            },
          ),
          AppSpaces.v8,
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: AppText(
              text: kPassword,
              style: TextStyles.kPrimarySemiBoldInter(colors: kColorPrimary),
            ),
          ),
          AppSpaces.v8,
          Obx(() {
            return AppTextField(
              controller: controller.passwordController,
              obscureText: !controller.visiblePassword.value,
              textStyle: TextStyles.kPrimaryBoldInter(
                fontSize: TextStyles.k24FontSize,
                colors: kColorBlack,
              ),
              fillColor: kColorBackground,
              validator: (v) {
                return Validate.passwordValidation(context, v ?? '');
              },
              suffix: GestureDetector(
                onTap: () {
                  controller.visiblePassword.value =
                      !controller.visiblePassword.value;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(controller.visiblePassword.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/general_model/user_type_model.dart';
import 'package:cold_storage/app/screens/dashboard/user_register/user_register_controller.dart';
import 'package:cold_storage/app/utils/app_widgets/app_bar_widget.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_drop_down.dart';
import 'package:cold_storage/app/utils/app_widgets/app_scaffold.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text_field.dart';
import 'package:cold_storage/app/utils/app_widgets/custom_drop_down_widgets/cust_drop_down.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/validations/text_field_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRegisterView extends GetView<UserRegisterController> {
  const UserRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBarWidget(
        context: context,
        titleText: kRegisterNewUser,
        onTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                _mobileNo(context),
                AppSpaces.v16,
                _userName(context),
                AppSpaces.v16,
                _password(context),
                AppSpaces.v16,
                _userTypeDropdown(context),
                AppSpaces.v16,
                _partyCompanyDropdown(context),
                AppSpaces.v16,
                Obx(
                  () {
                    return appButton(
                      buttonWidth: 0.45.screenWidth,
                      onPressed: () {
                        if (controller.formKey.currentState!.validate() &&
                            controller.selectedUserType.value.type == kAdmin) {
                          controller.userRegApiCall();
                        } else if (controller.formKey.currentState!
                                .validate() &&
                            controller.selectedCustomers.isNotEmpty) {
                          controller.userRegApiCall();
                        }
                        // controller.navigateToDetailsScreen();
                      },
                      buttonText: kRegister,
                      buttonColor:
                          controller.selectedUserType.value.type == kAdmin
                              ? kColorBlack
                              : controller.selectedCustomers.isEmpty
                                  ? kColorCBD2DC
                                  : kColorBlack,
                      buttonBorderColor:
                          controller.selectedUserType.value.type == kAdmin
                              ? kColorBlack
                              : controller.selectedCustomers.isEmpty
                                  ? kColorCBD2DC
                                  : kColorBlack,
                      textStyle: TextStyles.kPrimaryBoldInter(
                              fontSize: TextStyles.k24FontSize)
                          .copyWith(
                        color: controller.selectedUserType.value.type == kAdmin
                            ? kColorPrimary
                            : controller.selectedCustomers.isEmpty
                                ? kColor8C8B8A
                                : kColorPrimary,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mobileNo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kMobileNo,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        AppTextField(
          labelText: '',
          controller: controller.mobileController,
          textInputType: TextInputType.phone,
          maxLength: 10,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (v) {
            return Validate.phoneValidation(context, v ?? '');
          },
        ),
      ],
    );
  }

  Widget _userName(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kUserName,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        AppTextField(
          labelText: '',
          controller: controller.userNameController,
          validator: (v) {
            return Validate.nameValidation(context, v ?? '');
          },
        ),
      ],
    );
  }

  Widget _password(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kPassword,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        Obx(() {
          return AppTextField(
            labelText: '',
            controller: controller.passwordController,
            obscureText: !controller.visiblePassword.value,
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
                child: Icon(
                    controller.visiblePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: kColorPrimary),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _userTypeDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kUsertype,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        AppDropDown(
          items: controller.userType,
          onChanged: (value) {
            controller.selectedUserType.value = controller.userType
                    .where((e) => e.type == (value?.type ?? ''))
                    .firstOrNull ??
                UserTypeModel('');
          },
          string: (item) {
            return controller.userType
                .where((e) => e.type == item.type)
                .first
                .type;
          },
        ),
      ],
    );
  }

  Widget _partyCompanyDropdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: controller.textFieldTitlePadding,
          child: AppText(
            text: kPartyCompanies,
            style: TextStyles.kPrimaryBoldInter(
              fontSize: TextStyles.k16FontSize,
              colors: kColorSecondPrimary,
            ),
          ),
        ),
        Obx(
          () {
            return IgnorePointer(
              ignoring: controller.selectedUserType.value.type == kAdmin
                  ? true
                  : false,
              child: CustDropdown(
                items: controller.customers.map((e) => e).toList(),
                dropdownBGColor:
                    controller.selectedUserType.value.type == kAdmin
                        ? kColorB9B5B2
                        : kColorSecondPrimary,
                hintText: '',
                callBack: (p0) {
                  controller.selectedCustomers.clear();
                  controller.selectedCustomers.addAll(p0);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

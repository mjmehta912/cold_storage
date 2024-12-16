import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/repositories/auth_repo.dart';
import 'package:cold_storage/app/screens/auth/login/model/login_req_model.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text_field.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextEditingController remarkController = TextEditingController();

void showChangeDeviceReqDialog(BuildContext context, LoginRequestModel data) {
  showDialog(
    context: context,
    builder: (context) {
      remarkController.clear();
      return Dialog(
        backgroundColor: mColorAppbar,
        surfaceTintColor: mColorAppbar,
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$kYourReqWillBeSendToAdmin.',
                      style: TextStyles.kPrimarySemiBoldPublicSans(
                        fontSize: TextStyles.k18FontSize,
                        colors: mColorPrimaryText,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpaces.v16,
              Padding(
                padding: const EdgeInsets.all(8),
                child: AppText(
                  text: 'Remarks',
                  style: TextStyles.kPrimaryBoldPublicSans(
                    colors: mColorPrimaryText,
                    fontSize: TextStyles.k18FontSize,
                  ).copyWith(
                    height: 1.25,
                  ),
                ),
              ),
              AppTextField(
                controller: remarkController,
                maxLines: 5,
                minLines: 2,
              ),
              AppSpaces.v16,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  appButton(
                    onPressed: () async {
                      if (remarkController.text.trim().isNotEmpty) {
                        Get.back();
                        data.reason = remarkController.text.trim();
                        await AuthRepo()
                            .changeDeviceRequestApiCall(requestModel: data);
                      } else {
                        Get.find<AlertMessageUtils>()
                            .showErrorSnackBar1(kErrorEnterReason);
                      }
                    },
                    buttonWidth: 0.25.screenWidth,
                    buttonHeight: 0.035.screenHeight,
                    buttonColor: kColorRejectButton,
                    buttonBorderColor: kColorRejectButton,
                    buttonText: kSubmit,
                    textStyle: TextStyles.kPrimaryBoldPublicSans(
                      fontSize: TextStyles.k16FontSize,
                      colors: mColorBackground,
                    ),
                    borderRadius: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

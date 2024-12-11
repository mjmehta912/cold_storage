import 'package:cold_storage/app/constants/app_constants.dart';
import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/repositories/auth_repo.dart';
import 'package:cold_storage/app/screens/auth/login/model/login_req_model.dart';
import 'package:cold_storage/app/utils/alert_message_utils.dart';
import 'package:cold_storage/app/utils/app_widgets/app_button.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
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
        backgroundColor: kColorBackground,
        surfaceTintColor: kColorBackground,
        insetPadding: const EdgeInsets.symmetric(horizontal: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogHeader(context),
              AppSpaces.v16,
              _dialogRemarkTextField(context),
              AppSpaces.v16,
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
                buttonWidth: 0.4.screenWidth,
                buttonText: kSubmit,
              ),
            ],
          ),
        ),
      );
    },
  );
}

_dialogHeader(BuildContext context) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      children: [
        TextSpan(
          text: '$kYourReqWillBeSendToAdmin.',
          style: TextStyles.kPrimaryRegularInter(
            fontSize: TextStyles.k14FontSize,
            colors: kColorBlack,
          ),
        ),
        // TextSpan(
        //   text: 'CustomerName ',
        //   style: TextStyles.kPrimaryBoldInter(
        //     fontSize: TextStyles.k14FontSize,
        //     colors: kColorBlack,
        //   ),
        // ),
        // TextSpan(
        //   text: kRejectedReqText2,
        //   style: TextStyles.kPrimaryRegularInter(
        //     fontSize: TextStyles.k14FontSize,
        //     colors: kColorBlack,
        //   ),
        // ),
        // TextSpan(
        //   text: ' A0135-1/330',
        //   style: TextStyles.kPrimaryBoldInter(
        //     fontSize: TextStyles.k14FontSize,
        //     colors: kColorBlack,
        //   ),
        // ),
      ],
    ),
  );
}

_dialogRemarkTextField(BuildContext context) {
  return AppTextField(
    controller: remarkController,
    hintText: '$kReason...',
    labelStyle: TextStyles.kPrimaryRegularInter(
      colors: kColorD9D9D9,
    ),
    maxLines: 5,
    minLines: 2,
  );
}

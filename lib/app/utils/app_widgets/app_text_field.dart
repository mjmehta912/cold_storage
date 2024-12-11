import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.value,
    this.hintText,
    this.maxLength,
    this.textInputType,
    this.error,
    this.inputFormatters,
    this.maxLines,
    this.minLines,
    this.prefix,
    this.suffix,
    this.showCounter = false,
    this.labelText,
    this.labelStyle,
    this.textStyle,
    this.floatingLabelStyle,
    this.readOnly = false,
    this.onTap,
    this.fieldTitle,
    this.isRequired = false,
    this.exText,
    this.fillColor,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 10,
    ),
    this.focusNode,
    this.obscureText = false,
    this.forProfile = false,
  });

  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final String? value;
  final String? hintText;
  final int? maxLength;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? error;
  final int? maxLines;
  final int? minLines;
  final Widget? prefix;
  final Widget? suffix;
  final bool showCounter;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextStyle? floatingLabelStyle;
  final bool readOnly;
  final void Function()? onTap;
  final String? fieldTitle;
  final bool isRequired;
  final String? exText;
  final Color? fillColor;
  final EdgeInsetsGeometry? padding;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool forProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fieldTitle != null) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: fieldTitle ?? '',
                style: TextStyles.kPrimaryMediumPublicSans(),
              ),
              if (isRequired)
                AppText(
                  text: ' *',
                  style: TextStyles.kPrimaryMediumPublicSans(),
                ),
            ],
          ),
          AppSpaces.v8,
        ],
        if (forProfile)
          AppText(
            text: value ?? '',
            style: TextStyles.kPrimaryRegularPublicSans(),
          )
        else
          TextFormField(
            controller: controller,
            cursorColor: mColorBlack,
            style: TextStyles.kPrimaryMediumPublicSans(
              colors: mColorPrimaryText,
              fontSize: 18,
            ),
            keyboardType: textInputType,
            textCapitalization: TextCapitalization.sentences,
            onChanged: onChanged,
            textInputAction: TextInputAction.next,
            maxLength: maxLength,
            initialValue: value,
            inputFormatters: inputFormatters,
            maxLines: maxLines ?? 1,
            minLines: minLines ?? 1,
            readOnly: readOnly,
            onTap: onTap,
            focusNode: focusNode,
            obscureText: obscureText,
            obscuringCharacter: '*',
            validator: validator,
            decoration: InputDecoration(
              isDense: true,
              alignLabelWithHint: true,
              counterText: !showCounter ? '' : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              hintText: hintText,
              hintStyle: TextStyles.kPrimaryRegularPublicSans(),
              errorStyle: TextStyles.kPrimaryRegularPublicSans(
                colors: kColorRedFF0000,
              ),
              labelText: labelText != null
                  ? ((labelText ?? '') + (isRequired ? ' *' : ''))
                  : null,
              labelStyle: labelStyle ??
                  TextStyles.kPrimaryBoldPublicSans(
                    fontSize: TextStyles.k16FontSize,
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppUIUtils.primaryBorderRadius,
                borderSide: BorderSide(
                  color: error ?? false ? kColorRed : mColorBlack,
                  width: error ?? false ? 0.7 : 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppUIUtils.primaryBorderRadius,
                borderSide: BorderSide(
                  color: error ?? false ? kColorRed : mColorBlack,
                  width: error ?? false ? 0.7 : 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: AppUIUtils.primaryBorderRadius,
                borderSide: BorderSide(
                  color: kColorRed,
                  width: error ?? false ? 0.7 : 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: AppUIUtils.primaryBorderRadius,
                borderSide: BorderSide(
                  color: mColorBlack,
                  width: error ?? false ? 0.7 : 1,
                ),
              ),
              prefixIcon: prefix,
              prefixIconConstraints: const BoxConstraints(),
              suffixIcon: suffix,
              suffixIconConstraints: const BoxConstraints(),
            ),
          ),
        if (exText != null) ...[
          AppSpaces.v8,
          _ex(context),
        ],
        if (forProfile)
          Divider(
            color: Theme.of(context).primaryColor,
          ),
      ],
    );
  }

  Widget _ex(BuildContext context) {
    return AppText(
      text: exText ?? '',
      style: TextStyles.kPrimaryRegularPublicSans(),
    );
  }
}

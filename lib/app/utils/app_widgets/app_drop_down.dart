import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/app_spaces.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    required this.items,
    required this.string,
    required this.onChanged,
    super.key,
    this.selectedItem,
    this.prefix,
    this.labelText,
    this.labelStyle,
    this.floatingLabelStyle,
    this.hintText,
    this.error = false,
    this.fieldTitle,
    this.isRequired = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 12,
    ),
    this.validator,
    this.showSearchBox = true,
  });

  final List<T> items;
  final T? selectedItem;
  final String Function(T item) string;
  final void Function(T? value)? onChanged;
  final Widget? prefix;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final String? hintText;
  final bool error;
  final String? fieldTitle;
  final bool isRequired;
  final EdgeInsetsGeometry padding;
  final String? Function(T? value)? validator;
  final bool? showSearchBox;

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
                text: fieldTitle!,
                style: TextStyles.kPrimaryBoldPublicSans(),
              ),
              if (isRequired)
                AppText(
                  text: ' *',
                  style: TextStyles.kPrimaryBoldPublicSans(),
                ),
            ],
          ),
          AppSpaces.v8,
        ],
        DropdownSearch<T>(
          enabled: onChanged != null,
          onChanged: onChanged,
          selectedItem: selectedItem,
          items: items,
          itemAsString: string,
          popupProps: PopupProps.menu(
            fit: FlexFit.loose,
            showSearchBox: showSearchBox ?? true,
            searchDelay: Duration.zero,
            itemBuilder: (context, item, isSelected) {
              return Container(
                color: mColorBackground,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: string(item),
                      style: TextStyles.kPrimaryMediumPublicSans(
                        colors: mColorPrimaryText,
                        fontSize: TextStyles.k18FontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
            searchFieldProps: TextFieldProps(
              style: TextStyles.kPrimaryMediumPublicSans(
                colors: mColorPrimaryText,
                fontSize: 18,
              ),
              cursorColor: mColorBlack,
              decoration: InputDecoration(
                hintText: 'Search',
                constraints: const BoxConstraints(
                  maxHeight: 55,
                  minHeight: 55,
                ),
                hintStyle: TextStyles.kPrimaryRegularPublicSans(
                  colors: mColorBlack,
                  fontSize: 16,
                ),
                alignLabelWithHint: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppUIUtils.primaryBorderRadius,
                  borderSide: const BorderSide(
                    color: mColorBlack,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppUIUtils.primaryBorderRadius,
                  borderSide: const BorderSide(
                    color: mColorBlack,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppUIUtils.primaryBorderRadius,
                  borderSide: const BorderSide(
                    color: mColorBlack,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          clearButtonProps: const ClearButtonProps(
            icon: Icon(
              Icons.clear,
              size: 20,
              color: mColorPrimaryText,
            ),
            isVisible: false,
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            iconSize: 16,
            alignment: Alignment.centerRight,
          ),
          dropdownButtonProps: const DropdownButtonProps(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_drop_down_outlined,
              size: 40,
              color: mColorPrimaryText,
            ),
            color: kColorWhite,
            disabledColor: kColorWhite,
          ),
          validator: validator,
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyles.kPrimaryMediumPublicSans(
              colors: mColorPrimaryText,
              fontSize: TextStyles.k18FontSize,
            ),
            dropdownSearchDecoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              hintText: hintText,
              hintStyle: TextStyles.kPrimaryMediumPublicSans(
                colors: mColorPrimaryText,
                fontSize: TextStyles.k16FontSize,
              ),
              labelText: labelText,
              labelStyle: TextStyles.kPrimaryMediumPublicSans(
                colors: mColorPrimaryText,
                fontSize: TextStyles.k16FontSize,
              ),
              border: OutlineInputBorder(
                borderRadius: AppUIUtils.primaryBorderRadius,
                borderSide: BorderSide(
                  color: error ? kColorRed : mColorBlack,
                  width: error ? 0.7 : 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppUIUtils.primaryBorderRadius,
                borderSide: BorderSide(
                  color: error ? kColorRed : mColorBlack,
                  width: error ? 0.7 : 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppUIUtils.primaryBorderRadius,
                borderSide: BorderSide(
                  color: error ? kColorRed : mColorBlack,
                  width: error ? 0.7 : 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: AppUIUtils.primaryBorderRadius,
                borderSide: BorderSide(
                  color: kColorRed,
                  width: error ? 0.7 : 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: AppUIUtils.primaryBorderRadius,
                borderSide: BorderSide(
                  color: kColorRed,
                  width: error ? 0.7 : 1,
                ),
              ),
              prefixIcon: prefix,
              prefixIconConstraints: const BoxConstraints(),
              disabledBorder: OutlineInputBorder(
                borderRadius: AppUIUtils.primaryBorderRadius,
                borderSide: BorderSide(
                  color: error ? Colors.red : mColorBlack,
                  width: error ? 0.7 : 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

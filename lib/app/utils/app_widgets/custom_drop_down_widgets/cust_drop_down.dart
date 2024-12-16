import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/general_model/res/cust_model.dart';
import 'package:cold_storage/app/utils/app_widgets/app_size_extension.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustDropdown extends StatefulWidget {
  final String hintText;
  final List<CustomerData> items;
  final Function(List<CustomerData>) callBack;
  final Color? dropdownBGColor;

  const CustDropdown({
    super.key,
    required this.items,
    required this.callBack,
    required this.hintText,
    this.dropdownBGColor,
  });

  @override
  State<CustDropdown> createState() => _AppDropDownWithCheckBoxState();
}

class _AppDropDownWithCheckBoxState extends State<CustDropdown> {
  final TextEditingController textEditingController = TextEditingController();

  List<CustomerData> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<dynamic>(
        isExpanded: true,
        hint: Text(
          widget.hintText,
          style: TextStyles.kPrimaryMediumPublicSans(
            colors: mColorPrimaryText,
            fontSize: TextStyles.k18FontSize,
          ),
        ),
        items: widget.items.map(
          (item) {
            return DropdownMenuItem(
              value: item,
              enabled: false,
              child: StatefulBuilder(
                builder: (context, menuSetState) {
                  final isSelected = selectedItems.contains(item);
                  return InkWell(
                    onTap: () {
                      setState(
                        () {
                          if (isSelected) {
                            selectedItems.remove(item);
                          } else {
                            selectedItems.add(item);
                          }
                        },
                      );
                      menuSetState(
                        () {},
                      );
                    },
                    child: Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      color: mColorBackground,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              if (isSelected)
                                const Icon(
                                  Icons.check_box_outlined,
                                  color: mColorPrimaryText,
                                )
                              else
                                const Icon(
                                  Icons.check_box_outline_blank,
                                ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: AppText(
                                  text: item.pname ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.kPrimaryMediumPublicSans(
                                    fontSize: TextStyles.k18FontSize,
                                    colors: mColorPrimaryText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ).toList(),
        value: selectedItems.isEmpty ? null : selectedItems.last,
        onChanged: (dynamic value) {},
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            widget.callBack(selectedItems);
            textEditingController.clear();
          }
          setState(
            () {},
          );
        },
        selectedItemBuilder: (context) {
          return widget.items.map(
            (item) {
              return SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: AppText(
                    text: selectedItems.length > 1
                        ? '${selectedItems.length.toString()} Customers Selected'
                        : item.pname ?? '',
                    style: TextStyles.kPrimaryMediumPublicSans(
                      colors: mColorPrimaryText,
                      fontSize: TextStyles.k18FontSize,
                    ),
                    maxLines: 1,
                  ),
                ),
              );
            },
          ).toList();
        },
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down_outlined,
            size: 40,
            color: mColorPrimaryText,
          ),
        ),
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(
            left: 16,
            right: 8,
          ),
          height: 55,
          decoration: BoxDecoration(
            color: mColorBackground,
            borderRadius: AppUIUtils.primaryBorderRadius,
            border: Border.all(
              color: mColorBlack,
            ),
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 0.4.screenHeight,
          decoration: const BoxDecoration(
            color: mColorBackground,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 50,
          padding: EdgeInsets.zero,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: textEditingController,
                cursorColor: mColorBlack,
                style: TextStyles.kPrimaryMediumPublicSans(
                  colors: mColorPrimaryText,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search a Customer',
                  hintStyle: TextStyles.kPrimaryRegularPublicSans(
                    colors: mColorBlack,
                    fontSize: 16,
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
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.pname.toString().toLowerCase().contains(
                  searchValue.toLowerCase(),
                );
          },
        ),
      ),
    );
  }
}

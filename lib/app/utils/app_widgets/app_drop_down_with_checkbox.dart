import 'package:cold_storage/app/constants/color_constants.dart';
import 'package:cold_storage/app/constants/image_constants.dart';
import 'package:cold_storage/app/utils/app_widgets/app_text.dart';
import 'package:cold_storage/app/utils/text_styles/text_styles.dart';
import 'package:cold_storage/app/utils/ui/app_ui_utils.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDropDownWithCheckBox extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final Function(List<String>) callBack;

  const AppDropDownWithCheckBox({
    super.key,
    required this.items,
    required this.callBack,
    required this.hintText,
  });

  @override
  State<AppDropDownWithCheckBox> createState() =>
      _AppDropDownWithCheckBoxState();
}

class _AppDropDownWithCheckBoxState extends State<AppDropDownWithCheckBox> {
  List<String> selectedItems = [];
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
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
                        vertical: 8,
                      ),
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
                              const SizedBox(width: 16),
                              Expanded(
                                child: AppText(
                                  text: item,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyles.kPrimaryBoldInter(
                                    fontSize: TextStyles.k24FontSize,
                                    colors: kColorSecondPrimary,
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
        onChanged: (String? value) {},
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
                    text: selectedItems.isEmpty
                        ? widget.hintText
                        : selectedItems.join(', '),
                    style: TextStyles.kPrimaryBoldInter(
                      fontSize: TextStyles.k24FontSize,
                      colors: kColorBackground,
                    ),
                    maxLines: 1,
                  ),
                ),
              );
            },
          ).toList();
        },
        iconStyleData: IconStyleData(
          icon: SvgPicture.asset(kIconDropDown),
        ),
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(
            left: 16,
            right: 8,
          ),
          height: 52,
          decoration: BoxDecoration(
            color: kColorSecondPrimary,
            borderRadius: AppUIUtils.primaryBorderRadius,
          ),
        ),
        dropdownStyleData: const DropdownStyleData(
          decoration: BoxDecoration(
            color: kColorBackground,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 52,
          padding: EdgeInsets.zero,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().contains(searchValue);
          },
        ),
      ),
    );
  }
}

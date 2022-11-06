import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/dimens.dart';
import 'package:good_karma_app/helpers/style.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T?> onChanged;
  final T value;

  const CustomDropdown({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: kSpacingContainer, right: kSpacingContainer),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(
            color: primaryColor,
            width: 1,
          ),
          color: Colors.white),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          itemHeight: 50.0,
          items: dropdownMenuItemList,
          iconEnabledColor: primaryColor,
          dropdownColor: Colors.white,
          style: normalTextStyle,
          onChanged: onChanged,
          value: value,
        ),
      ),
    );
  }
}

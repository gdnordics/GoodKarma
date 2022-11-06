import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_karma_app/utils/extension.dart';

import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/dimens.dart';
import 'package:good_karma_app/helpers/style.dart';

class TextFormWidget extends StatelessWidget {
  final String? hintText, errorText, initialValue;
  final TextStyle? style;
  final Color? fillColor, errorColor;
  final Function? onValidation;
  final Function? onSaved;
  final TextEditingController? textEditingController;
  final int? maxLength;
  final int? maxLines;
  final bool? readOnly;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final Icon? icon;
  final bool? hideBorders;
  final bool? obscureText;

  const TextFormWidget(
      {Key? key,
      this.hintText,
      this.initialValue,
      this.errorText,
      this.maxLength,
      this.textInputType,
      this.onSaved,
      this.readOnly,
      this.maxLines,
      this.textEditingController,
      this.textInputFormatter,
      this.fillColor,
      this.style,
      this.errorColor,
      this.icon,
      this.obscureText,
      this.onValidation,
      this.hideBorders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxDecoration? decorator;
    if (hideBorders != true) {
      decorator = BoxDecoration(
        border: Border.all(color: kEditTextBorderColor),
        borderRadius: BorderRadius.circular(12.0),
      );
    }


    return Container(
      decoration: decorator,
      child: TextFormField(
        initialValue: initialValue,
        controller: textEditingController,
        textAlign: TextAlign.start,
        readOnly: readOnly ?? false,
        maxLines: obscureText != null && obscureText! ? 1 : maxLines,
        enabled: readOnly ?? true,
        cursorColor: primaryColor,
        validator: onValidation != null
            ? (value) {
                return onValidation!(value);
              }
            : null,
        onSaved: onSaved != null
            ? (value) {
                onSaved!(value);
              }
            : null,
        style: style ?? normalTextStyle,
        inputFormatters: textInputFormatter,
        buildCounter: (BuildContext? context,
                {int? currentLength, int? maxLength, bool? isFocused}) =>
            null,
        keyboardType: textInputType,
        maxLength: maxLength,
        decoration: InputDecoration(
            filled: true,
            fillColor: fillColor ?? Colors.white.withOpacity(0.5),
            hintText: hintText,
            hintStyle: normalTextStyle.copyWith(fontSize: 14.0, color: kEditTextHintColor),
            errorStyle:
                normalTextStyle.copyWith(color: errorColor ?? errorColor, fontSize: 14.0),
            contentPadding:
                const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(kTextRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(kTextRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(kTextRadius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(kTextRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(kTextRadius),
            ),
            prefixIcon: icon),
        obscureText: obscureText == null ? false : obscureText!,
      ),
    ).addMarginTop(12);
  }
}

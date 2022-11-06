import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final bool disabled;
  final double width;
  final double height;

  const ActionButton({
    Key? key, 
    required this.text, 
    required this.onPressed,
    required this.width,
    required this.height,
    this.color,
    this.disabled = false})
      : super(key: key);

  onBtnPressed() {
    if (!disabled) {
      onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    var btnColor = color ?? primaryColor;
    var txtColor = kLoginButtonTextColor;
    if (disabled) {
      txtColor = disabledButtonTextColor;
    }

    return ElevatedButton(
        onPressed: disabled ? null : onBtnPressed,
        style: ElevatedButton.styleFrom(
            primary: btnColor,
            fixedSize: Size(width, height),
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)))),
        child: Row(children: [
          Expanded(
              child: Text(text,
                  textAlign: TextAlign.center,
                  style:
                      mediumTextStyle.copyWith(color: txtColor))),
        ]));
  }
}

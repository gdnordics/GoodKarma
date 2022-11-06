import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const EditButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            fixedSize: Size(154, 50),
            alignment: Alignment.center,
            side: BorderSide(width: 1.0, color: primaryColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        onPressed: onPressed,
        child: Row(children: [
          Icon(
            Icons.edit_outlined,
            size: 22,
            color: primaryColor,
          ),
          SizedBox(width: 10.0),
          Text(text,
              style: boldTextStyle.copyWith(
                fontSize: 16.0,
                color: primaryColor,
              ))
        ]));
  }

}
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class VolunteerActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const VolunteerActionButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)))),
        onPressed: onPressed,
        child:
          Text(text,
              style: boldTextStyle.copyWith(
                fontSize: 12.0,
                color: Colors.white,
              )));
  }
}
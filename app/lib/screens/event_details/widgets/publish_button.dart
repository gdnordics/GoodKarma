import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class PublishButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PublishButton({
    Key? key,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(180, 40),
            primary: publishButtonColor,
            alignment: Alignment.center,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)))),
        onPressed: onPressed,
        child:
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text("PUBLISH NOW!",
                style: boldTextStyle.copyWith(
                  fontSize: 16.0,
                  color: Colors.white,
                ))));
  }
}
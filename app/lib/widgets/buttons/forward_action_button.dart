import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class ForwardActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ForwardActionButton({
    Key? key,
    required this.text,
    required this.onPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        fixedSize: Size(272, 58),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))
        )
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 30.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: mediumTextStyle.copyWith(
                  color: kLoginButtonTextColor
                )
            )),
          ),
          Container(
            decoration: BoxDecoration(
              color: forwardActionIconBGColor,
              borderRadius: BorderRadius.all(Radius.circular(15.0))
            ),
            width: 30.0,
            height: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.arrow_forward, size: 20.0,))
          
        ]
      )
    );
  }
}
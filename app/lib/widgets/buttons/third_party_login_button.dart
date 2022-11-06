import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class ThirdPartyLoginButton extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onPressed;

  const ThirdPartyLoginButton({
    Key? key,
    required this.text,
    required this.image,
    required this.onPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        primary: kThirdPartyLoginButttonBGColor,
        fixedSize: Size(272, 58),
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              child: Image.asset(
              image,
              height: 28,
              width: 28,
            )
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: mediumTextStyle.copyWith(
                  color: kThirdPartyLoginButtonTextColor
                )
            )),
          ),
        ]
      )
    );
  }
}
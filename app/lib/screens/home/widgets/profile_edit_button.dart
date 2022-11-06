import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';

class ProfileEditButton extends StatelessWidget {
  final VoidCallback onEditProfile;
  final String text;

  const ProfileEditButton({
    Key? key,
    required this.onEditProfile,
    required this.text,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            fixedSize: Size(154, 50),
            alignment: Alignment.center,
            side: BorderSide(width: 1.0, color: Color(0xFF5669FF)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)))),
        onPressed: onEditProfile,
        child: Row(children: [
          Icon(
            Icons.edit_outlined,
            size: 22,
            color: Color(0xFF5669FF),
          ),
          SizedBox(width: 10.0),
          Text(text,
              style: normalTextStyle.copyWith(
                fontSize: 16.0,
                color: Color(0xFF5669FF),
              ))
        ]));
  }

}
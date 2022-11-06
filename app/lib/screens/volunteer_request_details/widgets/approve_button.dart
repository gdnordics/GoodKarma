import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class ApproveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ApproveButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Approve",
          style: boldTextStyle.copyWith(
            fontSize: 14.0,
            color: Colors.black,
          )),
      ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: approvedEventColor,
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)))),
          onPressed: onPressed,
          child: Icon(Icons.check))
    ]);
  }
}

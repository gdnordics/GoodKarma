import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class MainLoadingScreen extends StatelessWidget {
  const MainLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
        alignment: Alignment.center,
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          SizedBox(
              height: 96.0,
              child: Image.asset(
                "assets/logos/logo_text.png",
                fit: BoxFit.cover,
              )),
          const SizedBox(height: 10),
          SizedBox(child: Text("by",
              style: normalKarmaTextStyle.copyWith(
                  fontSize: 14.0, color: subtitleColor))),
          const SizedBox(height: 10),
          SizedBox(
              height: 18,
              child: Image.asset("assets/logos/gdg.png", fit: BoxFit.fitHeight))
        ])));
  }
}

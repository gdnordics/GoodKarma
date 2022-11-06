import 'package:flutter/cupertino.dart';
import 'package:good_karma_app/helpers/colors.dart';

class MainLoadingScreen extends StatelessWidget {

  const MainLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: backgroundColor,
      child: SizedBox(
        height: 96.0,
        child: Image.asset(
                          "assets/logos/logo_text.png",
                          fit: BoxFit.cover,
        )));
  }
}
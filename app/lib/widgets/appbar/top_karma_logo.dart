import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';

class TopKarmaLogo extends StatelessWidget {

  const TopKarmaLogo({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              alignment: Alignment.center,
              height: 48,
              child: Image.asset(
                        "assets/logos/logo_text.png",
                        fit: BoxFit.cover,
                      ));
  }
}
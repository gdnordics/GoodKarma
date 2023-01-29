import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';
import 'dimens.dart';
import 'fonts.dart';

// Special fonts
final normalKarmaTextStyle = KarmaFonts.paniPuri(
    fontSize: 14.0,
    color: primaryLightGreenColor,
);

final mainLoadingScreenTextStyle = GoogleFonts.quicksand(
  color: mainLoadingScreenTextColor,
  fontSize: 24.0,
  fontWeight: FontWeight.bold
);

final normalTextStyle = GoogleFonts.quicksand(
    color: primaryTextColor,
    fontSize: kTextSizeMedium,
    fontWeight: FontWeight.w400
);

final normalPromptTextStyle = GoogleFonts.quicksand(
     fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: mainLoadingScreenTextColor
);

final mediumTextStyle = GoogleFonts.quicksand(
    color: primaryTextColor,
    fontSize: kTextSizeMedium,
    fontWeight: FontWeight.w500
);

final boldTextStyle = GoogleFonts.quicksand(
    color: primaryTextColor,
    fontSize: kTextSizeMedium,
    fontWeight: FontWeight.w700,
);
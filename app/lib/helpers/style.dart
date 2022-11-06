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


final normalTextStyle = GoogleFonts.roboto(
    color: primaryTextColor,
    fontSize: kTextSizeMedium,
    fontWeight: FontWeight.w400
);

final mediumTextStyle = GoogleFonts.roboto(
    color: primaryTextColor,
    fontSize: kTextSizeMedium,
    fontWeight: FontWeight.w500
);

final boldTextStyle = GoogleFonts.roboto(
    color: primaryTextColor,
    fontSize: kTextSizeMedium,
    fontWeight: FontWeight.w700,
);
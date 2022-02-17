import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStyles {
  //TextStyles
  static TextStyle get loginTitleText => GoogleFonts.getFont('Lobster Two',
      fontSize: 32, fontWeight: FontWeight.bold);
  static TextStyle get secondaryText => GoogleFonts.getFont('Nunito',
      fontSize: 14, fontWeight: FontWeight.bold, color: secondaryTextColor);
  static TextStyle get secondaryLinkText => GoogleFonts.getFont('Nunito',
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue);

  //Paddings, margins...
  static const double bodyPadding = 20.0;

  //Colors
  static const Color loginButtonColor = Color(0xff9DCBF7);
  static const Color secondaryTextColor = Color(0xffDCDCDC);
}

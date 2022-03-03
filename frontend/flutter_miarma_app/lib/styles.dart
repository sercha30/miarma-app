import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomStyles {
  //TextStyles
  static TextStyle get loginTitleText => GoogleFonts.getFont('Lobster Two',
      fontSize: 42, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle get appBarTitleText => GoogleFonts.getFont('Lobster Two',
      fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle get secondaryText => GoogleFonts.getFont('Nunito',
      fontSize: 14, fontWeight: FontWeight.bold, color: secondaryTextColor);
  static TextStyle get secondaryLinkText => GoogleFonts.getFont('Nunito',
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue);
  static TextStyle get registerSubText => GoogleFonts.getFont('Nunito',
      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey);
  static TextStyle get usernameProfileText => GoogleFonts.getFont('Nunito',
      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle get countNumberText => GoogleFonts.getFont('Nunito',
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle get userProfileSubText =>
      GoogleFonts.getFont('Nunito', fontSize: 14, color: Colors.black);
  static TextStyle get userProfileNameText => GoogleFonts.getFont('Nunito',
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle get noContentTitleText => GoogleFonts.getFont('Nunito',
      fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle get noContentSubText =>
      GoogleFonts.getFont('Nunito', fontSize: 18, color: Colors.black);

  //Paddings, margins...
  static const double bodyPadding = 20.0;

  //Colors
  static const Color loginButtonColor = Color(0xff76C8F9);
  static const Color secondaryTextColor = Color(0xffDCDCDC);
}

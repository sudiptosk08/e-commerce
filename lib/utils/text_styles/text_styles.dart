// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/app_colors.dart';

FontWeight _light = FontWeight.w300;
FontWeight _regular = FontWeight.w400;
const FontWeight _medium = FontWeight.w500;
const FontWeight _bold = FontWeight.w700;
const FontWeight _extraBold = FontWeight.w900;
TextStyle _poppins = GoogleFonts.poppins();
TextStyle _ptSans = GoogleFonts.ptSans();
// Naming: Camelcase
// FontWeight..fontclass..Size..Color
// normal18Red3c

class TextStyles {
  static TextStyle headline1 = TextStyle(
      fontSize: 31,
      fontWeight: FontWeight.w700,
      color: KColor.black,
      fontFamily: _poppins.fontFamily);

  static TextStyle headline2 = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: KColor.black,
      fontFamily: _poppins.fontFamily);

  static TextStyle headline3 = TextStyle(
    fontSize: 22,
    fontFamily: _poppins.fontFamily,
    fontWeight: FontWeight.w700,
    color: KColor.black,
  );

  static TextStyle headline4 = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w700,
    fontFamily: _poppins.fontFamily,
    color: KColor.black,
  );
  static TextStyle headline5 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: KColor.black,
      fontFamily: _poppins.fontFamily);

  static TextStyle headline6 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: KColor.black,
      fontFamily: _poppins.fontFamily);

  static TextStyle appBarText = TextStyle(
      fontWeight: FontWeight.w600,
      color: KColor.black,
      fontSize: 16,
      fontFamily: _poppins.fontFamily);
  static TextStyle mediumPoppins24white = TextStyle(
      fontWeight: _medium, fontSize: 18, fontFamily: _poppins.fontFamily);

  static TextStyle bodyText1 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: KColor.black,
      fontFamily: _poppins.fontFamily);

  static TextStyle bodyText2 = TextStyle(
      fontWeight: FontWeight.w400,
      color: KColor.black,
      fontSize: 12,
      fontFamily: _poppins.fontFamily);
  static TextStyle bodyText3 = TextStyle(
      fontWeight: FontWeight.w500,
      color: KColor.black,
      fontSize: 10,
      fontFamily: _poppins.fontFamily);
  static TextStyle subTitle1 = TextStyle(
    fontWeight: FontWeight.w500,
    color: KColor.black,
    fontSize: 15,
    fontFamily: _poppins.fontFamily,
  );
}

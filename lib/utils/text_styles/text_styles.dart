// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/app_colors.dart';

const FontWeight _light = FontWeight.w300;
const FontWeight _regular = FontWeight.w400;
const FontWeight _medium = FontWeight.w500;
const FontWeight _bold = FontWeight.w700;
const FontWeight _extraBold = FontWeight.w900;
TextStyle _poppins = GoogleFonts.poppins();
TextStyle _rubik = GoogleFonts.rubik();
TextStyle _ptSans = GoogleFonts.ptSans();
// Naming: Camelcase
// FontWeight..fontclass..Size..Color
// normal18Red3c

class TextStyles {
  static TextStyle headline1 = const TextStyle(
      fontSize: 31,
      fontWeight: FontWeight.w700,
      color: KColor.black,
      fontFamily: "SF Pro Display");

  static TextStyle headline2 = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: KColor.black,
      fontFamily: "SF Pro Display");

  static TextStyle headline3 = const TextStyle(
    fontSize: 22,
    fontFamily: "SF Pro Display",
    fontWeight: FontWeight.w700,
    color: KColor.black,
  );

  static TextStyle headline4 = const TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w700,
    fontFamily: "SF Pro Display",
    color: KColor.black,
  );
  static TextStyle headline5 = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: KColor.black,
      fontFamily: "SF Pro Display");

  static TextStyle headline6 = const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: KColor.black,
      fontFamily: "SF Pro Display");

  static TextStyle appBarText = const TextStyle(
      fontWeight: FontWeight.w600,
      color: KColor.black,
      fontSize: 16,
      fontFamily: "SF Pro Display");
  static TextStyle mediumPoppins24white = const TextStyle(
      fontWeight: _medium, fontSize: 18, fontFamily: "SF Pro Display");

  static TextStyle bodyText1 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: KColor.black,
      fontFamily: "SF Pro Display");

  static TextStyle bodyText2 = const TextStyle(
      fontWeight: FontWeight.w500,
      color: KColor.black,
      fontSize: 12.5,
      fontFamily: "SF Pro Display");
  static TextStyle bodyText3 = const TextStyle(
      fontWeight: FontWeight.w500,
      color: KColor.black,
      fontSize: 12,
      fontFamily: "SF Pro Display");
  static TextStyle subTitle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: KColor.black,
      fontSize: 17,
      fontFamily: "SF Pro Display");
}

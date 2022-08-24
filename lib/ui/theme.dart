import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static ThemeData customLight= ThemeData.dark().copyWith(
      primaryColor: primaryClr,
      backgroundColor: Colors.white,
      brightness: Brightness.light);

  static ThemeData customDark = ThemeData.dark().copyWith(
      primaryColor: darkGreyClr,
      backgroundColor: darkHeaderClr,
      brightness: Brightness.dark);
  }


 TextStyle get title1 {
  return GoogleFonts.lato(
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: Get.isDarkMode ? Colors.white : Colors.black
  );
}
 TextStyle get subTitle {
  return GoogleFonts.lato(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Get.isDarkMode ? Colors.white : Colors.black
  );
}

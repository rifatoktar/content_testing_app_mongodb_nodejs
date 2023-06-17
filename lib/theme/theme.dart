import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const bgColor = Color(0xff1E1E1E);
const primaryColor = Color(0xff292929);
const secondaryColor = Color(0xff3A3A3A);
const thirdColor = Color(0xffFF5D5D);
const blueButtonColor = Color(0xff305DFF);
const textColor = Colors.white;

class CustomTheme {
  static TextStyle head = GoogleFonts.quicksand(
      textStyle: const TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: textColor));
  static TextStyle introText = GoogleFonts.quicksand(
      textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor.withOpacity(.7)));
  static TextStyle textButton = GoogleFonts.quicksand(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: textColor));
  static TextStyle subHead = GoogleFonts.quicksand(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: textColor));
  static TextStyle hintText = GoogleFonts.quicksand(
      textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: textColor.withOpacity(.4)));
  static TextStyle buttonText = GoogleFonts.quicksand(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: blueButtonColor));
  static TextStyle logoutText = GoogleFonts.quicksand(
      textStyle: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: thirdColor));
  static TextStyle contentText = GoogleFonts.quicksand(
      textStyle: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: textColor));
}

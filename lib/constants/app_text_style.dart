import 'package:demo_project/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle mainTitle(Color color) => GoogleFonts.jost(
      fontSize: 24.sp, fontWeight: FontWeight.w700, color: color);
  static TextStyle textfieldTitle = GoogleFonts.jost(
      fontSize: 12.sp, fontWeight: FontWeight.w500, color: AppColors.black50);
  static TextStyle hintText = GoogleFonts.jost(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black25,
  );
  static TextStyle btnText = GoogleFonts.jost(
      fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white);
  static TextStyle jost500(Color color, double size) => GoogleFonts.jost(
      fontSize: size.sp, fontWeight: FontWeight.w500, color: color);
  static TextStyle jost12_400(Color color, {TextDecoration? decoration}) =>
      GoogleFonts.jost(
          decoration: decoration,
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
          color: color);
  static TextStyle jost14_400(Color color) => GoogleFonts.jost(
      fontWeight: FontWeight.w400, fontSize: 14.sp, color: color);
  static TextStyle jost16_250(Color color) => GoogleFonts.jost(
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
        color: color,
      );
  static TextStyle jost10_400(Color color) => GoogleFonts.jost(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );
  static TextStyle jost700(Color color, double size) => GoogleFonts.jost(
        fontSize: size.sp,
        fontWeight: FontWeight.w700,
        color: color,
      );
  static TextStyle jost22_400(Color color) => GoogleFonts.jost(
      fontSize: 22.sp, fontWeight: FontWeight.w400, color: color);
  static TextStyle oldPriceStyle = GoogleFonts.jost(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.lineThrough,
      color: AppColors.priceGray);
  static TextStyle jost400(Color color, double size,
          {TextDecoration? decoration}) =>
      GoogleFonts.jost(
        fontSize: size.sp,
        color: color,
        decoration: decoration
      );
}

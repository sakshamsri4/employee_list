import 'package:employee_list/constants/app_colors.dart';
import 'package:flutter/material.dart';

TextStyle getTextHeading(
    {Color? color = AppColors.colorWhite,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.normal}) {
  return  TextStyle(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
  );
}

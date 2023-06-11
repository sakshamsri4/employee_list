import 'package:employee_list/constants/app_colors.dart';
import 'package:employee_list/constants/theme_text.dart';
import 'package:flutter/material.dart';

class CustomWidget {
  Widget buildButton(
      {required String buttonText,
      Color textColor = AppColors.colorWhite,
      Color backgroundColor = AppColors.colorBlue,
      double width = 80,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Container(
            height: 30,
            width: width,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: AppColors.colorDarkGrey,
                width: 0.5,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
                child: Text(
              buttonText,
              style: getTextHeading(color: textColor, fontSize: 14),
            ))),
      ),
    );
  }
}

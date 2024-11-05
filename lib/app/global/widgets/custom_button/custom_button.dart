
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        this.height = 48,
        this.width = double.maxFinite,
        required this.onTap,
        this.title = 'Welcome',
        this.marginVerticel = 0,
        this.marginHorizontal = 0,
        this.fillColor,
        this.textColor = AppColors.white50 });

  final double height;
  final double width;
  final Color? fillColor;
  final Color textColor;

  final VoidCallback onTap;

  final String title;

  final double marginVerticel;
  final double marginHorizontal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: marginVerticel, horizontal: marginHorizontal),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), color: fillColor),
        child: CustomText(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor,
            textAlign: TextAlign.center,
            text: title),
      ),
    );
  }
}
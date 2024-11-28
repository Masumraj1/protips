import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart'; // Optional: For responsive design

class InfoDialogBox extends StatelessWidget {
  final VoidCallback onTapClose;
  final VoidCallback onTapContinue;

  const InfoDialogBox({
    super.key,
    required this.onTapClose,
    required this.onTapContinue,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white50,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close button
            Row(
              children: [
                const SizedBox(),
                const Spacer(),
                GestureDetector(
                  onTap: onTapClose,
                  child: Assets.icons.closeSmall.svg(), // Assuming you have this SVG asset
                ),
              ],
            ),

            // Title Text
            const CustomText(
              left: 50,
              fontSize: 16,
              maxLines: 2,
              text: AppStrings.howTOReceive,
              fontWeight: FontWeight.w500,
              color: AppColors.gray500,
              bottom: 10,
            ),

            // Email verification instruction
            const CustomText(
              textAlign: TextAlign.start,
              text: AppStrings.veryFyYourEmailAddress,
              fontWeight: FontWeight.w400,
              color: AppColors.gray500,
              fontSize: 14,
              maxLines: 10,
            ),

            // Name and mailing verification instruction
            const CustomText(
              textAlign: TextAlign.start,
              top: 16,
              text: AppStrings.veryFyYourNameAndMailing,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.gray500,
              bottom: 16,
              maxLines: 10,
            ),

            // Confirmation instruction
            const CustomText(
              textAlign: TextAlign.start,
              top: 16,
              text: AppStrings.confirmationOnce,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.gray500,
              bottom: 16,
              maxLines: 10,
            ),

            // Space before the button
            SizedBox(height: 20.h),

            // Continue button
            CustomButton(
              onTap: onTapContinue,
              title: AppStrings.continues,
              fillColor: AppColors.blue500,
            ),
          ],
        ),
      ),
    );
  }
}

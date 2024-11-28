import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class CustomPlayerCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? team;
  final String? position;
  final VoidCallback onTap;

  const CustomPlayerCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.team,
    this.position,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.green500),
        image: DecorationImage(
          image: AssetImage(Assets.images.playerz.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Allow column to adjust to its content
        children: [
          Center(
            child: CustomNetworkImage(
              borderRadius: BorderRadius.circular(5),
              backgroundColor: AppColors.green100,
              imageUrl: imageUrl,
              width: 95,
              height: 100,
            ),
          ),
          Gap(8.h),

          Center(
            child: CustomText(
              text: name,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.blue500,
            ),
          ),
          Gap(4.h),

            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.team,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.green500,
                    ),
                  ),
                  TextSpan(
                    text: team,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue500,
                    ),
                  ),
                ],
              ),
            ),
          Gap(4.h),

            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.position,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.green500,
                    ),
                  ),
                  TextSpan(
                    text: position,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue500,
                    ),
                  ),
                ],
              ),
            ),
          Gap(20.h),

            CustomButton(
              fillColor: AppColors.blue500,
              onTap: onTap,
              title: AppStrings.sendTippz,
            ),
        ],
      ),
    );
  }
}

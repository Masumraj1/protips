import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class CustomTeamCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? team;
  final String? buttonTitle;
  final String? position;
  final bool isTeam;
  final bool isPosition;
  final VoidCallback onTap;

  const CustomTeamCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.team,
    this.position,
    required this.isTeam,
    required this.isPosition,
    this.buttonTitle, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Slightly transparent background color
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.green500),
        image: DecorationImage(
          image: AssetImage(Assets.images.bgImage.path), // Using static background image
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Player Image with Star Icon
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CustomNetworkImage(
                    imageUrl: imageUrl,
                    height: 98.h,
                    width: double.infinity, // Make image fill the card width
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    height: 24.h,
                    width: 24.h,
                    decoration: const BoxDecoration(
                      color: AppColors.green500,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(8.h),

          // Player Name
          Expanded(
            flex: 2,
            child: Center(
              child: CustomText(
                text: name,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: AppColors.blue500,
              ),
            ),
          ),
          Gap(4.h),

          // Team Information
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomText(
                  text: isTeam ? 'Team: ' : "",
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.green500,
                ),
                Expanded(
                  child: CustomText(
                    text: team ?? "",
                    maxLines: 2,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.blue500,
                  ),
                ),
              ],
            ),
          ),
          Gap(4.h),

          // Position Information
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomText(
                  text: isPosition ? 'Position: ' : "Sports:",
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.green500,
                ),
                Expanded(
                  child: CustomText(
                    text: position ?? "",
                    maxLines: 2,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.blue500,
                  ),
                ),
              ],
            ),
          ),
          Gap(8.h),

          // Button
          Expanded(
            flex: 2,
            child: CustomButton(
              fillColor: AppColors.blue500,
              onTap: onTap,
              title: buttonTitle ?? "",
            ),
          ),
        ],
      ),
    );
  }
}

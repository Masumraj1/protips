import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class RewardCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String describe;
  final String points;
  final VoidCallback onTap;

  const RewardCard({
    super.key,
    required this.imageUrl,
    required this.name, required this.describe, required this.points, required this.onTap,
  });

  @override
  _CustomPlayerCardState createState() => _CustomPlayerCardState();
}

class _CustomPlayerCardState extends State<RewardCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.green500),
        image: DecorationImage(
          image: AssetImage(Assets.images.reward.path),
          fit: BoxFit.cover,
          scale: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Center(
            child: CustomNetworkImage(
              imageUrl: widget.imageUrl,
              height: 98.h,
              width: 100.w,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Gap(8.h),

          // Name
          Center(
            child: CustomText(
              top: 8,
              text: widget.name, // Use widget.name to access the property
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.blue500,
            ),
          ),
          Gap(8.h),

          // Description
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: AppStrings.description,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.green500,
                  ),
                ),
                TextSpan(
                  text: widget.describe,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blue500,
                  ),
                ),
              ],
            ),
            maxLines: 2,  // Set max lines here
            overflow: TextOverflow.ellipsis,  // To handle text overflow if it exceeds maxLines
          ),

          Gap(8.h),

          // Points Required
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.pointRequired,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.green500,
                  ),
                ),
                TextSpan(
                  text: widget.points,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blue500,
                  ),
                ),
              ],
            ),
          ),
          Gap(26.h),

          // Redeem Button
          Center(
            child: CustomButton(
              fillColor: AppColors.blue500,
              onTap: widget.onTap,
              title: AppStrings.redeem,
            ),
          ),
        ],
      ),
    );
  }
}

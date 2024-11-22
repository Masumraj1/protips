import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class CustomRewadzCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String? team;
  final String? buttonTitle;
  final String? position;
  final bool isTeam;
  final bool isPosition;
  final bool isVisible;
  final VoidCallback onTap;

  const CustomRewadzCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.team,
    this.position,
    required this.isTeam,
    required this.isPosition,
    this.buttonTitle,
    required this.onTap,
    this.isVisible = false,
  });

  @override
  _CustomPlayerCardState createState() => _CustomPlayerCardState();
}

class _CustomPlayerCardState extends State<CustomRewadzCard> {
  bool isStarred = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 277,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.green500),
        image: DecorationImage(
          image: AssetImage(Assets.images.bgImage.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Allow column to adjust to its content
        children: [
          Expanded(
            flex: 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  borderRadius: BorderRadius.circular(5),
                  backgroundColor: AppColors.green100,
                  imageUrl: widget.imageUrl,
                  width: MediaQuery.of(context).size.width / 4,
                  height: 100,
                ),
                Gap(20.h),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isStarred = !isStarred;
                    });
                  },
                  child: Container(
                    height: 24.h,
                    width: 24.h,
                    decoration: BoxDecoration(
                      color: isStarred ? AppColors.gray300 : AppColors.green500,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isStarred ? Icons.star : Icons.star_border,
                      color: Colors.white,
                      size: 16.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(8.h),

          Expanded(
            flex: 2,
            child: Center(
              child: CustomText(
                text: widget.name,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.blue500,
              ),
            ),
          ),
          Gap(4.h),

          if (widget.isVisible) // Show only if isVisible is true
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  CustomText(
                    text: widget.isTeam ? 'Description: ' : "",
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.green500,
                  ),
                  Expanded(
                    child: CustomText(
                      text: widget.team ?? "",
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

          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomText(
                  text: widget.isPosition ? 'Points Required:' : "Sports:",
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.green500,
                ),
                Expanded(
                  child: CustomText(
                    text: widget.position ?? "",
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

          Expanded(
            flex: 2,
            child: CustomButton(

              fillColor: AppColors.blue500,
              onTap: widget.onTap,
              title: widget.buttonTitle ?? "",
            ),
          ),
        ],
      ),
    );
  }
}

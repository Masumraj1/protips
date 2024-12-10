import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class CustomTeamCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? sport;
  final VoidCallback onTap;
  final VoidCallback onBookMarkTab; // Callback for bookmark action
  final RxBool isBookmark; // Pass the bookmark state

  const CustomTeamCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.sport,
    required this.onTap,
    required this.onBookMarkTab,
    required this.isBookmark,
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
          ///=========================Image=====================

          Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  // height: MediaQuery.of(context).size.height/7,
                  // width: 95,
                ),
              ),
              Positioned(
                top: 5, // Adjust this to position the icon above the card
                right: -2.w, // Adjust for right positioning
                child: GestureDetector(
                  onTap: onBookMarkTab, // Trigger bookmark action
                  child: Obx(() {
                    return isBookmark.value
                        ? Assets.images.starSelected.image()
                        : Assets.images.startUnselected.image();
                  }),
                ),
              ),
            ],
          ),
          Gap(8.h),

          ///=========================Team Name=====================
          Center(
            child: CustomText(
              text: name,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.blue500,
            ),
          ),
          Gap(10.h),

          ///=========================Sport=====================

          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: AppStrings.sport,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.green500,
                    ),
                  ),
                  TextSpan(
                    text: sport,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blue500,
                    ),
                  ),
                ],
              ),
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

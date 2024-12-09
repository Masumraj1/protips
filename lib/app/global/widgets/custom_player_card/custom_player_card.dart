import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';
import 'package:get/get.dart';

class CustomPlayerCard extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String? team;
  final String? position;
  final VoidCallback onTap;
  final VoidCallback onBookMarkTab; // Callback for bookmark action
  final RxBool isBookmark; // Pass the bookmark state

  const CustomPlayerCard({
    super.key,
    required this.imageUrl,
    required this.name,
    this.team,
    this.position,
    required this.onTap,
    required this.onBookMarkTab,
    required this.isBookmark,
  });

  @override
  _CustomPlayerCardState createState() => _CustomPlayerCardState();
}

class _CustomPlayerCardState extends State<CustomPlayerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Stack(
            children: [
              CustomNetworkImage(
                borderRadius: BorderRadius.circular(5),
                backgroundColor: AppColors.green100,
                imageUrl: widget.imageUrl,
                width: MediaQuery.of(context).size.width,
                height: 120,
              ),
              Positioned(
                top: 10.h,  // Adjust this to position the icon above the card
                right: 1.w,  // Adjust for right positioning
                child: GestureDetector(
                  onTap: widget.onBookMarkTab, // Trigger bookmark action
                  child: Obx(() {
                    return Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: widget.isBookmark.value
                            ? AppColors.green500
                            : AppColors.gray300,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.star,
                        color: widget.isBookmark.value
                            ? AppColors.white50
                            : Colors.black,
                        size: 24.sp,  // Adjust the size of the icon
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          Gap(8.h),
          Center(
            child: CustomText(
              text: widget.name,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: AppColors.blue500,
            ),
          ),
          Gap(4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: RichText(
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
                    text: widget.team,
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
          Gap(4.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: RichText(
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
                    text: widget.position,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomButton(
              fillColor: AppColors.blue500,
              onTap: widget.onTap,
              title: AppStrings.sendTippz,
            ),
          ),
        ],
      ),
    );
  }
}

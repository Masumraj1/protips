import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class CustomPlayerCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? team;
  final String? buttonTitle;
  final String? position;
  final bool isTeam;
  final bool isPosition;



  const CustomPlayerCard({
    super.key,
    required this.imageUrl,
    required this.name,
     this.team,
    this.position, required this.isTeam, required this.isPosition, this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.green500),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with star icon
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

          // Player name
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

          // Team information


    Expanded(
            flex: 1,
            child: Row(
              children: [
                 CustomText(
                  text: isTeam?'Team: ':"",
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: AppColors.green500,
                ),
                Expanded(
                  child: CustomText(
                    text: team??"",
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

          // Position information (conditionally shown)
            Expanded(
              flex: 1,
              child: Row(
                children: [
                   CustomText(
                    text:isPosition ?'Position : ' :"Sports :",
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
              onTap: () {
              },
              title: buttonTitle??"",
            ),
          ),
        ],
      ),
    );
  }
}

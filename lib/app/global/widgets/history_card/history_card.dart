import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/global/widgets/custom_image/custom_image.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class HistoryCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String date;
  final int? points;
  final String? amount;
  final String? time;
  final bool? isImage;

  const HistoryCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.date,
    this.points,
    this.amount, this.time,  this.isImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isImage == true?
              CustomNetworkImage(
                imageUrl: imageUrl??"",
                height: 48,
                width: 48,
                boxShape: BoxShape.circle,
              ): CustomImage(imageSrc: imageUrl??""),
              Gap(16.w),
              // Title, Date, and Points
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Title
                    CustomText(
                      text: title,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray500,
                    ),
                    Gap(4.h),
                    // Date
                    CustomText(
                      text: date,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey400,
                    ),
                  ],
                ),
              ),
              Gap(16.w),

              // Points and Amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Points
                  CustomText(
                    text: points != null ? "+$points Points" : "",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey400,
                  ),
                  const SizedBox(height: 4),
                  // Amount
                  CustomText(
                    text: amount != null ?"\$$amount" :"$time",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray500,
                  ),
                ],
              ),
            ],
          ),
          Gap(12.h),
          const Divider(
            color: AppColors.white50,
          ),
        ],
      ),
    );
  }
}

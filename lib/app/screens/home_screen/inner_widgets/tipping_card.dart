import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class TippingCard extends StatelessWidget {
  const TippingCard({super.key, required this.onTap});


  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(Assets.images.indiana22.path),
          // Use AssetImage with path
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(text: AppStrings.startTipping,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColors.white50,),
            SizedBox(height: 8.h),
            const CustomText(
              textAlign: TextAlign.start,
              maxLines: 4,
              text: AppStrings.tipYouFavorite,
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: AppColors.white50,),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: onTap,
              child: Row(
                children: [
                  const CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 4,
                    text: AppStrings.learnMore,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.green500,),
                  Icon(
                    Icons.arrow_right_alt,
                    color: Colors.greenAccent,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

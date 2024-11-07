import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class CustomMenuCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onTap;

  const CustomMenuCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                icon,
                CustomText(
                  color: AppColors.gray500,
                  left: 16.w,
                  text: title,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            Gap(10.h),
            const Divider(color: AppColors.white50),
          ],
        ),
      ),
    );
  }
}

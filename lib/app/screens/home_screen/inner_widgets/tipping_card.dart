import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';

class TippingCard extends StatelessWidget {
  const TippingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(Assets.images.indiana22.path), // Use AssetImage with path
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
            Text(
              'Start Tipping',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Tip your favorite players and teams, earn rewards, win prizes, and join a community of passionate sports lovers.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Text(
                  'Learn More',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.arrow_right_alt,
                  color: Colors.greenAccent,
                  size: 20.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

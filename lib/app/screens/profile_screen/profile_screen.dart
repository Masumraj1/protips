import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';

import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';
import 'package:protippz/app/screens/profile_screen/inner_widget/profile_details_row.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      bottomNavigationBar:  const NavBar(currentIndex: 4,),
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRoute.editProfileScreen);
              // Get.toNamed(AppRoute.editProfileScreen);
            },
            child: Assets.icons.edit.svg()
          ),
          const SizedBox(width: 10),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.green500,
        ),
        backgroundColor: AppColors.white50,
        title: CustomText(
          text: AppStrings.profile,
          color: AppColors.gray500,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
            CustomNetworkImage(
              boxShape: BoxShape.circle,
              imageUrl: AppConstants.profileImage,
              height: 94.h,
              width: 94.h,
            ),
            const CustomText(
              text: 'Robert Smith',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.gray500,
              top: 12,
              bottom: 5,
            ),
            const CustomText(
              text: 'robertsmith34@gmail.com',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.grey400,
              bottom: 35,
            ),
            Column(
              children: [
                const ProfileDetailRow(
                  label: AppStrings.userName,
                  value: 'robert12',
                ),
                Gap(20.h),
                const ProfileDetailRow(
                  label: "Phone Number :",
                  value: '+3489 9999 9778',
                ),

                Gap(20.h),
                const ProfileDetailRow(
                  label: "Address :",
                  value: 'Juvenal Ridge, Port Vestach',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



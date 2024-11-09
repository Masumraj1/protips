import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_card/custom_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      ///=========================Setting========================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.settings,
        iconData: Icons.arrow_back_outlined,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            ///=========================Change Password===================
            CustomCard(
                title: AppStrings.changePassword,
                icon: Assets.icons.key.svg(),
                onTap: () {
                  Get.toNamed(AppRoute.changePasswordScreen);

                }),
            Gap(15.h),
            ///=========================Delete Account===================
            CustomCard(
                title: AppStrings.deleteAccount,
                icon: Assets.icons.delete.svg(),
                onTap: () {
                  showDialogBox(context);
                }),
          ],
        ),
      ),
    );
  }

  ///========================= ===========Delete Account=============================
  void showDialogBox(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.white50,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Assets.icons.closeSmall.svg()
                )
              ],
            ),
            ///==========================Delete Account===============
            CustomText(
              left: 50,
              fontSize: 20.sp,
              text: "Delete Account",
              fontWeight: FontWeight.w500,
              color: AppColors.gray500,
              bottom: 10,
            ),
            CustomText(
              textAlign: TextAlign.start,
              text: "Are you sure want to delete your account?",
              fontWeight: FontWeight.w400,
              color: AppColors.gray500,
              fontSize: 14.sp,
              maxLines: 2,
            ),
            CustomText(
              top: 16,
              text: "Password",
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColors.gray500,
              bottom: 16,
            ),

            ///======================================Password Field==================
            const CustomTextField(
              isColor: true,
              hintText: "password",
              hintStyle: TextStyle(color: AppColors.gray500),
              isPassword: true,
              fillColor: AppColors.bg500,
            ),
            SizedBox(
              height: 20.h,
            ),

            Row(
              children: [
                ///=================================Yes Button============================

                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          AppColors.blue500),
                    ),
                    onPressed: () {
                    },
                    child: CustomText(
                      text: 'Confirm',
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight
                          .w600, // Make sure the text color contrasts with the button color
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                ///===================================Cancel Button=====================
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          AppColors.white50),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: CustomText(
                      text: "Cancel",
                      color: AppColors.blue500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight
                          .w600, // Make sure the text color contrasts with the button color
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}

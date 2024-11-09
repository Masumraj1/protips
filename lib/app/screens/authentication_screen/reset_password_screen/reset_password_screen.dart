import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/global/controllers/auth_controller/auth_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================Reset Password  Appbar===================
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: AppStrings.resetPassword,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const CustomText(
                  text: AppStrings.setANewPassword,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: AppColors.blue500,
                  bottom: 10,
                ),
            
                const CustomText(
                  text: AppStrings.createANewPasswordEnsure,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColors.green500,
                  bottom: 40,
                  maxLines: 3,
                ),
            
                //========================New Password Field=====================
                CustomFromCard(
                  isPassword: true,
                    hinText: AppStrings.enterYourNewPassword,
                    title: AppStrings.enterNewPassword,
                    controller: authController.emailController,
                    validator: (v) {}), 
                 Gap(12.h),
                //========================Confirm New Password Field=====================
                CustomFromCard(
                  isPassword: true,
                    hinText: AppStrings.confirmYourNewPassword,
                    title: AppStrings.confirmNewPassword,
                    controller: authController.emailController,
                    validator: (v) {}),
                 Gap(12.h),
            
            
            
            
                //==========================Reset Password Button=================
                 Gap(30.h),
                CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoute.signInScreen);

                  },
                  title: AppStrings.resetPassword,
                ),
            
            
            
            
              ],
            ),
          )
      ),
    );
  }
}

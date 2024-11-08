import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/global/controllers/auth_controller/auth_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================veryFy Code Appbar===================
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: AppStrings.verifyCode,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              const CustomText(
                text: AppStrings.checkYourEmail,
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: AppColors.blue500,
                bottom: 10,
              ),

              // const CustomText(
              //   text: AppStrings.enterYourEmailAndWe,
              //   fontWeight: FontWeight.w400,
              //   fontSize: 14,
              //   color: AppColors.green500,
              //   bottom: 40,
              //   maxLines: 3,
              // ),


               Gap(12.h),


                    const Row(
                      children: [
                        Spacer(),
                        CustomText(
                          text: AppStrings.resendOtp,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.blue500,
                        ),
                      ],
                    ),

              //==========================VeryFy Code Button=================
               Gap(30.h),
              CustomButton(
                onTap: () {
                      Get.toNamed(AppRoute.resetPasswordScreen);
                },
                title: AppStrings.verifyCode,
              ),




            ],
          )
      ),
    );
  }
}

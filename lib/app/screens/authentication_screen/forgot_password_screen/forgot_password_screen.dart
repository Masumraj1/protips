import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/global/controllers/auth_controller/auth_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================Forgot Password  Appbar===================
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: AppStrings.forgotPassword,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Obx(
            () {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    const CustomText(
                      text: AppStrings.forgotPasswordd,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: AppColors.blue500,
                      bottom: 10,
                    ),

                    const CustomText(
                      text: AppStrings.enterYourEmailAndWe,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.green500,
                      bottom: 40,
                      maxLines: 3,
                    ),

                    //========================Email Field=====================
                    CustomFromCard(
                      hinText: AppStrings.enterYourEmail,
                      title: AppStrings.email,
                      controller: authController.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterValidEmail;
                        } else if (!AppStrings.emailRegexp
                            .hasMatch(authController.emailController.text)) {
                          return AppStrings.enterValidEmail;
                        } else {
                          return null;
                        }
                      },
                    ),
                    Gap(12.h),

                    //==========================Send Code Button=================
                    Gap(30.h),
                    authController.isForgetLoading.value
                        ? const CustomLoader()
                        : CustomButton(
                            isRadius: true,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                authController.forgetPassword();
                              }
                            },
                            title: AppStrings.sendCode,
                          ),
                  ],
                ),
              );
            }
          )),
    );
  }
}

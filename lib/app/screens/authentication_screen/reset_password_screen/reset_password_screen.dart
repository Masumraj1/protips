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

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

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
          child: Obx(
             () {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                          controller: authController.passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          } else if (value.length < 8 ||
                              !AppStrings.passRegexp.hasMatch(value)) {
                            return AppStrings.passwordLengthAndContain;
                          } else {
                            return null;
                          }
                        },),
                       Gap(12.h),
                      //========================Confirm New Password Field=====================
                      CustomFromCard(
                        isPassword: true,
                          hinText: AppStrings.confirmYourNewPassword,
                          title: AppStrings.confirmNewPassword,
                          controller: authController.confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.fieldCantBeEmpty;
                          }

                          else if (authController.passwordController.text !=
                              authController.confirmPasswordController  .text) {
                            return "Password should be match";
                          }
                          return null;
                        },),
                       Gap(12.h),




                      //==========================Reset Password Button=================
                       Gap(30.h),
                      authController.isResend.value
                          ? const CustomLoader():
                      CustomButton(
                        isRadius: true,

                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            authController.resetPassword();
                          }
                        },
                        title: AppStrings.resetPassword,
                      ),




                    ],
                  ),
                ),
              );
            }
          )
      ),
    );
  }
}

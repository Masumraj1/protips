import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/global/controllers/auth_controller/auth_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================Change Password================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.changePassword,
        iconData: Icons.arrow_back_outlined,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  ///======================Current Password================
                  CustomFromCard(
                    isPassword: true,
                    title: AppStrings.currentPassword,
                    hinText: "Enter Current password",
                    controller: authController.oldPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.fieldCantBeEmpty;
                      } else if (value.length < 8 ||
                          !AppStrings.passRegexp.hasMatch(value)) {
                        return AppStrings.passwordLengthAndContain;
                      } else {
                        return null;
                      }
                    },
                  ),
                  Gap(12.h),

                  ///======================New Password================
                  CustomFromCard(
                    isPassword: true,
                    title: AppStrings.newPassword,
                    hinText: "Enter New Password",
                    controller: authController.newPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.fieldCantBeEmpty;
                      } else if (value.length < 8 ||
                          !AppStrings.passRegexp.hasMatch(value)) {
                        return AppStrings.passwordLengthAndContain;
                      } else {
                        return null;
                      }
                    },
                  ),

                  Gap(12.h),

                  ///======================Retype New Password================
                  CustomFromCard(
                    isPassword: true,
                    title: AppStrings.retype,
                    hinText: "Retype New Password",
                    controller: authController.confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.fieldCantBeEmpty;
                      } else if (authController.newPasswordController.text !=
                          authController.confirmPasswordController.text) {
                        return "Password should be match";
                      }
                      return null;
                    },
                  ),
                  Gap(25.h),

                  ///=========================Change Password======================

                  authController.isChangeLoading.value
                      ? const CustomLoader()
                      : CustomButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              authController.changePassword();
                            }
                          },
                          title: AppStrings.changePassword,
                        )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

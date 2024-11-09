import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
          child: Column(
            children: [
              ///======================Current Password================
              CustomFromCard(
                  isPassword: true,
                  title: AppStrings.currentPassword,
                  hinText: "Enter Current password",
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(12.h),

              ///======================New Password================
              CustomFromCard(
                  isPassword: true,
                  title: AppStrings.newPassword,
                  hinText: "Enter New Password",
                  controller: TextEditingController(),
                  validator: (v) {}),

              Gap(12.h),

              ///======================Retype New Password================
              CustomFromCard(
                  isPassword: true,
                  title: AppStrings.retype,
                  hinText: "Retype New Password",
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(25.h),

              ///=========================Change Password======================
              CustomButton(
                onTap: () {
                  Get.back();
                },
                title: AppStrings.changePassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class WithdrawCheck extends StatelessWidget {
  const WithdrawCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///=======================Check===================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.check,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: AppStrings.enterDetails,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColors.gray500,
                bottom: 15,
              ),
              ///=========================Full name================
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  controller: TextEditingController(),
                  title: AppStrings.fullName,
                  validator: (v) {}),
              Gap(12.h),
              const CustomText(
                text: AppStrings.mailingAddress,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColors.gray500,
                bottom: 15,
              ),

              ///======================Street address================
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: AppStrings.streetAddress,
                  controller: TextEditingController(),
                  validator: (v) {}),

              Gap(12.h),
              ///============================City======================
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  controller: TextEditingController(),
                  title: AppStrings.city,
                  validator: (v) {}),
              Gap(12.h),

              ///========================State===================
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: AppStrings.state,
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(12.h),

              ///=======================Zip Code==================
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: AppStrings.zipCode,
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(20.h),Gap(12.h),
              ///=======================Amount==================
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: AppStrings.amount,
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(20.h),
              ///========================now=====================
              CustomButton(
                onTap: () {
                  Get.back();
                },
                title: AppStrings.withdrawNow,
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
      appBar: CustomAppBar(
        appBarContent: "Check ",
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Enter Details",
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColors.gray500,
                bottom: 15,
              ),
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: "Full Name ",
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(12.h),
              CustomText(
                text: "Mailing Address",
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: AppColors.gray500,
                bottom: 15,
              ),
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: "Street Address",
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(12.h),
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: "Account Type",
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(12.h),
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: "City",
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(12.h),
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: "State",
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(12.h),
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: "Zip Code",
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(20.h),Gap(12.h),
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  title: "Amount",
                  controller: TextEditingController(),
                  validator: (v) {}),
              Gap(20.h),
              CustomButton(
                onTap: () {
                  Get.back();
                },
                title: "Withdraw Now",
              )
            ],
          ),
        ),
      ),
    );
  }
}

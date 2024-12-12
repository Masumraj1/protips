import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/withdraw_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class WithdrawCheck extends StatelessWidget {
   WithdrawCheck({super.key});

  final WithdrawController withdrawController = Get.find<WithdrawController>();
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
          child: Obx(
             () {
              return Column(
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
                      controller: withdrawController.fullNameController,
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
                      controller: withdrawController.addressController,
                      validator: (v) {}),

                  Gap(12.h),
                  ///============================City======================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      controller: withdrawController.cityController,
                      title: AppStrings.city,
                      validator: (v) {}),
                  Gap(12.h),

                  ///========================State===================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      title: AppStrings.state,
                      controller: withdrawController.stateController,
                      validator: (v) {}),
                  Gap(12.h),

                  ///=======================Zip Code==================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      title: AppStrings.zipCode,
                      controller:withdrawController.zipCodeController,
                      validator: (v) {}),
                  Gap(20.h),
                  ///=======================Amount==================
                  CustomFromCard(
                      hinText: AppStrings.typeHere,
                      title: AppStrings.amount,
                      controller: withdrawController.amountController,
                      validator: (v) {}),

                  ///=======================Mail==================
                  Gap(20.h),
                  CustomFromCard(
                      hinText: AppStrings.enterYourEmail,
                      title: AppStrings.email,
                      controller: withdrawController.emailController,
                      validator: (v) {}),
                  Gap(20.h),
                  ///========================now=====================
                  withdrawController.isCheckLoading.value?const CustomLoader():

                  CustomButton(
                    onTap: () {
                      withdrawController.withdrawCheckMethod();
                    },
                    title: AppStrings.withdrawNow,
                  )
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

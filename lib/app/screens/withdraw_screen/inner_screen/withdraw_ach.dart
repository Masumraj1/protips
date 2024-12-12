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

class WithdrawAch extends StatelessWidget {
  WithdrawAch({super.key});

  final WithdrawController withdrawController = Get.find<WithdrawController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///=======================Ach=========================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.ach,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(() {
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

                ///=========================bank Account ===================
                CustomFromCard(
                    hinText: AppStrings.typeHere,
                    title: AppStrings.bankAccountNumber,
                    controller: withdrawController.bankAccountNumberController,
                    validator: (v) {}),
                Gap(12.h),

                ///=========================Routing Number ===================
                CustomFromCard(
                    hinText: AppStrings.typeHere,
                    title: AppStrings.routingNumber,
                    controller: withdrawController.routingNumberController,
                    validator: (v) {}),
                Gap(12.h),

                ///========================Account Type ===================

                CustomFromCard(
                    hinText: AppStrings.typeHere,
                    title: AppStrings.accountType,
                    controller: withdrawController.accountTypeController,
                    validator: (v) {}),
                Gap(12.h),

                ///========================bankName ===================
                CustomFromCard(
                    hinText: AppStrings.typeHere,
                    title: AppStrings.bankName,
                    controller: withdrawController.bankNameController,
                    validator: (v) {}),
                Gap(12.h),

                ///========================Account Holder Name ===================

                CustomFromCard(
                    hinText: AppStrings.typeHere,
                    title: AppStrings.accountHolderName,
                    controller: withdrawController.accountHolderNameController,
                    validator: (v) {}),
                Gap(12.h),

                ///========================amount ===================

                CustomFromCard(
                    hinText: AppStrings.typeHere,
                    title: AppStrings.amount,
                    controller: withdrawController.amountController,
                    validator: (v) {}),
                Gap(20.h),
                //=========================withdrawFunds=====================

                withdrawController.isAchLoading.value
                    ? const CustomLoader()
                    : CustomButton(
                        onTap: () {
                          withdrawController.withdrawAchMethod();
                        },
                        title: AppStrings.withdrawFunds,
                      )
              ],
            );
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/payment_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_payment_card/custom_payment_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({super.key});

  final ValueNotifier<String?> _selectedPaymentMethod =
      ValueNotifier<String?>(null);

  final PaymentController paymentController = Get.find<PaymentController>();
  final RxString selectedPaymentMethod = "Stripe".obs; // To track the selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================Withdraw funds========================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.withdrawFunds,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
           () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  top: 10,
                  bottom: 10,
                  text: AppStrings.withdrawOptions,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray500,
                ),

                ///===========================Ach=======================
                CustomPaymentCard(
                  title: "Ach",
                  icon: Assets.images.ach.image(),
                  isSelected: selectedPaymentMethod.value == "Ach",
                  onTap: () {
                    selectedPaymentMethod.value = "Ach";  // Set selected payment method to Stripe
                  },
                ),

                ///===========================Check=======================
                CustomPaymentCard(
                  title: "Check",
                  icon: Assets.images.check.image(),
                  isSelected: selectedPaymentMethod.value == "Check",
                  onTap: () {
                    selectedPaymentMethod.value = "Check";  // Set selected payment method to PayPal
                  },
                ),
                Gap(12.h),
                CustomButton(
                  isRadius: true,
                  onTap: () {
                      if (selectedPaymentMethod.value == "Ach") {
                        Get.toNamed(AppRoute.withdrawAch);
                      } else if (selectedPaymentMethod.value == "Check") {
                        Get.toNamed(AppRoute.withdrawCheck);
                        // Call PayPal payment method
                      }
                    else {
                      toastMessage(message: "Please enter a valid amount");
                    }
                  },
                  title: AppStrings.continues,
                  fillColor: AppColors.green500,
                )
              ],
            );
          }
        ),
      ),
    );
  }
}

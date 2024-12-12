import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/payment_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_payment_card/custom_payment_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class DepositeScreen extends StatelessWidget {
  DepositeScreen({super.key});

  final PaymentController paymentController = Get.find<PaymentController>();
  final TextEditingController amountController = TextEditingController();
 final RxString selectedPaymentMethod = "Stripe".obs; // To track the selected payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///==========================Deposit Funds===============
      appBar: const CustomAppBar(
        appBarContent: AppStrings.depositFunds,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(
          () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  top: 10,
                  text: "Select Amount :",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray500,
                  bottom: 20,
                ),

                CustomTextField(
                  inputTextStyle: const TextStyle(color: Colors.black),
                  hintText: "Type Amount....",
                  textEditingController: amountController,  // Assign controller to capture the amount
                  fillColor: AppColors.white50,
                  fieldBorderColor: AppColors.gray500,
                ),

                ///===========================Deposit Options=======================
                const CustomText(
                  top: 10,
                  text: "Choose Payment Option :",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray500,
                  bottom: 20,
                ),

                ///==============================Stripe=====================
                CustomPaymentCard(
                  title: "Card",
                  icon: Assets.images.stripee.image(),
                  isSelected: selectedPaymentMethod.value == "Stripe",
                  onTap: () {
                    selectedPaymentMethod.value = "Stripe";  // Set selected payment method to Stripe
                  },
                ),

                ///===========================Paypal=======================
                CustomPaymentCard(
                  title: "Paypal",
                  icon: Assets.images.paypal.image(),
                  isSelected: selectedPaymentMethod.value == "Paypal",
                  onTap: () {
                    selectedPaymentMethod.value = "Paypal";  // Set selected payment method to PayPal
                  },
                ),

                Gap(20.h),

                ///=============================Continue Button======================
                CustomButton(
                  isRadius: true,
                  onTap: () {
                    double amount = double.tryParse(amountController.text) ?? 0;

                    if (amount > 0) {
                      if (selectedPaymentMethod.value == "Stripe") {
                        // Call Stripe payment method
                        paymentController.makePayment(amount: (amount).toInt());  // Convert to cents for Stripe
                      } else if (selectedPaymentMethod.value == "Paypal") {
                        // Call PayPal payment method
                        paymentController.paymentPaypal(amount: amount);
                      }
                    } else {
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

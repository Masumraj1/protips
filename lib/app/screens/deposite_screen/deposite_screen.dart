import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/payment_controller.dart';
import 'package:protippz/app/controller/paypal_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_payment_card/custom_payment_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class DepositeScreen extends StatelessWidget {
  DepositeScreen({super.key});

  final PaymentController paymentController = Get.find<PaymentController>();
  final PaypalController paypalController = Get.find<PaypalController>();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              top: 10,
              text: AppStrings.depositOption,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.gray500,
              bottom: 20,
            ),



                
            ///==============================Stripe=====================
            CustomPaymentCard(
                title: "Card",
                icon: Assets.images.stripee.image(),
                isSelected: true,
                onTap: () {
                  paymentController.makePayment(amount: 5);
                }),

            ///===========================Paypal=======================
            CustomPaymentCard(
                title: "Paypal",
                icon: Assets.images.paypal.image(),
                isSelected: true,
                onTap: () {
                  paypalController.paymentPaypal(
                    amount: 200.0, // Amount for payment
                    // driverId: 'driver123', // Driver ID (pass as needed)
                    // tripId: 'trip123', // Trip ID (pass as needed)
                  );

                }),
            Gap(20.h),

            ///=============================Continue Button======================
            CustomButton(
              isRadius: true,
              onTap: () {

              },
              title: AppStrings.continues,
              fillColor: AppColors.green500,
            )
          ],
        ),
      ),
    );
  }
}

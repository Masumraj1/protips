import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/payment_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class DepositeCardScreen extends StatelessWidget {
  DepositeCardScreen({super.key});

  final PaymentController paymentController = Get.find<PaymentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================CreditCard===================
      appBar:  const CustomAppBar(
        appBarContent: AppStrings.creditCard,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const CustomText(
              text: AppStrings.enterCardDetails,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              bottom: 12,
            ),
            ///=================Card Holder Name===============
            CustomFromCard(
                hinText: 'Bessie Cooper',
                title: AppStrings.cardHolderName,
                controller: paymentController.cardHolderController,
                validator: (v) {}),
            Gap(12.h),
            ///=================Card Number===============
            CustomFromCard(
                hinText: '6578 3467 6967 2086',
                title: AppStrings.cardName,
                controller: paymentController.cardNumberController,
                validator: (v) {}),
            Gap(12.h),

            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: CustomFromCard(
                      hinText: '08/2026',
                      title: AppStrings.expireDate,
                      controller: TextEditingController(),
                      validator: (v) {}),
                ),
                  Gap(12.w),
                Expanded(
                  flex: 5,
                  child: CustomFromCard(
                      hinText: '124',
                      title: AppStrings.cvv,
                      controller: TextEditingController(),
                      validator: (v) {}),
                ),
              ],
            ),
              ///=================Amount===============
            CustomFromCard(
                hinText: '\$500',
                title: AppStrings.amount,
                controller: paymentController.cardHolderController,
                validator: (v) {}),
            Gap(40.h),
            ///========================Deposite Now==================
            CustomButton(
              onTap: () {
                Get.back();
              },
              title: AppStrings.depositNow,
            )
          ],
        ),
      ),
    );
  }
}

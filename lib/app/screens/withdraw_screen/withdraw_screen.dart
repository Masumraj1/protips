import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/payment_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_payment_card/custom_payment_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({super.key});

  final ValueNotifier<String?> _selectedPaymentMethod =
  ValueNotifier<String?>(null);

  final PaymentController paymentController = Get.find<PaymentController>();

  void _onPaymentMethodSelected(String value) {
    _selectedPaymentMethod.value = value;
    print("Selected Payment Method: $value");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.withdrawFunds,
        iconData: Icons.arrow_back,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            left: 20,
            top: 10,
            text: "Withdraw Options",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.gray500,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ValueListenableBuilder<String?>(
              valueListenable: _selectedPaymentMethod,
              builder: (context, selectedMethod, _) {
                return Column(
                  children: paymentController.withdrawMethod.map((method) {
                    final isSelected = selectedMethod == method["value"];
                    return CustomPaymentCard(
                      title: method["title"],
                      icon: method["icon"],
                      isSelected: isSelected,
                      onTap: () => _onPaymentMethodSelected(method["value"]),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ValueListenableBuilder<String?>(
              valueListenable: _selectedPaymentMethod,
              builder: (context, selectedMethod, _) {
                return CustomButton(
                  onTap: () {
                    if (selectedMethod == "credit_card") {
                      Get.toNamed(AppRoute.depositeCardScreen);
                    } else if (selectedMethod == "ach"){
                      Get.toNamed(AppRoute.withdrawAch);
                    }else if(selectedMethod == "check"){
                      Get.toNamed(AppRoute.withdrawCheck);

                    }else{
                      print('allow');
                    }
                  },
                  title: AppStrings.continues,
                  fillColor: (selectedMethod == "credit_card" || selectedMethod == "ach" || selectedMethod == "check")
                      ? AppColors.green500
                      : AppColors.gray300,
                );
              },
            ),
          ),
          Gap(20.h),
        ],
      ),
    );
  }
}

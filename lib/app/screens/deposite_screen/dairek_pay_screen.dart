import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/dairek_pay_controller.dart';
import 'package:protippz/app/controller/player_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/controllers/genarel_controller/genarel_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_payment_card/custom_payment_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class DairekPayScreen extends StatelessWidget {
  DairekPayScreen({super.key});

  final DairekPayController _controller = Get.find<DairekPayController>();
  final TextEditingController amountController = TextEditingController();
  final RxString selectedPaymentMethod =
      "Stripe".obs; // To track the selected payment method
  final GeneralController generalController = Get.find<GeneralController>();

  // final PlayerController _playerController = Get.find<PlayerController>();
  final List<dynamic> arguments = Get.arguments;

  // Access individual arguments by index
  final String id = Get.arguments[0];   // Assuming 'id' is at index 0
  final String type = Get.arguments[1];
  // final String id = Get.arguments ?? ''; // Default to empty string if id is not passed
  @override
  Widget build(BuildContext context) {

    print("=====================id$id");
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///==========================Pay Instant===============
      appBar: const CustomAppBar(
        appBarContent: "Now Pay",
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  selectedPaymentMethod.value =
                      "Stripe"; // Set selected payment method to Stripe
                },
              ),

              ///===========================Paypal=======================
              CustomPaymentCard(
                title: "Paypal",
                icon: Assets.images.paypal.image(),
                isSelected: selectedPaymentMethod.value == "Paypal",
                onTap: () {
                  selectedPaymentMethod.value =
                      "Paypal"; // Set selected payment method to PayPal
                },
              ),

              Gap(20.h),

              ///=============================Continue Button======================
              CustomButton(
                isRadius: true,
                onTap: () {
                  String amountText =
                      generalController.sendAmountController.text;
                  // var playerList = _playerController.selectPlayerList;
                  // int selectedIndex = 0; // Assuming you want to process the first player, you can change this logic
                  //
                  // String id = playerList[selectedIndex].id ?? "";
                  double amount = double.tryParse(amountText) ?? 0.0;
                  if (selectedPaymentMethod.value == "Stripe") {
                    _controller.makePayment(
                        amount: int.parse(amountText),
                        id: id,
                        playerOrTeamId:type);
                  } else if (selectedPaymentMethod.value == "Paypal") {
                    // Call PayPal payment method
                    _controller.paymentPaypal(
                      amount: amount,
                      playerId: id,
                      entityType: type,
                    );
                  } else {
                    toastMessage(message: "Please enter a valid amount");
                  }
                },
                title: AppStrings.continues,
                fillColor: AppColors.green500,
              )
            ],
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';


class OtpVeryEmail extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController pinController;
  final VoidCallback onSendCode;
  final VoidCallback onClose;
  final HomeController homeController = Get.find<HomeController>();
  OtpVeryEmail({
    super.key,
    required this.formKey,
    required this.pinController,
    required this.onSendCode,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white50,
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close Button Row
            Row(
              children: [
                const SizedBox(),
                const Spacer(),
                GestureDetector(
                    onTap: onClose,
                    child: Assets.icons.closeSmall.svg()) // Close icon
              ],
            ),

            const CustomText(
              left: 50,
              fontSize: 16,
              text: "Enter Code",
              fontWeight: FontWeight.w500,
              color: AppColors.gray500,
              bottom: 20,
            ), const CustomText(
              text: 'Please enter the 6 digit code',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              bottom: 10,
            ),       Expanded(
              child: PinCodeTextField(
                textStyle: const TextStyle(color: AppColors.gray500),
                keyboardType: TextInputType.phone,
                autoDisposeControllers: false,
                cursorColor: AppColors.gray500,
                appContext: context,
                controller: pinController,
                onCompleted: (value) {
                  homeController.resetCodeInput = value;
                },
                validator: (value) {
                  if (value != null && value.length == 5) {
                    return null;
                  } else {
                    return "Please enter a valid 5-digit OTP code";
                  }
                },
                autoFocus: true,
                pinTheme: PinTheme(
                  disabledColor: Colors.transparent,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 49.h,
                  fieldWidth: 47.w,
                  activeFillColor: AppColors.white50,
                  selectedFillColor: AppColors.white50,
                  inactiveFillColor: AppColors.white50,
                  borderWidth: 0.5,
                  activeBorderWidth: 2.0, // Thicker border when active
                  selectedColor: AppColors.blue500, // Border color when selected
                  inactiveColor: AppColors.gray300, // Border color when inactive
                  activeColor: AppColors.blue500, // Active border color
                ),
                length: 5, // Ensure length is 6 for OTP input
                enableActiveFill: true,
              ),
            ),

            SizedBox(height: 20.h),

            // Reactive Loader or Button
            Obx(() {
              return homeController.isVeryFyOtp.value?const CustomLoader()
                  : CustomButton(
                onTap: onSendCode,
                title: "VeryFy Code",
                fillColor: AppColors.blue500,
              );
            }),
          ],
        ),
      ),
    );
  }
}

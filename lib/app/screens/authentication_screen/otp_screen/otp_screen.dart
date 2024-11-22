import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _ForgetOtpState();
}

class _ForgetOtpState extends State<OtpScreen> {
  final String isSignUp = Get.parameters[AppStrings.signUp] ?? "true";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================veryFy Code Appbar===================
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: AppStrings.verifyCode,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              ///=============================Header Text=============================
              const CustomText(
                text: AppStrings.checkYourEmail,
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: AppColors.blue500,
              ),

              Gap(50.h),

              ///=============================Pin Code Text Field=============================
              PinCodeTextField(
                textStyle: const TextStyle(color: AppColors.gray500),
                keyboardType: TextInputType.phone,
                autoDisposeControllers: false,
                cursorColor: AppColors.gray500,
                appContext: context,
                // controller: authenticationController.pinCodeController,
                // onCompleted: (value) {
                //   if (isSignUp == "true") {
                //     authenticationController.activationCode = value;
                //   } else {
                //     authenticationController.otp = value;
                //   }
                // },
                validator: (value) {
                  if (value!.length == 4) {
                    return null; // Input is valid
                  } else {
                    return "Please enter a 4-digit OTP code"; // Input is invalid
                  }
                },
                autoFocus: true,
                pinTheme: PinTheme(
                  disabledColor: Colors.transparent,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 49.h,
                  fieldWidth: 47,
                  activeFillColor: AppColors.white50,
                  selectedFillColor: AppColors.white50,
                  inactiveFillColor: AppColors.white50,
                  borderWidth: 0.5,
                  activeBorderWidth: 0.8,
                  selectedColor: AppColors.white50,
                  inactiveColor: AppColors.white50,
                  activeColor: AppColors.white50,
                ),
                length: 4,
                enableActiveFill: true,
              ),

              SizedBox(height: 50.h),

              const Row(
                children: [
                  Spacer(),
                  CustomText(
                    text: AppStrings.resendOtp,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.blue500,
                  ),
                ],
              ),

              //==========================VeryFy Code Button=================
              Gap(30.h),
              CustomButton(
                isRadius: true,
                onTap: () {
                  Get.toNamed(AppRoute.resetPasswordScreen);
                },
                title: AppStrings.verifyCode,
              ),
            ],
          )),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/global/controllers/auth_controller/auth_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final AuthController authenticationController = Get.find<AuthController>();
  final String isSignUp = Get.parameters[AppStrings.signUp] ?? "true";
  final String email = Get.parameters[AppStrings.email] ?? "";

  final formKey = GlobalKey<FormState>();
  int _secondsRemaining = 200;
  late Timer _timer;

  /// Timer logic to count down
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            _timer.cancel();
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      /// App Bar
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: AppStrings.verifyCode,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Obx(
              () {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  /// Header Text
                  const CustomText(
                    text: AppStrings.checkYourEmail,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: AppColors.blue500,
                  ),
                   CustomText(
                     top: 15,
                     maxLines: 5,

                    text: "We sent a reset link to $email. Please enter the 5-digit code.",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.green500,
                  ),


                  Gap(60.h),

                  /// Pin Code Text Field
                  PinCodeTextField(
                    textStyle: const TextStyle(color: AppColors.gray500),
                    keyboardType: TextInputType.phone,
                    autoDisposeControllers: false,
                    cursorColor: AppColors.gray500,
                    appContext: context,
                    controller: authenticationController.pinController,
                    onCompleted: (value) {
                      if (isSignUp == "true") {
                        authenticationController.activationCode = value;
                      } else {
                        authenticationController.resetCodeInput = value;
                      }
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
                    length: 5,
                    enableActiveFill: true,
                  ),

                  SizedBox(height: 50.h),

                  /// Resend OTP Section
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: _secondsRemaining == 0
                          ? () {
                        setState(() {
                          _secondsRemaining = 200; // Reset timer
                          startTimer(); // Restart the timer
                        });

                        // // Call the resend function
                        // authenticationController.resentUser().then((value) {
                        //   if (!value) {
                        //     setState(() {
                        //       _timer.cancel(); // Cancel timer if resend failed
                        //       _secondsRemaining = 0;
                        //     });
                        //   }
                        // });
                      }
                          : null,
                      child: CustomText(
                        text: _secondsRemaining == 0
                            ? "Resend OTP"
                            : "Resend OTP in $_secondsRemaining seconds",
                        color: AppColors.green500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Gap(30.h),

                  /// Verify Button
                  authenticationController.isSignUpOtp.value ||
                      authenticationController.isForget.value
                      ? const CustomLoader()
                      : CustomButton(
                    isRadius: true,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        if (isSignUp == "true" && isSignUp.isNotEmpty) {
                          authenticationController.signUpVerifyOTP();
                        } else {
                          authenticationController.forgetOtp();
                        }
                      }
                    },
                    title: AppStrings.verifyCode,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

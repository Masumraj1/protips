import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/controllers/auth_controller/auth_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================Sign In Appbar===================
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: AppStrings.signIn,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Obx(() {
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomText(
                    text: AppStrings.helloAgain,
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: AppColors.blue500,
                    bottom: 10,
                  ),

                  const CustomText(
                    text: AppStrings.welcomeBackToProtippzSignInto,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.green500,
                    bottom: 40,
                    maxLines: 3,
                  ),

                  ///========================Email Field=====================
                  CustomFromCard(
                    hinText: AppStrings.enterYourEmailOrUser,
                    title: AppStrings.userNameOrEmail,
                    controller: authController.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.enterValidEmailOrUserName; // General error
                      }

                      // Check if input contains "@" to identify email
                      if (value.contains('@')) {
                        // Email validation
                        if (!AppStrings.emailRegexp.hasMatch(value)) {
                          return AppStrings.enterValidEmail; // Invalid email message
                        } else {
                          return null; // Valid email
                        }
                      } else {
                        // Username validation
                        if (value.length < 4) {
                          return 'UserNameToShort'; // "Username must be at least 4 characters"
                        } else {
                          return null; // Valid username
                        }
                      }
                    },
                  ),

                  Gap(12.h),

                  ///========================Password Field=====================
                  CustomFromCard(
                    hinText: AppStrings.enterYourPassword,
                    title: AppStrings.password,
                    controller: authController.passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppStrings.passwordMustHaveEightWith;
                      } else if (value.length < 8 ||
                          !AppStrings.passRegexp.hasMatch(value)) {
                        return AppStrings.passwordLengthAndContain;
                      } else {
                        return null;
                      }
                    },
                  ),

                  //==============================Forget========================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: authController.isRemember.value,
                              checkColor: AppColors.white50,
                              activeColor: AppColors.green500,
                              focusColor: Colors.red,
                              onChanged: (value) {
                                authController.toggleRemember();
                              }),
                          const CustomText(
                            text: 'Remember me',
                            color: AppColors.gray500,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoute.forgotPasswordScreen);
                          },
                          child: const CustomText(
                            color: AppColors.blue500,
                            text: AppStrings.forgotPasswordd,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ],
                  ),

                  ///===========================Sign In Button=================
                  Gap(30.h),
                  authController.isSignInLoading.value
                      ? const CustomLoader()
                      : CustomButton(
                          isRadius: true,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              authController.signInUser();
                            }
                          },
                          title: AppStrings.signIn,
                        ),

                  ///===========================Or=================

                  const CustomText(
                    text: AppStrings.or,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    bottom: 10,
                    top: 10,
                  ),

                  ///======================= Google Auth=====================
                  GestureDetector(
                    onTap: () {
                      if (kDebugMode) {
                        print('tap');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppColors.white50,
                          border: Border.all(color: AppColors.grey400),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.googleSignIn.svg(),
                          const CustomText(
                            left: 10,
                            text: AppStrings.signInGoogle,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.gray500,
                          )
                        ],
                      ),
                    ),
                  ),
                  Gap(15.h),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: AppStrings.dontHaveAnAccount,
                            style: TextStyle(
                              color: AppColors.green500,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: AppStrings.signUp,
                            style: const TextStyle(
                              color: AppColors.blue500,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoute.signUpScreen);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

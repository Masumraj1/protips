import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/global/controllers/auth_controller/auth_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================Sign Up Appbar===================
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: AppStrings.signUp,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: SingleChildScrollView(
            child: Obx(() {
              return Form(
                key: formKey,
                child: Column(
                  children: [
                    const CustomText(
                      text: AppStrings.hello,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: AppColors.blue500,
                      bottom: 10,
                    ),

                    const CustomText(
                      text: AppStrings.welcomeToProtippz,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppColors.green500,
                      bottom: 40,
                      maxLines: 3,
                    ),

                    //========================Full Name Field=====================
                    CustomFromCard(
                      hinText: AppStrings.enterYourFullName,
                      title: AppStrings.fullName,
                      controller: authController.nameController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        } else if (value.length < 4) {
                          return AppStrings.enterAValidName;
                        }
                        return null;
                      },
                    ),
                    Gap(12.h),
                    //========================Email Field=====================
                    CustomFromCard(
                      hinText: AppStrings.enterYourEmail,
                      title: AppStrings.email,
                      controller: authController.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.enterValidEmail;
                        } else if (!AppStrings.emailRegexp
                            .hasMatch(authController.emailController.text)) {
                          return AppStrings.enterValidEmail;
                        } else {
                          return null;
                        }
                      },
                    ),

                    Gap(12.h),
                    //========================Phone Number Field=====================
                    CustomFromCard(
                        hinText: AppStrings.enterYourPhoneNumber,
                        title: AppStrings.phoneNumber,
                        controller: authController.phoneNumberController,
                        validator: (v) {}),
                    Gap(12.h),
                    //========================User Name Field=====================
                    CustomFromCard(
                      hinText: AppStrings.enterYourUserName,
                      title: "User Name",
                      controller: authController.userNameController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        } else if (value.length < 4) {
                          return AppStrings.enterValidUserName;
                        }
                        return null;
                      },
                    ),
                    Gap(12.h),
                    //========================Address  Field=====================
                    CustomFromCard(
                      hinText: AppStrings.enterYourAddress,
                      title: AppStrings.address,
                      controller: authController.addressController,
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        } else if (value.length < 4) {
                          return AppStrings.enterAValidName;
                        }
                        return null;
                      },
                    ),
                    Gap(12.h),
                    //========================Password Field=====================
                    CustomFromCard(
                      isPassword: true,
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
                    Gap(12.h),
                    //========================Confirm Password Field=====================
                    CustomFromCard(                                                                                                                                   
                      isPassword: true,
                      hinText: AppStrings.enterYourPassword,
                      title: AppStrings.confirmPassword,
                      controller: authController.confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        } else if (value !=
                            authController.passwordController.text) {
                          return "Password should match";
                        }
                        return null;
                      },
                    ),

                    Gap(12.h),
                    //========================Confirm Password Field=====================
                    CustomFromCard(
                      hinText: "Enter Your Referral Code here....",
                      title: "Referral Code (Optional)",
                      controller: authController.referralController,
                      validator: (v) {},
                    ),

                    //===========================Sign Up Button=================
                    Gap(30.h),
                    authController.isSignUpLoading.value
                        ? const CustomLoader()
                        : CustomButton(
                            isRadius: true,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                authController.signUp();
                              }
                            },
                            title: AppStrings.signUp,
                          ),

                    Gap(10.h),

                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: AppStrings.alreadyHaveAnAccount,
                              style: TextStyle(
                                color: AppColors.green500,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: AppStrings.signIn,
                              style: const TextStyle(
                                color: AppColors.blue500,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(AppRoute.signInScreen);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          )),
    );
  }
}

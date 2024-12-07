import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/controllers/auth_controller/auth_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_card/custom_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///=========================Setting========================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.settings,
        iconData: Icons.arrow_back_outlined,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            ///=========================Change Password===================
            CustomCard(
                title: AppStrings.changePassword,
                icon: Assets.icons.key.svg(),
                onTap: () {
                  Get.toNamed(AppRoute.changePasswordScreen);
                }),
            Gap(15.h),

            ///=========================Delete Account===================
            CustomCard(
                title: AppStrings.deleteAccount,
                icon: Assets.icons.delete.svg(),
                onTap: () {
                  showDialogBox(context);
                }),
          ],
        ),
      ),
    );
  }

  ///========================= ===========Delete Account=============================
  void showDialogBox(BuildContext context) {
    Get.dialog(
      AlertDialog(
          backgroundColor: AppColors.white50,
          content: Form(
            key: formKey,
            child: Obx(
            () {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Assets.icons.closeSmall.svg())
                      ],
                    ),

                    ///==========================Delete Account===============
                    CustomText(
                      left: 50,
                      fontSize: 20.sp,
                      text: AppStrings.deleteAccount,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray500,
                      bottom: 10,
                    ),
                    CustomText(
                      textAlign: TextAlign.center,
                      text: AppStrings.areYouSureWant,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gray500,
                      fontSize: 14.sp,
                      maxLines: 2,
                    ),
                    CustomText(
                      top: 16,
                      text: AppStrings.password,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: AppColors.gray500,
                      bottom: 16,
                    ),

                    ///======================================Password Field==================
                    CustomTextField(
                      isColor: true,
                      textEditingController: _authController.passwordController,
                      hintText: AppStrings.enterYourPassword,
                      hintStyle: const TextStyle(color: AppColors.gray500),
                      isPassword: true,
                      fillColor: AppColors.bg500,
                      inputTextStyle: const TextStyle(color: AppColors.gray500),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppStrings.fieldCantBeEmpty;
                        } else if (value.length < 8 ||
                            !AppStrings.passRegexp.hasMatch(value)) {
                          return AppStrings.passwordLengthAndContain;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    _authController.isDeleteLoading.value
                        ? const CustomLoader()
                        : CustomButton(
                            fillColor: AppColors.blue500,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                _authController.deleteAccount();
                              }
                            },
                            title: AppStrings.confirm,
                          ),
                    SizedBox(
                      width: 8.w,
                    )
                  ],
                );
              }
            ),
          )),
    );
  }
}

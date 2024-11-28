import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_strings.dart';

class ShirtFormDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final HomeController homeController;

  const ShirtFormDialog({
    Key? key,
    required this.formKey,
    required this.homeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white50,
      content: SingleChildScrollView(
        child: Obx(() {
          return Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.back(); // Close the dialog
                      },
                      child: const Icon(
                        Icons.close,
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),

                // Header text
                const CustomText(
                  left: 20,
                  fontSize: 16,
                  maxLines: 2,
                  text: "Verify Name and Mailing Address",
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray500,
                  bottom: 10,
                ),

                // Full Name Input
                CustomFromCard(
                  hinText: AppStrings.enterYourFullName,
                  isBgColor: true,
                  title: AppStrings.fullName,
                  controller: homeController.fullNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.fieldCantBeEmpty;
                    } else if (value.length < 4) {
                      return AppStrings.enterAValidName;
                    }
                    return null;
                  },
                ),

                // Mailing Address
                const CustomText(
                  textAlign: TextAlign.start,
                  fontSize: 16,
                  text: AppStrings.mailingAddress,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray500,
                  bottom: 18,
                  top: 18,
                ),

                // Street Address
                CustomFromCard(
                  hinText: AppStrings.typeHere,
                  isBgColor: true,
                  title: AppStrings.streetAddress,
                  controller: homeController.streetController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.fieldCantBeEmpty;
                    }
                    return null;
                  },
                ),

                Gap(10.h),

                // Phone Number
                CustomFromCard(
                  hinText: AppStrings.typeHere,
                  isBgColor: true,
                  title: AppStrings.phoneNumber,
                  controller: homeController.phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.fieldCantBeEmpty;
                    }
                    return null;
                  },
                ),

                Gap(10.h),

                // City
                CustomFromCard(
                  hinText: AppStrings.typeHere,
                  isBgColor: true,
                  title: AppStrings.city,
                  controller: homeController.cityController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.fieldCantBeEmpty;
                    }
                    return null;
                  },
                ),

                Gap(10.h),

                // State
                CustomFromCard(
                  hinText: AppStrings.typeHere,
                  isBgColor: true,
                  title: AppStrings.state,
                  controller: homeController.stateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.fieldCantBeEmpty;
                    }
                    return null;
                  },
                ),

                Gap(10.h),

                // ZipCode
                CustomFromCard(
                  hinText: AppStrings.typeHere,
                  isBgColor: true,
                  title: AppStrings.zipCode,
                  controller: homeController.zipCodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.fieldCantBeEmpty;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20.h),

                // Submit Button or Loader
                homeController.isSubmit.value
                    ? const CustomLoader()
                    : CustomButton(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      homeController.redeemCreate(
                        rewardId: homeController.selectRewardList[0].id ?? "",
                        categoryId: homeController.selectRewardList[0].category?.id ?? "",
                      );
                    }
                  },
                  title: AppStrings.submit,
                  fillColor: AppColors.blue500,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

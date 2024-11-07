import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:protippz/app/controller/profile_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: "Edit Profile",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            ///================== Edit Image==================
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: () {
                    profileController.selectImage();
                  },
                  child: profileController.image.isNotEmpty
                      ? Container(
                          height: 94.h,
                          width: 94.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(
                                File(profileController.image.value),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            CustomNetworkImage(
                              boxShape: BoxShape.circle,
                              imageUrl: AppConstants.profileImage,
                              // imageUrl: (profileController
                              //     .profileModel.value.profileImage
                              //     ?.startsWith('https') ??
                              //     false)
                              //     ? profileController.profileModel.value
                              //     .profileImage ??
                              //     ""
                              //     : "${ApiUrl.baseUrl}${profileController.profileModel.value?.profileImage ?? ""}",
                              height: 94.h,
                              width: 94.w,
                            ),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                    height: 30.h,
                                    width: 30.w,
                                    decoration: const BoxDecoration(
                                        color: AppColors.green500,
                                        shape: BoxShape.circle),
                                    child: Assets.icons.photoCamera.svg()))
                          ],
                        )),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///==============================Full Name =====================
                CustomFromCard(
                    title: AppStrings.fullName,
                    controller: profileController.fullNameController,
                    validator: (v) {}),
                Gap(12.h),

                ///==============================Email = =====================
                CustomFromCard(
                    title: AppStrings.email,
                    controller: profileController.emailController,
                    validator: (v) {}),

                Gap(12.h),

                ///==============================Phone Number =====================
                CustomFromCard(
                    title: AppStrings.phoneNumber,
                    controller: profileController.phoneNumberController,
                    validator: (v) {}),
                Gap(12.h),

                ///==============================UserName = =====================
                CustomFromCard(
                    title: AppStrings.userName,
                    controller: profileController.userNameController,
                    validator: (v) {}),
                Gap(12.h),

                ///==============================Address = =====================
                CustomFromCard(
                    title: AppStrings.address,
                    controller: profileController.addressController,
                    validator: (v) {}),
                Gap(25.h),
                CustomButton(
                  onTap: () {
                    context.pop();
                  },
                  title: "Save",
                )
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}

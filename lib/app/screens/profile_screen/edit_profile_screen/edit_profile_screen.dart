import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protippz/app/controller/profile_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_image/custom_image.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

import '../../../data/services/app_url.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController profileController = Get.find<ProfileController>();
  String? image;

  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (getImages != null) {
      image = getImages.path;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///========================Edit Profile==================
      appBar: const CustomAppBar(
        iconData: Icons.arrow_back_outlined,
        appBarContent: AppStrings.editProfile,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
            child: Column(
          children: [
            ///================== Edit Image==================

            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectImage();
                    });
                  },
                  child: image != null
                      ? Container(
                          height: 94.h,
                          width: 94.w,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(
                                  File(image!),
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle),
                        )
                      : Stack(
                          children: [
                            CustomNetworkImage(
                                boxShape: BoxShape.circle,
                                imageUrl: profileController.profileModel.value
                                                .profileImage !=
                                            null &&
                                        profileController.profileModel.value
                                            .profileImage!.isNotEmpty
                                    ? AppConstants.profileImage
                                    : "${ApiUrl.baseUrl}${profileController.networkImg}",
                                height: 94.w,
                                width: 94.w),
                            Positioned(
                                right: 0,
                                bottom: 0,
                                child: Assets.icons.photoCamera
                                    .svg(color: AppColors.green500))
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
                // Gap(12.h),
                //
                // ///==============================Email = =====================
                // CustomFromCard(
                //     title: AppStrings.email,
                //     controller: profileController.emailController,
                //     validator: (v) {}),

                Gap(12.h),

                ///==============================Phone Number =====================
                CustomFromCard(
                    title: AppStrings.phoneNumber,
                    controller: profileController.phoneNumberController,
                    validator: (v) {}),
                Gap(12.h),

                // ///==============================UserName = =====================
                // CustomFromCard(
                //     title: AppStrings.userNam,
                //     controller: profileController.userNameController,
                //     validator: (v) {}),
                Gap(12.h),

                ///==============================Address = =====================
                CustomFromCard(
                    title: AppStrings.address,
                    controller: profileController.addressController,
                    validator: (v) {}),
                Gap(25.h),

                ///=================Save=================

                profileController.updateProfileLoding
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        onTap: () {
                          setState(() {
                            profileController.multipartRequest(
                                imagePath: image);
                          });
                        },
                        title: AppStrings.save,
                      )
              ],
            )
          ],
        )),
      ),
    );
    ;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/profile_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';

import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/screens/profile_screen/inner_widget/profile_details_row.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});


  final ProfileController profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      bottomNavigationBar:  const NavBar(currentIndex: 4,),
      ///===========================Profile Appbar================
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed(AppRoute.editProfileScreen);
            },
            child: Container(
              padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: AppColors.green50,
                  shape: BoxShape.circle
                ),
                child: Assets.icons.edit.svg())
          ),
          const SizedBox(width: 25),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
          color: AppColors.green500,
        ),
        backgroundColor: AppColors.white50,
        title: CustomText(
          text: AppStrings.profile,
          color: AppColors.gray500,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body:Obx(() {
        var data = profileController.profileModel.value;
        switch (profileController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(
                onTap: () {
              profileController.getProfile();
            });

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                profileController.getProfile(); // Retry fetching data on error
              },
            );

          case Status.completed:
            return
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              CustomNetworkImage(
                boxShape: BoxShape.circle,
                imageUrl: data.profileImage != null && data.profileImage!.isNotEmpty
                    ? '${ApiUrl.netWorkUrl}${data.profileImage}'
                    : AppConstants.profileImage,
                height: 94.h,
                width: 94.h,
              ),


              ///=========================Name===============
               CustomText(
                text: data.name??"",
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.gray500,
                top: 12,
                bottom: 5,
              ),

              ///======================Email==================
               CustomText(
                text: data.email??"",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.gray500,
                bottom: 35,
              ),
              Column(
                children: [
                  ///=============================User Name===============
                   ProfileDetailRow(
                    label: AppStrings.userName,
                    value: data.username??"",
                  ),
                  Gap(20.h),

                  ///===================Phone Number==============
                   ProfileDetailRow(
                    label: AppStrings.phoneNumbers,
                    value: data.phone??"",
                  ),

                  Gap(20.h),
                  ///===================address==============

                   ProfileDetailRow(
                    label: AppStrings.address,
                    value: data.address??"",
                  ),

                  Gap(20.h),
                  ///===================Tip==============

                   ProfileDetailRow(
                    label: 'totalPoint',
                    value: data.totalPoint.toString(),
                  ),
                ],
              ),
            ],
          ),
        );

        }
      })


    );
  }
}



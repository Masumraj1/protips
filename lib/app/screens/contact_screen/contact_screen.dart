import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/global/controllers/genarel_controller/genarel_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class ContactScreen extends StatelessWidget {
   ContactScreen({super.key});


  final GeneralController generalController =Get.find<GeneralController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      ///============================Contact up Appbar==================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.contactUs,
        iconData: Icons.arrow_back_outlined,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Obx(
          () {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ///=========================Name=================
                  CustomFromCard(
                      title: AppStrings.name,
                      hinText: AppStrings.enterYourFullName,
                      controller: generalController.nameController,
                      validator: (v) {}),
                  Gap(12.h),
                  ///=========================Email=================
                  CustomFromCard(
                      title: AppStrings.email,
                      hinText: AppStrings.enterYourEmail,
                      controller: generalController.emailController,
                      validator: (v) {}),
                  Gap(12.h),
                  ///=========================Phone Number=================
                  CustomFromCard(
                      title: AppStrings.phoneNumber,
                      hinText: AppStrings.enterYourPhoneNumber,
                      controller: generalController.phoneController,
                      validator: (v) {}),
                  Gap(12.h),
                  ///=========================Message=================
                  CustomFromCard(
                      maxLine: 5,
                      title: AppStrings.message,
                      hinText: AppStrings.typeHere,
                      controller: generalController.messageController,
                      validator: (v) {}),
                  Gap(25.h),
                  ///=========================Submit=================


                   generalController.isContactLoading.value?const CustomLoader():
                  CustomButton(
                    onTap: () {
                     generalController.contactUs();
                    },
                    title: AppStrings.submit,
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

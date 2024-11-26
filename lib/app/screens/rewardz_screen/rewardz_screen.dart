import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_rewadz_card/custom_rewadz_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class RewardzScreen extends StatelessWidget {
   RewardzScreen({super.key});


  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///===========================Reward appbar======================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.rewardz,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            ///=========================Rewardz list======================
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(homeController.rewardList.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CustomNetworkImage(
                            imageUrl: "${ApiUrl.netWorkUrl}${homeController.rewardList[index].image ?? ""}",
                            height: 72,
                            width: 72),
                         CustomText(
                          top: 10,
                          text:homeController.rewardList[index].name??"",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.gray500,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Gap(24.h),

            ///=========================Search =====================
            const CustomTextField(
              hintText: AppStrings.searchReward,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.gray500,
              ),
              fillColor: AppColors.white50,
              fieldBorderColor: AppColors.grey400,
            ),
            Gap(14.h),

            Gap(14.h),
            Expanded(
              child: GridView.builder(
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return CustomRewadzCard(
                    isVisible: true,
                    buttonTitle: "Redeem",
                    imageUrl: AppConstants.shirt,
                    name: 'Signed Memorabilia ',
                    team: 'Manchester City',
                    position: 'Quarterback',
                    isTeam: true,
                    isPosition: true,
                    onTap: () {
                      showDialogBox(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDialogBox(BuildContext context) {
    Get.dialog(
      AlertDialog(
          backgroundColor: AppColors.white50,
          content: Column(
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
              const CustomText(
                left: 50,
                fontSize: 16,
                text: AppStrings.howTOReceive,
                fontWeight: FontWeight.w500,
                color: AppColors.gray500,
                bottom: 10,
              ),
              const CustomText(
                textAlign: TextAlign.start,
                text: AppStrings.veryFyYourEmailAddress,
                fontWeight: FontWeight.w400,
                color: AppColors.gray500,
                fontSize: 14,
                maxLines: 10,
              ),
              const CustomText(
                textAlign: TextAlign.start,
                top: 16,
                text: AppStrings.veryFyYourNameAndMailing,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.gray500,
                bottom: 16,
                maxLines: 10,
              ),
              const CustomText(
                textAlign: TextAlign.start,
                top: 16,
                text: AppStrings.confirmationOnce,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.gray500,
                bottom: 16,
                maxLines: 10,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                onTap: () {
                  Get.back();
                  whenShirtDialog(context);
                },
                title: AppStrings.continues,
                fillColor: AppColors.blue500,
              )
            ],
          )),
    );
  }

  // void showVerify(BuildContext context) {
  void whenShirtDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
          backgroundColor: AppColors.white50,
          content: Column(
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
              const CustomText(
                left: 20,
                fontSize: 16,
                maxLines: 2,
                text: "Verify Name and Mailing Address",
                fontWeight: FontWeight.w500,
                color: AppColors.gray500,
                bottom: 10,
              ),
              CustomFromCard(
                  hinText: AppStrings.enterYourFullName,
                  isBgColor: true,
                  title: AppStrings.fullName,
                  controller: TextEditingController(),
                  validator: (v) {}),
              const CustomText(
                textAlign: TextAlign.start,
                fontSize: 16,
                text: AppStrings.mailingAddress,
                fontWeight: FontWeight.w400,
                color: AppColors.gray500,
                bottom: 18,
                top: 18,
              ),
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  isBgColor: true,
                  title: AppStrings.streetAddress,
                  controller: TextEditingController(),
                  validator: (v) {}),
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  isBgColor: true,
                  title: AppStrings.city,
                  controller: TextEditingController(),
                  validator: (v) {}),
              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  isBgColor: true,
                  title: AppStrings.state,
                  controller: TextEditingController(),
                  validator: (v) {}),

              CustomFromCard(
                  hinText: AppStrings.typeHere,
                  isBgColor: true,
                  title: AppStrings.zipCode,
                  controller: TextEditingController(),
                  validator: (v) {}),
              SizedBox(
                height: 20.h,
              ),

              CustomButton(
                onTap: () {
                  Get.back();
                },
                title: AppStrings.submit,
                fillColor: AppColors.blue500,
              )
            ],
          )),
    );
  }
}

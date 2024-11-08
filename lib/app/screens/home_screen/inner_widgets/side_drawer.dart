import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_menu_card/custom_menu_card.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';


class SideDrawer extends StatelessWidget {
  SideDrawer({super.key});


  final HomeController homeController =
  Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(

        children: [
          Container(
            padding: const EdgeInsets.only(top: 35, right: 140, bottom: 5),
            width: MediaQuery.of(context).size.width / 1.3,
            color: AppColors.white50,
            height: 100.h,
            child: Assets.images.logo.image(),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            color: AppColors.bg500,
            width: MediaQuery.of(context).size.width / 1.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///===========================Deposite Fund===================
                CustomMenuCard(
                  onTap: () {
                    Get.toNamed(AppRoute.depositeScreen);

                  },
                  title: AppStrings.depositeFund,
                  icon: Assets.icons.deposite.svg(),
                ),

                ///===========================Withdraw Fund===================
                CustomMenuCard(
                  onTap: () {
                    Get.toNamed(AppRoute.withdrawScreen);

                  },
                  title: AppStrings.withdrawFunds,
                  icon: Assets.icons.withdraw.svg(),
                ),

                 ///===========================transactionLog===================
                CustomMenuCard(
                  onTap: () {
                    Get.toNamed(AppRoute.transactionScreen);

                  },
                  title: AppStrings.transactionLog,
                  icon: Assets.icons.transactionLog.svg(),
                ),

                ///===========================Invite Friend===================
                CustomMenuCard(
                  onTap: () {
                    Get.toNamed(AppRoute.inviteScreen);

                  },
                  title: AppStrings.inviteFriends,
                  icon: Assets.icons.inviteFriends.svg(),
                ),

                ///===========================Faqs===================
                CustomMenuCard(
                  onTap: () {
                    Get.toNamed(AppRoute.faqScreen);

                  },
                  title: AppStrings.faqs,
                  icon: Assets.icons.faqs.svg(),
                ),

                ///===========================Contact us===================
                CustomMenuCard(
                  onTap: () {
                    Get.toNamed(AppRoute.contactScreen);

                  },
                  title: AppStrings.contactUs,
                  icon: Assets.icons.contacts.svg(),
                ),

                ///===========================Terms ===================
                CustomMenuCard(
                  onTap: () {
                    Get.toNamed(AppRoute.termsConditionScreen);

                  },
                  title: AppStrings.termsAndCondition,
                  icon: Assets.icons.terms.svg(),
                ),

                ///===========================Privacy===================
                CustomMenuCard(
                  onTap: () {
                    Get.toNamed(AppRoute.privacyPolicyScreen);

                  },
                  title: AppStrings.privacyPolicy,
                  icon: Assets.icons.privacy.svg(),
                ),

                ///==========================Settings===================
                CustomMenuCard(
                  onTap: () {
                    Get.toNamed(AppRoute.settingScreen);

                  },
                  title: AppStrings.settings,
                  icon: Assets.icons.settings.svg(),
                ),
                
                Gap(50.h),
                ///==========================LogOut===================
                CustomMenuCard(
                  onTap: () {
                    Get.offAllNamed(AppRoute.signInScreen);

                  },
                  title: "Log Out",
                  icon: Assets.icons.logout.svg(),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

}

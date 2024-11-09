import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_menu_card/custom_menu_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class SideDrawer extends StatelessWidget {
  SideDrawer({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.4,
      child: Column(
        children: [
          // Header Container
          Container(
            padding: const EdgeInsets.only(right: 10,left: 50,top: 50,),
            color: AppColors.white50,
            // height: 180.h,

            child: Column(
              children: [
                Assets.images.ptis.image(),
                // Scrollable Row Container
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildStatCard(icon: Assets.icons.dolar, text: '1500'),
                      _buildStatCard(icon: Assets.icons.star, text: '1200'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Main Menu
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              color: AppColors.bg500,
              child: ListView(
                children: [
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.depositeScreen),
                    title: AppStrings.depositeFund,
                    icon: Assets.icons.deposite.svg(),
                  ),
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.withdrawScreen),
                    title: AppStrings.withdrawFunds,
                    icon: Assets.icons.withdraw.svg(),
                  ),
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.transactionScreen),
                    title: AppStrings.transactionLog,
                    icon: Assets.icons.transactionLog.svg(),
                  ),
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.inviteScreen),
                    title: AppStrings.inviteFriends,
                    icon: Assets.icons.inviteFriends.svg(),
                  ),
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.faqScreen),
                    title: AppStrings.faqs,
                    icon: Assets.icons.faqs.svg(),
                  ),
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.contactScreen),
                    title: AppStrings.contactUs,
                    icon: Assets.icons.contacts.svg(),
                  ),
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.termsConditionScreen),
                    title: AppStrings.termsAndCondition,
                    icon: Assets.icons.terms.svg(),
                  ),
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.privacyPolicyScreen),
                    title: AppStrings.privacyPolicy,
                    icon: Assets.icons.privacy.svg(),
                  ),
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.settingScreen),
                    title: AppStrings.settings,
                    icon: Assets.icons.settings.svg(),
                  ),
                  Gap(50.h),
                  CustomMenuCard(
                    onTap: () => Get.offAllNamed(AppRoute.signInScreen),
                    title: "Log Out",
                    icon: Assets.icons.logout.svg(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create stat cards
  Widget _buildStatCard({required SvgGenImage icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.green100,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 25,
                width: 25,
                decoration: const BoxDecoration(
                  color: AppColors.green500,
                  shape: BoxShape.circle,
                ),
                child: icon.svg(),
              ),
            ),
             CustomText(
              left: 10,
              right: 15,
              text: text,
              color: AppColors.blue500,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

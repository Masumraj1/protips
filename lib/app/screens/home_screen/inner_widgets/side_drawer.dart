import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/controller/profile_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/global/widgets/custom_menu_card/custom_menu_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/parmission_button/parmission_button.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final HomeController homeController = Get.find<HomeController>();
  final ProfileController _profileController = Get.find<ProfileController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.3,
      child: Column(
        children: [
          // Header Container
          Container(
            padding: const EdgeInsets.only(
              right: 10,
              top: 30,
            ),
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
                      _buildStatCard(
                          icon: Assets.icons.dolar,
                          text: _profileController
                              .profileModel.value.totalAmount
                              .toString()),
                      _buildStatCard(
                          icon: Assets.icons.star,
                          text: _profileController.profileModel.value.totalPoint
                              .toString()),
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
                  ///=======================Deposit screen==================
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.depositeScreen),
                    title: AppStrings.depositeFund,
                    icon: Assets.icons.deposite.svg(),
                    isDevider: true,
                  ),

                  ///=======================Withdraw==================
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.withdrawScreen),
                    title: AppStrings.withdrawFunds,
                    icon: Assets.icons.withdraw.svg(),
                    isDevider: true,
                  ),

                  ///=======================Transaction==================
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.transactionScreen),
                    title: AppStrings.transactionLog,
                    icon: Assets.icons.transactionLog.svg(),
                    isDevider: true,
                  ),

                  ///=======================Invite==================
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.inviteScreen),
                    title: AppStrings.inviteFriends,
                    icon: Assets.icons.inviteFriends.svg(),
                    isDevider: true,
                  ),

                  ///=======================Faq==================
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.faqScreen),
                    title: AppStrings.faqs,
                    icon: Assets.icons.faqs.svg(),
                    isDevider: true,
                  ),

                  ///=======================Contact==================
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.contactScreen),
                    title: AppStrings.contactUs,
                    icon: Assets.icons.contacts.svg(),
                    isDevider: true,
                  ),

                  ///=======================Terms==================
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.termsConditionScreen),
                    title: AppStrings.termsAndCondition,
                    icon: Assets.icons.terms.svg(),
                    isDevider: true,
                  ),

                  ///=======================Privacy==================
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.privacyPolicyScreen),
                    title: AppStrings.privacyPolicy,
                    icon: Assets.icons.privacy.svg(),
                    isDevider: true,
                  ),

                  ///=======================setting==================
                  CustomMenuCard(
                    onTap: () => Get.toNamed(AppRoute.settingScreen),
                    title: AppStrings.settings,
                    icon: Assets.icons.settings.svg(),
                    isDevider: true,
                  ),
                  Gap(50.h),

                  ///=======================logout==================
                  CustomMenuCard(
                    onTap: () {
                      permissionPopUp(
                          title: 'Are you sure you want to log out',
                          context: context,
                          ontapNo: () {
                            Get.back();
                          },
                          ontapYes: () async {
                            await SharePrefsHelper.remove(
                                AppConstants.bearerToken);
                            await SharePrefsHelper.remove(
                                AppConstants.profileID);

                            print(
                                'remove token========================"${AppConstants.bearerToken}"');
                            print(
                                'remove profileId========================"${AppConstants.profileID}"');

                            Get.offAllNamed(AppRoute.signInScreen);
                          });
                    },
                    title: AppStrings.logout,
                    icon: Assets.icons.logout.svg(),
                    isDevider: false,
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
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
      child: Container(
        height: 25.h,
        decoration: const BoxDecoration(
          color: AppColors.green50,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: 25,
              width: 25,
              decoration: const BoxDecoration(
                color: AppColors.green100,
                shape: BoxShape.circle,
              ),
              child: icon.svg(height: 15, width: 9),
            ),
            CustomText(
              left: 10,
              right: 30,
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

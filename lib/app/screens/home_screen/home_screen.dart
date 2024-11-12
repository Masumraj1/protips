import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';
import 'package:protippz/app/screens/home_screen/inner_widgets/home_app_bar.dart';
import 'package:protippz/app/screens/home_screen/inner_widgets/side_drawer.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

import 'inner_widgets/tipping_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      key: scaffoldKey,
      drawer: SideDrawer(),
      bottomNavigationBar: const NavBar(currentIndex: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///=====================Appbar==================
            HomeAppBar(
              scaffoldKey: scaffoldKey,
              name: 'Ronald Richards', image: AppConstants.profileImage,
            ),
            SizedBox(height: 10.w),

            ///======================Tip======================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TippingCard(
                onTap: () {
                  Get.toNamed(AppRoute.tipzScreen);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(AppStrings.tippzNow),
                  _buildTippzNowSection(),
                  _buildRewardzHeader(() {
                    Get.toNamed(AppRoute.rewardzScreen);
                  }),
                  _buildHorizontalScrollableItems(AppConstants.reward),
                  _buildSectionTitle("Top Sports League"),
                  _buildHorizontalScrollableItems(AppConstants.nba),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return CustomText(
      top: 24,
      text: title,
      color: AppColors.gray500,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      bottom: 12,
    );
  }

  Widget _buildTippzNowSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(2, (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GestureDetector(
              onTap: () {
                index == 0
                    ? Get.toNamed(AppRoute.playerzScreen)
                    : Get.toNamed(AppRoute.teamzScreen);
              },
              child: Column(
                children: [
                  index == 0 ? Assets.images.player.image() :Assets.images.team.image(),
                  CustomText(
                    top: 10,
                    text: index == 0 ? AppStrings.playerz : AppStrings.teamz,
                    color: AppColors.gray500,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRewardzHeader(VoidCallback onTap) {
    return Row(
      children: [
        CustomText(
          top: 24,
          text: AppStrings.rewardz,
          color: AppColors.gray500,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          bottom: 12,
        ),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: CustomText(
            top: 24,
            text: AppStrings.viewAll,
            color: AppColors.blue500,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            bottom: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalScrollableItems(String imageUrl) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(9, (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                CustomNetworkImage(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  imageUrl: imageUrl,
                  height: 105,
                  width: 105,
                ),
                const CustomText(
                  top: 10,
                  text: 'golden ball',
                  color: AppColors.gray500,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/controller/profile_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/controllers/genarel_controller/genarel_controller.dart';
import 'package:protippz/app/global/widgets/custom_image_card/custom_image_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';
import 'package:protippz/app/screens/home_screen/inner_widgets/home_app_bar.dart';
import 'package:protippz/app/screens/home_screen/inner_widgets/side_drawer.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

import 'inner_widgets/tipping_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find<HomeController>();

  final GeneralController _generalController = Get.find<GeneralController>();
  final ProfileController _profileController = Get.find<ProfileController>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.getProfile();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      key: scaffoldKey,

      ///==========================Side Drawer===================
      drawer: SideDrawer(),
      bottomNavigationBar: const NavBar(currentIndex: 0),
      body: Obx(
    () {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=====================Home Appbar==================
                HomeAppBar(
                  scaffoldKey: scaffoldKey,
                  name: _profileController.profileModel.value.name ?? "",
                  image: _profileController.profileModel.value.profileImage != null && _profileController.profileModel.value.profileImage!.isNotEmpty
                      ? "${ApiUrl.netWorkUrl}${_profileController.profileModel.value.profileImage}"
                      : AppConstants.profileImage, // Use your default image here (local asset or network image)
                ),

                SizedBox(height: 10.w),

                ///======================Tip Information======================
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
                      ///=============================Tippz now =====================
                      _buildSectionTitle(AppStrings.tippzNow),
                      _buildTippzNowSection(),

                      ///============================= Reward======================
                      _buildRewardzHeader(() {
                        Get.toNamed(AppRoute.rewardzScreen);
                      }),
                      Obx(() {
                        return  homeController.rewardList.isEmpty
                            ? const Center(
                              child: CustomText(
                                                    text: "No Reward Founded",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.gray500,
                                                  ),
                            )
                            : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                homeController.rewardList.length, (index) {
                              return CustomImageCard(
                                  imageUrl:
                                      "${ApiUrl.netWorkUrl}${homeController.rewardList[index].image ?? ""}",
                                  title:
                                      homeController.rewardList[index].name ?? "");
                            }),
                          ),
                        );
                      }),

                      ///=========================Top Sports League==================
                      _buildSectionTitle(AppStrings.topSportsLeague),
                      Obx(() {
                        return _generalController.leagueList.isEmpty
                            ? const Center(
                              child: CustomText(
                                  text: "No League Founded",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.gray500,
                                ),
                            )
                            : SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      _generalController.leagueList.length, (index) {
                                    return CustomImageCard(
                                        imageUrl:
                                            "${ApiUrl.netWorkUrl}${_generalController.leagueList[index].leagueImage ?? ""}",
                                        title:
                                        _generalController.leagueList[index].name ??
                                                "");
                                  }),
                                ),
                              );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

//==================title======================
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

  //=========================Tip Now======================
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
                  index == 0
                      ? Assets.images.player.image()
                      : Assets.images.team.image(),
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

  //=================View All================
  Widget _buildRewardzHeader(VoidCallback onTap) {
    return Row(
      children: [
        const CustomText(
          top: 24,
          text: AppStrings.rewardz,
          color: AppColors.gray500,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          bottom: 12,
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: const CustomText(
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
}

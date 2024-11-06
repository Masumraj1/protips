import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/screens/favorite_screen/favorite_screen.dart';
import 'package:protippz/app/screens/home_screen/home_screen.dart';
import 'package:protippz/app/screens/notification_screen/notification_screen.dart';
import 'package:protippz/app/screens/profile_screen/profile_screen.dart';
import 'package:protippz/app/screens/tippz_history_screen/tippz_history_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;

  const NavBar({required this.currentIndex, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int bottomNavIndex;

  final List<Widget> unselectedIcon = [
    Assets.icons.homeUnselected.svg(),
    Assets.icons.notificationUnselected.svg(),
    Assets.icons.favoriteUnselected.svg(),
    Assets.icons.historyUnselected.svg(),
    Assets.icons.profileUnselected.svg(),
  ];

  final List<Widget> selectedIcon = [
    Assets.icons.homeSelected.svg(),
    Assets.icons.notificationSelected.svg(),
    Assets.icons.favoriteSelected.svg(),
    Assets.icons.historySelected.svg(),
    Assets.icons.profileSelected.svg(),
  ];

  final List<String> textList = [
    AppStrings.home,
    AppStrings.notification,
    AppStrings.favorites,
    AppStrings.tippzHistory,
    AppStrings.profile,

  ];


  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navBarBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      height: 95.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 13.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          unselectedIcon.length,
          (index) => InkWell(
            onTap: () => onTap(index),
            child: Column(
              children: [
                bottomNavIndex == index
                    ? selectedIcon[index]
                    : unselectedIcon[index],
                CustomText(
                  text: textList[index],
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: bottomNavIndex == index
                      ? AppColors.green500
                      : AppColors.gray300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTap(int index) {
    if (bottomNavIndex == index) return;

    switch (index) {
      case 0:
        Get.offAll(() => const HomeScreen());
        break;
      case 1:
        Get.to(() => const NotificationScreen());
        break;
      case 2:
        Get.to(() => const FavoriteScreen());
        break;
      case 3:
        Get.to(() => const TippzHistoryScreen());
        break;
      case 4:
        Get.to(() => const ProfileScreen());
        break;
    }
    setState(() {
      bottomNavIndex = index;
    });
  }
}

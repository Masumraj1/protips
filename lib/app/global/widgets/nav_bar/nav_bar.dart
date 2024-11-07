import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:protippz/app/core/routes/route_path.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';

import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
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
        context.goNamed(RoutePath.homeScreen);
        break;
      case 1:
        context.goNamed(RoutePath.notificationScreen);
        break;
      case 2:
        context.goNamed(RoutePath.favoriteScreen);
        break;
      case 3:
        context.goNamed(RoutePath.tippzHistoryScreen);
        break;
      case 4:
        context.goNamed(RoutePath.profileScreen);
        break;
    }
    setState(() {
      bottomNavIndex = index;
    });
  }
}

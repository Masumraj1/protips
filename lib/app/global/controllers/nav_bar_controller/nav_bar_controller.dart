import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:protippz/app/core/routes/route_path.dart';

class NavBarController extends GetxController {
  var bottomNavIndex = 0.obs;

  void onTabSelected(int index, BuildContext context) {
    if (bottomNavIndex.value == index) return;

    bottomNavIndex.value = index;

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
  }
}

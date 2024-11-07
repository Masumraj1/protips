import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_image/custom_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
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
                ///===========================Customer care===================
                customRow(
                  onTap: () {
                  },
                  title: AppStrings.depositeFund,
                  icon: Assets.icons.deposite.svg(),
                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget customRow(
      {required String title,
        required Widget icon,
        required VoidCallback onTap}) =>
      GestureDetector(
        onTap: () {
          onTap();
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
               icon,
                CustomText(
                  color: AppColors.gray500,
                  left: 16.w,
                  text: title,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w400,
                ),
              ],
            )),
      );
}

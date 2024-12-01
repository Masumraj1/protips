import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

import 'package:protippz/app/utils/app_strings.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    required this.scaffoldKey, required this.name, required this.image,
  });

  final String name;
  final String image;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.white50,
      margin: EdgeInsets.only(
        top: 32.h,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
      child: Column(
        children: [
          ///====================================Top Section================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ///==================== Profile image =====================
                  CustomNetworkImage(
                      boxShape: BoxShape.circle,
                      imageUrl: image,
                      height: 46,
                      width: 46),

                  SizedBox(
                    width: 16.w,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: AppStrings.hello,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green500,
                        fontSize: 11,
                      ),

                      ///=====================user name =======================
                      CustomText(
                        text: name,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.blue500,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 65.w,
              ),

              ///==========================Drawer button ====================
              GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.green500,
                        shape: BoxShape.circle,
                      ),
                      child: Assets.icons.drawer.svg(
                        colorFilter: const ColorFilter.mode(
                            AppColors.white50, BlendMode.srcIn),
                      )))
            ],
          ),
        ],
      ),
    );
  }
}

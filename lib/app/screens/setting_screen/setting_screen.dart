import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/core/routes/route_path.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_card/custom_card.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: CustomAppBar(
        appBarContent: AppStrings.settings,
        iconData: Icons.arrow_back_outlined,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            CustomCard(
                title: "Change Password",
                icon: Assets.icons.key.svg(),
                onTap: () {
                  context.pushNamed(RoutePath.changePasswordScreen);

                }),
            Gap(15.h),
            CustomCard(
                title: "Delete Account",
                icon: Assets.icons.delete.svg(),
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}

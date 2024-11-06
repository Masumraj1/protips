import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const Gap(121),

            Assets.images.noInternet.image(),


            const CustomText(
              top: 12,
              text: AppStrings.whoops,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.gray500,
              bottom:12 ,
            ), const CustomText(
              text: AppStrings.noInternet,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.gray500,
              maxLines: 2,
            ),
                const Gap(24),
            ///=====================TryAgain Button===================
            CustomButton(
              onTap: () {},
              title: AppStrings.tryAgain,
            )
          ],
        ),
      ),
    );
  }
}

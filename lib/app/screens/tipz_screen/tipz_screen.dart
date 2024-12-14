import 'package:flutter/material.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class TipzScreen extends StatelessWidget {
  const TipzScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: "Tippz",
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDescriptionText(AppStrings.tipYouFavorite, 18),
              _buildTitleText(AppStrings.chooseAPlayer, 18),
              _buildImage(Assets.images.indiana22.image()),
              _buildDescriptionText(AppStrings.selectYourFavorite, 18, top: 10),
              _buildTitleText(AppStrings.sendThem, 18),
              _buildContainerImage(Assets.images.pt.image(), height: 224),
              _buildDescriptionText(AppStrings.afterSelectingYour, 18, top: 10),
              _buildTitleText(AppStrings.earnReward, 18),
              _buildImage(Assets.images.earning.image()),
              _buildDescriptionText(AppStrings.youAreEligibleToEarn, 18, top: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionText(String text, double bottom, {double top = 0}) {
    return CustomText(
      top: top,
      bottom: bottom,
      maxLines: 5,
      textAlign: TextAlign.center,
      text: text,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.gray500,
    );
  }

  Widget _buildTitleText(String text, double bottom) {
    return CustomText(
      bottom: bottom,
      textAlign: TextAlign.start,
      text: text,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.gray500,
    );
  }

  Widget _buildImage(Image image) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: image,
    );
  }

  Widget _buildContainerImage(Image image, {required double height}) {
    return Container(
      width: double.infinity,
      height: height,
      color: AppColors.white50,
      child: image,
    );
  }
}

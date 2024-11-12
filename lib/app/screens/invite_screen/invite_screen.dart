import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class InviteScreen extends StatelessWidget {
  const InviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///=================================Invite Friends=========================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.inviteFriends,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(AppStrings.howItWorks),
            _buildStepSection(
                AppStrings.invite1, AppStrings.useTheInviteFriend),
            _buildStepSection(AppStrings.signUp2,
                AppStrings.whenYourFriends),
            _buildStepSection(AppStrings.earnRewards,
                AppStrings.forEachFriend),
            _buildSectionTitle(AppStrings.readyToGet),
            _buildDescription(
                AppStrings.clickBelow,
                bottomPadding: 24),

            ///============================Invite Friends=====================
            CustomButton(
              borderColor: AppColors.green500,
              fillColor: AppColors.white50,
              textColor: AppColors.green500,
              onTap: () {},
              title: AppStrings.inviteFriends,
            ),
          ],
        ),
      ),
    );
  }















  Widget _buildSectionTitle(String title) {
    return CustomText(
      bottom: 10,
      text: title,
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.gray500,
    );
  }

  Widget _buildStepSection(String stepTitle, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          bottom: 6,
          text: stepTitle,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.gray500,
        ),
        _buildDescription(description),
      ],
    );
  }

  Widget _buildDescription(String text, {double bottomPadding = 12}) {
    return CustomText(
      textAlign: TextAlign.start,
      maxLines: 5,
      bottom: bottomPadding,
      text: text,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.gray500,
    );
  }
}

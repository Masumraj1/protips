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
      appBar: const CustomAppBar(
        appBarContent: AppStrings.inviteFriends,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("How It Works"),
            _buildStepSection("1. Invite",
                "Use the “Invite Friends” button below to share your unique referral link via text, email, or social media."),
            _buildStepSection("2. Sign Up",
                "When your friends sign up using your link, they’ll join the PROTIPPZ community where they can Tippz, win rewards, and participate in exclusive fan events."),
            _buildStepSection("3. Earn Rewards",
                "For each friend who joins, you’ll earn 100 points that you can redeem for special rewards, exclusive gear, or event tickets."),
            _buildSectionTitle("Ready to Get Started?"),
            _buildDescription(
                "Click below to start inviting friends and watch your rewards grow!", bottomPadding: 24),
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

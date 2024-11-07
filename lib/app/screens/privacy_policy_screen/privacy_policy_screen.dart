import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: CustomAppBar(
        appBarContent: AppStrings.privacyPolicy,
        iconData: Icons.arrow_back,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/utils/app_colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: CustomAppBar(
        appBarContent: "Change Password",
        iconData: Icons.arrow_back_outlined,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            CustomFromCard(
              isPassword: true,
                title: "Current Password",
                hinText: "Enter Current password",
                controller: TextEditingController(),
                validator: (v) {}),
            Gap(12.h),
            CustomFromCard(
              isPassword: true,
                title: "New Password",
                hinText: "Enter New Password",
                controller: TextEditingController(),
                validator: (v) {}),

            Gap(12.h),
            CustomFromCard(
                isPassword: true,
                title: "Retype New Password",
                hinText: "Retype New Password",
                controller: TextEditingController(),
                validator: (v) {}),
            Gap(25.h),
            
            CustomButton(onTap: (){
              context.pop();
            },title: "Change Password",)

          ],
        ),
      ),
    );
  }
}

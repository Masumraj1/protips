import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_from_card/custom_from_card.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: CustomAppBar(
        appBarContent: AppStrings.contactUs,
        iconData: Icons.arrow_back_outlined,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            CustomFromCard(
                title: "Name",
                hinText: "Robart",
                controller: TextEditingController(),
                validator: (v) {}),
            Gap(12.h),
            CustomFromCard(
                title: AppStrings.email,
                hinText: "masjl@gmail.com",
                controller: TextEditingController(),
                validator: (v) {}),
            Gap(12.h),
            CustomFromCard(
                title: AppStrings.phoneNumber,
                hinText: "+002465412",
                controller: TextEditingController(),
                validator: (v) {}),
            Gap(12.h),
            CustomFromCard(
                maxLine: 5,
                title: "Message",
                hinText: "",
                controller: TextEditingController(),
                validator: (v) {}),
            Gap(25.h),
            CustomButton(
              onTap: () {
                context.pop();
              },
              title: "Submite",
            )
          ],
        ),
      ),
    );
  }
}

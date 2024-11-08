import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class DepositeScreen extends StatelessWidget {
  const DepositeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.depositFunds,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(text: "Deposite Options",fontWeight: FontWeight.w500,fontSize: 16,bottom: 12,),
            CustomButton(onTap: (){
              Get.toNamed(AppRoute.depositeCardScreen);
            },title: AppStrings.continues,)
          ],
        ),
      ),
    );
  }
}

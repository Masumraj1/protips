import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class EmailVerificationDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSendCode;
  final VoidCallback onClose;
final HomeController homeController = Get.find<HomeController>();
   EmailVerificationDialog({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.onSendCode,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white50,
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close Button Row
            Row(
              children: [
                const SizedBox(),
                const Spacer(),
                GestureDetector(
                    onTap: onClose,
                    child: Assets.icons.closeSmall.svg()) // Close icon
              ],
            ),
            // Title Text
            const CustomText(
              left: 50,
              fontSize: 16,
              text: "Verify Email Address",
              fontWeight: FontWeight.w500,
              color: AppColors.gray500,
              bottom: 10,
            ),
            // Email Label
            const CustomText(
              text: AppStrings.email,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              bottom: 10,
            ),
            // Email Input Field
            CustomTextField(
              inputTextStyle: const TextStyle(color: AppColors.gray500),
              textEditingController: emailController,
              fillColor: AppColors.white600,
              hintText: AppStrings.enterYourEmail,
              validator: (value) {
                if (value!.isEmpty) {
                  return AppStrings.enterValidEmail;
                } else if (!AppStrings.emailRegexp
                    .hasMatch(emailController.text)) {
                  return AppStrings.enterValidEmail;
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 20.h),

            // Reactive Loader or Button
            Obx(() {
              return homeController.isSendCode.value
                  ? const CustomLoader() // Show loader when sending code
                  : CustomButton(
                onTap: onSendCode,
                title: AppStrings.sendCode,
                fillColor: AppColors.blue500,
              );
            }),
          ],
        ),
      ),
    );
  }
}

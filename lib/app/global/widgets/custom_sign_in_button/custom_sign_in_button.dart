import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart'; // Import your CustomText widget
import 'package:protippz/app/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Assuming you are using flutter_svg for icons

class CustomSocialSignInButton extends StatelessWidget {
  final Widget iconPath;  // Path to the icon
  final String text;      // The text to display
  final VoidCallback onTap; // Callback for tap action
  final Color buttonColor; // Button background color
  final Color textColor;   // Text color
  final double borderRadius; // Border radius

  const CustomSocialSignInButton({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
    this.buttonColor = AppColors.white50,
    this.textColor = AppColors.gray500,
    this.borderRadius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: AppColors.grey400),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           iconPath,  // Using the asset for the icon
            const SizedBox(width: 10),
            CustomText(
              left: 10,
              text: text,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/utils/app_colors.dart';

class CustomRichTextLink extends StatelessWidget {
  final String firstText;      // The first text (e.g., "Don't have an account?")
  final String linkText;       // The clickable text (e.g., "Sign Up")
  final String linkRoute;      // The route to navigate on tap
  final Color firstTextColor;  // Color of the first text
  final Color linkTextColor;   // Color of the link text
  final double fontSize;       // Font size for both texts

  const CustomRichTextLink({
    super.key,
    required this.firstText,
    required this.linkText,
    required this.linkRoute,
    this.firstTextColor = AppColors.green500,
    this.linkTextColor = AppColors.blue500,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 2,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: firstText,
              style: TextStyle(
                color: firstTextColor,
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
              ),
            ),
            TextSpan(
              text: linkText,
              style: TextStyle(
                color: linkTextColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(linkRoute);
                },
            ),
          ],
        ),
      ),
    );
  }
}

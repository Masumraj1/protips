import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class ProfileDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetailRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: CustomText(
            textAlign: TextAlign.start,
            text: label,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.gray500,
          ),
        ),
        Expanded(
          flex: 6,
          child: CustomText(
            textAlign: TextAlign.start,
            text: value,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            maxLines: 3,
            color: AppColors.gray500,
          ),
        ),
      ],
    );
  }
}
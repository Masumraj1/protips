import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class CustomImageCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CustomImageCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          CustomNetworkImage(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            imageUrl: imageUrl,
            height: 105,
            width: 105,
          ),
          CustomText(
            top: 10,
            text: title,
            color: AppColors.gray500,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class CustomHorizontalCard extends StatelessWidget {
  const CustomHorizontalCard(
      {super.key, required this.image, required this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  CustomNetworkImage(
                    imageUrl: image,
                    height: 72,
                    width: 72,
                  ),
                  CustomText(
                    top: 10,
                    text: title,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppColors.gray500,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

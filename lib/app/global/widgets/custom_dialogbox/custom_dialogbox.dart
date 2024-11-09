import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class CustomDialogBox extends StatefulWidget {
  final String title;
  final String team;
  final String position;
  final VoidCallback onTap;

  const CustomDialogBox({
    super.key,
    required this.title,
    required this.team,
    required this.position,
    required this.onTap,
  });

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  int? _selectedValue;
  final List<int> amountOptions = [5, 25, 100];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: AppColors.green500),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  CustomNetworkImage(
                      imageUrl: AppConstants.profileImage, height: 120, width: 116),
                  CustomText(
                    text: widget.title,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blue500,
                    fontSize: 16,
                    top: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Team: ",
                        fontWeight: FontWeight.w500,
                        color: AppColors.green500,
                        fontSize: 14,
                        top: 10,
                      ),
                      CustomText(
                        text: widget.team,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue500,
                        fontSize: 14,
                        top: 10,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: "Position:",
                        fontWeight: FontWeight.w500,
                        color: AppColors.green500,
                        fontSize: 14,
                        top: 10,
                      ),
                      CustomText(
                        text: widget.position,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue500,
                        fontSize: 14,
                        top: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const CustomText(
              text: "Select Your Amount",
              fontWeight: FontWeight.w400,
              color: AppColors.gray500,
              fontSize: 14,
              top: 20,
            ),
            Column(
              children: amountOptions.map((amount) {
                return RadioListTile<int>(
                  value: amount,
                  groupValue: _selectedValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  },
                  activeColor: Colors.teal,
                  title: Text(
                    '\$$amount',
                    style: const TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: "Enter Amount",
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: widget.onTap,
              title: AppStrings.sendTippz,
              fillColor: AppColors.blue500,
            ),
          ],
        ),
      ),
    );
  }
}

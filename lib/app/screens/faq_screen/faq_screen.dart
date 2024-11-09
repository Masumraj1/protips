import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/info_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  // Track the currently open item
  int? _selectedIndex;

final InfoController _infoController = Get.find<InfoController>();

  // Toggle the selected item
  void _toggleItem(int index) {
    setState(() {
      _selectedIndex = _selectedIndex == index ? null : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      ///======================Faqs======================
      appBar: const CustomAppBar(appBarContent: AppStrings.faqs,iconData: Icons.arrow_back,),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _infoController.faqData.length,
        itemBuilder: (context, index) {
          final item = _infoController.faqData[index];
          final isSelected = _selectedIndex == index;
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white50,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                ///======================Question=======================
                ListTile(
               title: CustomText(
                 maxLines: 2,
                 textAlign: TextAlign.start,
                 text: item["question"]!,
               color: AppColors.gray500,
                 fontSize: 14,
                 fontWeight: FontWeight.w500,
               ),
                  trailing: Icon(
                    isSelected ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.green500,
                  ),
                  onTap: () => _toggleItem(index),
                ),
                AnimatedCrossFade(
                  firstChild: Container(),
                  secondChild: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    ///====================Answer====================
                    child: CustomText(
                      maxLines: 10,
                      textAlign: TextAlign.start,
                      text:  item["answer"]!,
                      color: AppColors.gray500,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  crossFadeState: isSelected ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}

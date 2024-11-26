import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/info_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final InfoController infoController = Get.find<InfoController>();

    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///======================Faqs======================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.faqs,
        iconData: Icons.arrow_back,
      ),
      body: Obx(() {
        switch (infoController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(onTap: () {
              infoController.getFaq();
            });

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                infoController.getFaq(); // Retry fetching data on error
              },
            );

          case Status.completed:
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: infoController.faqList.length,
              itemBuilder: (context, index) {
                final item = infoController.faqList[index];
                return Obx(() {
                  // Check if the current FAQ is selected
                  final isSelected = infoController.selectedIndex.value == index;

                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.white50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        ///======================Question=======================
                        ListTile(
                          title: CustomText(
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            text: item.question ?? "",
                            color: AppColors.gray500,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Icon(
                            isSelected
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: AppColors.green500,
                          ),
                          onTap: () => infoController.toggleItem(index),
                        ),
                        AnimatedCrossFade(
                          firstChild: Container(),
                          secondChild: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),

                            ///====================Answer====================
                            child: CustomText(
                              maxLines: 10,
                              textAlign: TextAlign.start,
                              text: item.answer ?? "",
                              color: AppColors.gray500,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          crossFadeState: isSelected
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                        ),
                      ],
                    ),
                  );
                });
              },
            );
        }
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/global/widgets/reward_card/reward_card.dart';
import 'package:protippz/app/screens/rewardz_screen/inner_widget/otp_veryFy.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

import 'inner_widget/email_verification_dialog.dart';
import 'inner_widget/info_dialoge.dart';
import 'inner_widget/shirt_from_dialog.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  final HomeController homeController = Get.find<HomeController>();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Ensure that the first reward is selected when the screen is loaded
    if (homeController.rewardList.isNotEmpty) {
      homeController.selectedIndex.value = 0; // Select the first reward
      homeController.selectedReward(id: homeController.rewardList[0].id ?? ""); // Fetch the data for the selected reward
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///==============*********>>>>>>>>Reward AppBar<<<<<<<********===
      appBar: const CustomAppBar(
        appBarContent: AppStrings.rewardz,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            /// ========================= Rewardz List =======================
            Obx(() {
              if (homeController.rewardList.isEmpty) {
                return const CustomText(
                  text: "No Rewards Found",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.gray500,
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(homeController.rewardList.length, (index) {
                    final item = homeController.rewardList[index];
                    final isSelected = homeController.selectedIndex.value == index;

                    return GestureDetector(
                      onTap: () {
                        // Update selected index and fetch corresponding data
                        homeController.selectedIndex.value = index;
                        homeController.selectedReward(id: item.id ?? "");
                        print("Selected Item ID:==================== ${item.id}");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(color: AppColors.green500, width: 2)
                              : null,
                        ),
                        child: Column(
                          children: [
                            // Reward Image
                            CustomNetworkImage(
                              imageUrl: "${ApiUrl.netWorkUrl}${item.image ?? ""}",
                              height: 72,
                              width: 73,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            SizedBox(height: 10.h),
                            // Reward Name
                            Text(
                              item.name ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),

            Gap(24.h),

            /// ========================= Search Input =======================
            CustomTextField(
              isColor: false,
              inputTextStyle: const TextStyle(color: AppColors.gray500),
              onFieldSubmitted: (value) {
                // Ensure that the search uses the selected reward's ID
                String selectedRewardId = homeController.selectedRewardId.value;
                if (selectedRewardId.isEmpty && homeController.rewardList.isNotEmpty) {
                  selectedRewardId = homeController.rewardList[0].id ?? "";
                }
                homeController.searchReward(
                  search: value,
                  id: selectedRewardId,
                );
                print("Search with selected Reward ID: $selectedRewardId");
              },
              textEditingController: homeController.searchController,
              hintText: AppStrings.searchReward,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.gray500,
              ),
              fillColor: AppColors.white50,
              fieldBorderColor: AppColors.grey400,
            ),

            Gap(14.h),

            /// ======================== Reward Details ======================
            Expanded(
              child: Obx(() {
                if (homeController.rxRequestStatus.value == Status.loading) {
                  return const CustomLoader(); // Show loading indicator
                }

                if (homeController.rxRequestStatus.value == Status.internetError) {
                  return const Center(
                    child: CustomText(
                      text: 'Please Connect Your Internet',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.gray500,
                    ),
                  );
                }

                if (homeController.rxRequestStatus.value == Status.error) {
                  return GeneralErrorScreen(
                    onTap: () {
                      if (homeController.rewardList.isNotEmpty) {
                        homeController.selectedReward(
                          id: homeController.rewardList[0].id ?? "",
                        );
                      }
                    },
                  );
                }

                if (homeController.rxRequestStatus.value == Status.completed && homeController.selectRewardList.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "No Rewards Available",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.gray500,
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: homeController.selectRewardList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1 / 2,
                  ),
                  itemBuilder: (context, index) {
                    var data = homeController.selectRewardList[index];
                    return RewardCard(
                      imageUrl: "${ApiUrl.netWorkUrl}${data.rewardImage ?? ""}",
                      name: data.name ?? "",
                      describe: data.description ?? "",
                      points: data.pointRequired.toString(),
                      onTap: () {
                        if (data.category?.deliveryOption == "Shipping Address") {
                          whenShirtDialog(context);
                        } else if (data.category?.deliveryOption == "Email") {
                          infoDialogue(context);
                        }
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  ///===============================Info Dialogue=======================
  void infoDialogue(BuildContext context) {
    Get.dialog(
      InfoDialogBox(
        onTapClose: () {
          Get.back(); // Close the dialog
        },
        onTapContinue: () {
          Get.back(); // Close the dialog
          veryFyEmailAddress(context); // Your continue button action
        },
      ),
    );
  }

  ///============================Email VeryFy =========================
  void veryFyEmailAddress(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    Get.dialog(
      EmailVerificationDialog(
        formKey: formKey,
        emailController: homeController.emailController,
        onSendCode: () {
          if (formKey.currentState!.validate()) {
            Get.back(); // Close the dialog
            homeController.veryFyEmail(
              rewardId: homeController.selectRewardList[0].id ?? "",
              categoryId: homeController.selectRewardList[0].category?.id ?? "",
            );
            veryFyOtp(context);
          }
        },
        onClose: () {
          Get.back(); // Close the dialog
        },
      ),
    );
  }

  ///=======================VeryFy Otp=========================
  void veryFyOtp(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    Get.dialog(
      OtpVeryEmail(
        formKey: formKey,
        onSendCode: () {
          if (formKey.currentState!.validate()) {
            Get.back(); // Close the dialog
            homeController.veryFyOtp();
          }
        },
        onClose: () {
          Get.back(); // Close the dialog
        },
        pinController: homeController.pinController,
      ),
    );
  }

  /// ===========================Shirt==========================
  void whenShirtDialog(BuildContext context) {
    Get.dialog(
      ShirtFormDialog(
        formKey: formKey,
        homeController: homeController,
      ),
    );
  }
}

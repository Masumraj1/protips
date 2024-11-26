import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/home_controller.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_rewadz_card/custom_rewadz_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class RewardzScreen extends StatefulWidget {
  RewardzScreen({super.key});

  @override
  State<RewardzScreen> createState() => _RewardzScreenState();
}

class _RewardzScreenState extends State<RewardzScreen> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    // Initial API call to fetch data for the first reward
    if (homeController.rewardList.isNotEmpty) {
      homeController.selectedReward(id: homeController.rewardList[0].id ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
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
                  children:
                      List.generate(homeController.rewardList.length, (index) {
                    final item = homeController.rewardList[index];
                    final isSelected =
                        homeController.selectedIndex.value == index;

                    return GestureDetector(
                      onTap: () {
                        // Update selected index and fetch corresponding data
                        homeController.selectedIndex.value = index;
                        homeController.selectedReward(id: item.id ?? "");
                        print("Selected Item ID: ${item.id}");
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
                              imageUrl:
                                  "${ApiUrl.netWorkUrl}${item.image ?? ""}",
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
                homeController.searchReward(search: value);
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

                if (homeController.rxRequestStatus.value ==
                    Status.internetError) {
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

                if (homeController.rxRequestStatus.value == Status.completed &&
                    homeController.selectRewardList.isEmpty) {
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
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    var data = homeController.selectRewardList[index];
                    return CustomRewadzCard(
                      isVisible: true,
                      buttonTitle: "Redeem",
                      imageUrl: "${ApiUrl.netWorkUrl}${data.rewardImage ?? ""}",
                      name: data.name ?? "",
                      team: data.name ?? "Team Name",
                      position: data.description ?? "Position",
                      isTeam: true,
                      isPosition: true,
                      onTap: () {
                        // Handle Redeem Logic
                        print("Redeem clicked for ${data.name}");
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
}

//
// void showDialogBox(BuildContext context) {
//   Get.dialog(
//     AlertDialog(
//         backgroundColor: AppColors.white50,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const SizedBox(),
//                 const Spacer(),
//                 GestureDetector(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Assets.icons.closeSmall.svg())
//               ],
//             ),
//             const CustomText(
//               left: 50,
//               fontSize: 16,
//               text: AppStrings.howTOReceive,
//               fontWeight: FontWeight.w500,
//               color: AppColors.gray500,
//               bottom: 10,
//             ),
//             const CustomText(
//               textAlign: TextAlign.start,
//               text: AppStrings.veryFyYourEmailAddress,
//               fontWeight: FontWeight.w400,
//               color: AppColors.gray500,
//               fontSize: 14,
//               maxLines: 10,
//             ),
//             const CustomText(
//               textAlign: TextAlign.start,
//               top: 16,
//               text: AppStrings.veryFyYourNameAndMailing,
//               fontWeight: FontWeight.w400,
//               fontSize: 14,
//               color: AppColors.gray500,
//               bottom: 16,
//               maxLines: 10,
//             ),
//             const CustomText(
//               textAlign: TextAlign.start,
//               top: 16,
//               text: AppStrings.confirmationOnce,
//               fontWeight: FontWeight.w400,
//               fontSize: 14,
//               color: AppColors.gray500,
//               bottom: 16,
//               maxLines: 10,
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             CustomButton(
//               onTap: () {
//                 Get.back();
//                 whenShirtDialog(context);
//               },
//               title: AppStrings.continues,
//               fillColor: AppColors.blue500,
//             )
//           ],
//         )),
//   );
// }
//
// // void showVerify(BuildContext context) {
// void whenShirtDialog(BuildContext context) {
//   Get.dialog(
//     AlertDialog(
//         backgroundColor: AppColors.white50,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const SizedBox(),
//                 const Spacer(),
//                 GestureDetector(
//                     onTap: () {
//                       Get.back();
//                     },
//                     child: Assets.icons.closeSmall.svg())
//               ],
//             ),
//
//             ///==========================Delete Account===============
//             const CustomText(
//               left: 20,
//               fontSize: 16,
//               maxLines: 2,
//               text: "Verify Name and Mailing Address",
//               fontWeight: FontWeight.w500,
//               color: AppColors.gray500,
//               bottom: 10,
//             ),
//             CustomFromCard(
//                 hinText: AppStrings.enterYourFullName,
//                 isBgColor: true,
//                 title: AppStrings.fullName,
//                 controller: TextEditingController(),
//                 validator: (v) {}),
//             const CustomText(
//               textAlign: TextAlign.start,
//               fontSize: 16,
//               text: AppStrings.mailingAddress,
//               fontWeight: FontWeight.w400,
//               color: AppColors.gray500,
//               bottom: 18,
//               top: 18,
//             ),
//             CustomFromCard(
//                 hinText: AppStrings.typeHere,
//                 isBgColor: true,
//                 title: AppStrings.streetAddress,
//                 controller: TextEditingController(),
//                 validator: (v) {}),
//             CustomFromCard(
//                 hinText: AppStrings.typeHere,
//                 isBgColor: true,
//                 title: AppStrings.city,
//                 controller: TextEditingController(),
//                 validator: (v) {}),
//             CustomFromCard(
//                 hinText: AppStrings.typeHere,
//                 isBgColor: true,
//                 title: AppStrings.state,
//                 controller: TextEditingController(),
//                 validator: (v) {}),
//
//             CustomFromCard(
//                 hinText: AppStrings.typeHere,
//                 isBgColor: true,
//                 title: AppStrings.zipCode,
//                 controller: TextEditingController(),
//                 validator: (v) {}),
//             SizedBox(
//               height: 20.h,
//             ),
//
//             CustomButton(
//               onTap: () {
//                 Get.back();
//               },
//               title: AppStrings.submit,
//               fillColor: AppColors.blue500,
//             )
//           ],
//         )),
//   );
// }

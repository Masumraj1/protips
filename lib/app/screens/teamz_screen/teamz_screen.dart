import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/team_controller.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/controllers/genarel_controller/genarel_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_player_card/custom_player_card.dart';
import 'package:protippz/app/global/widgets/custom_team_card/custom_team_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class TeamScreen extends StatelessWidget {
   TeamScreen({super.key});

  final TeamController teamController = Get.find<TeamController>();
  final GeneralController _generalController = Get.find<GeneralController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      ///==============*********>>>>>>>>Team<<<<<<<********===
      appBar: const CustomAppBar(
        appBarContent: AppStrings.teamz,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [

            ///===============================Select League=====================
            Obx(() {
              if (_generalController.leagueList.isEmpty) {
                return const CustomText(
                  text: "No Player Found",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.gray500,
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                  List.generate(_generalController.leagueList.length, (index) {
                    final item = _generalController.leagueList[index];
                    final isSelected =
                        teamController.selectedIndex.value == index;

                    return GestureDetector(
                      onTap: () {
                        // Update selected index and fetch corresponding data
                        teamController.selectedIndex.value = index;
                        teamController.selectTeam(id: item.id ?? "");
                        print(
                            "Selected League ID:==================== ${item.id}");
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
                              "${ApiUrl.netWorkUrl}${item.leagueImage ?? ""}",
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
            CustomTextField(
              isColor: false,
              inputTextStyle: const TextStyle(color: AppColors.gray500),
              onFieldSubmitted: (value) {
                String selectedRewardId = teamController.selectTeamId.value;
                if (selectedRewardId.isEmpty && teamController.selectTeamList.isNotEmpty) {
                  selectedRewardId = teamController.selectTeamList[0].id ?? "";
                }
                teamController.searchTeam(
                  search: value,
                  id: selectedRewardId,
                );
                print("Search with selected League ID:====================== $selectedRewardId");
              },
              textEditingController: teamController.searchController,
              hintText: AppStrings.searchPlayer,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.gray500,
              ),
              fillColor: AppColors.white50,
              fieldBorderColor: AppColors.grey400,
            ),
            Gap(14.h),


            Gap(24.h),
            ///==================================Player============================
            Expanded(
              child: Obx(() {
                if (teamController.rxRequestStatus.value == Status.loading) {
                  return const CustomLoader(); // Show loading indicator
                }

                if (teamController.rxRequestStatus.value ==
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

                if (teamController.rxRequestStatus.value == Status.error) {
                  return GeneralErrorScreen(
                    onTap: () {
                      if (teamController.selectTeamList.isNotEmpty) {
                        teamController.selectTeamList();
                      }
                    },
                  );
                }

                if (teamController.rxRequestStatus.value == Status.completed &&
                    teamController.selectTeamList.isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "No Player Available",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.gray500,
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: teamController.selectTeamList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1 / 1.5,
                  ),
                  itemBuilder: (context, index) {
                    var data = teamController.selectTeamList[index];
                    // Fix: Check if playerImage has a valid value
                    String imageUrl = "${ApiUrl.netWorkUrl}${data.teamLogo}";
                    // If playerImage is empty or invalid, you might want to set a default image
                    if (data.teamLogo == null || data.teamLogo!.isEmpty) {
                      imageUrl = AppConstants.profileImage; // Replace with a default image URL
                    }

                    return CustomTeamCard(
                      imageUrl: imageUrl,  // Pass the constructed image URL to the card
                      name: data.name ?? "",
                      sport: '',
                      onTap: () {

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

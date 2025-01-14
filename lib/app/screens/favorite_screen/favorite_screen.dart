import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/favorite_controller.dart';
import 'package:protippz/app/controller/player_controller.dart';
import 'package:protippz/app/controller/team_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/controllers/genarel_controller/genarel_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_dialogbox/custom_dialogbox.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_player_card/custom_player_card.dart';
import 'package:protippz/app/global/widgets/custom_team_card/custom_team_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController =
        Get.find<FavoriteController>();
    final PlayerController playerController = Get.find<PlayerController>();
    final TeamController teamController = Get.find<TeamController>();

    return Scaffold(
      backgroundColor: AppColors.bg500,
      bottomNavigationBar: const NavBar(currentIndex: 2),

      ///========================Favorites===================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.favorites,
        iconData: Icons.arrow_back,
      ),
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //*************************============ Tab Selection Row=============****************
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.gray300),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  favoriteController.favoriteTabList.length,
                  (index) => GestureDetector(
                    onTap: () {
                      favoriteController.selectedIndex.value = index;
                      // Fetch data only when switching between tabs
                      if (index == 0) {
                        favoriteController.getFavoritePlayer();
                      } else {
                        favoriteController.getFavoriteTeam();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        color: favoriteController.selectedIndex.value == index
                            ? AppColors.green500
                            : AppColors.white50,
                      ),
                      child: CustomText(
                        textAlign: TextAlign.start,
                        text: favoriteController.favoriteTabList[index],
                        color: favoriteController.selectedIndex.value == index
                            ? AppColors.white50
                            : AppColors.gray300,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Body content based on request status
            Expanded(
              child: Obx(() {
                bool isLoading =
                    favoriteController.rxRequestStatus.value == Status.loading;
                bool isEmpty = favoriteController.selectedIndex.value == 0
                    ? favoriteController.favoritePlayerList.isEmpty
                    : favoriteController.favoriteTeamList.isEmpty;

                if (isLoading) {
                  return const CustomLoader(); // Show loading indicator
                }

                if (favoriteController.rxRequestStatus.value ==
                    Status.internetError) {
                  return NoInternetScreen(onTap: () {
                    favoriteController.getFavoriteTeam();
                    favoriteController.getFavoritePlayer();
                  });
                }

                if (favoriteController.rxRequestStatus.value == Status.error) {
                  return GeneralErrorScreen(
                    onTap: () {
                      favoriteController.getFavoriteTeam();
                      favoriteController.getFavoritePlayer();
                    },
                  );
                }

                if (isEmpty) {
                  return const Center(
                    child: CustomText(
                      text: "No Data Found",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.gray500,
                    ),
                  );
                }

                return GridView.builder(
                  itemCount: favoriteController.selectedIndex.value == 0
                      ? favoriteController.favoritePlayerList.length
                      : favoriteController.favoriteTeamList.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio:
                        favoriteController.selectedIndex.value == 0
                            ? 1 / 2
                            : 1 / 1.9,
                  ),
                  itemBuilder: (context, index) {
                    if (favoriteController.selectedIndex.value == 0) {
                      var playerData =
                          favoriteController.favoritePlayerList[index];
                      RxBool isBookmarked = true.obs;

                      ///================================Player=========================
                      return CustomPlayerCard(
                        imageUrl:
                            "${ApiUrl.netWorkUrl}${playerData.player?.playerImage ?? ""}",
                        name: playerData.player?.name ?? "",
                        team: playerData.player?.team?.name ?? "",
                        position: playerData.player?.position ?? "",
                        onTap: () {
                          showCustomDialog(context,
                              title: playerData.player?.name ?? "",
                              team: playerData.player?.team?.name ?? "",
                              position: playerData.player?.position ?? "",
                              image:
                                  "${ApiUrl.netWorkUrl}${playerData.player?.playerImage ?? ""}",
                              id: playerData.player?.id ?? "", type: 'Player');
                        },
                        onBookMarkTab: () async {
                          favoriteController.rxRequestStatus.value =
                              Status.loading;

                          await playerController.playerBookmarkDelete(
                              id: playerData.player?.id ?? "");

                          // Immediately remove player from the list in GetX
                          favoriteController.favoritePlayerList.removeAt(index);

                          favoriteController.rxRequestStatus.value =
                              Status.completed;
                        },
                        isBookmark: isBookmarked,
                      );
                    } else if (favoriteController.selectedIndex.value == 1) {
                      var teamData = favoriteController.favoriteTeamList[index];
                      RxBool isBookmarkTeam = true.obs;

                      ///=============================Team==========================
                      return CustomTeamCard(
                        imageUrl:
                            "${ApiUrl.netWorkUrl}${teamData.team?.teamLogo ?? ""}",
                        name: teamData.team?.name ?? "",
                        sport: teamData.team?.league?.sport ?? "",
                        onTap: () {
                          showCustomDialogTeam(context,
                              title: teamData.team?.name ?? "",
                              team: "",
                              position: '',
                              image:
                                  "${ApiUrl.netWorkUrl}${teamData.team?.teamLogo ?? ""}",
                              id: teamData.team?.id ?? "", type: 'Team');
                        },
                        onBookMarkTab: () async {
                          favoriteController.rxRequestStatus.value =
                              Status.loading;

                          await teamController.teamBookmarkDelete(
                              id: teamData.team?.id ?? "");

                          // Immediately remove team from the list in GetX
                          favoriteController.favoriteTeamList.removeAt(index);

                          favoriteController.rxRequestStatus.value =
                              Status.completed;
                        },
                        isBookmark: isBookmarkTeam,
                      );
                    } else {
                      toastMessage(message: "Invalid selection");
                      return const SizedBox
                          .shrink(); // Placeholder for invalid state
                    }
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  ///==========================Send Player ==========================
  void showCustomDialog(BuildContext context,
      {required String title,
      required String team,
      required String id,
      required String type,
      required String position,
      required String image}) {
    final GeneralController _generalController = Get.find();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return CustomDialogBox(
            title: title,
            team: team,
            position: position,
            controller: _generalController.sendAmountController,
            image: image,
            button: _generalController.isSendTips.value
                ? const CustomLoader()
                : CustomButton(
                    title: AppStrings.sendTippz,
                    onTap: () {
                      Get.back();
                      showDialogBox(context, id,type);
                    },
                  ),
          );
        });
      },
    );
  }

  void showDialogBox(BuildContext context, String id,String type) {
    final GeneralController generalController = Get.find<GeneralController>();
    final FavoriteController favoriteController =
        Get.find<FavoriteController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white50,
          content: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close dialog
                        },
                        child: Assets.icons.closeSmall.svg())
                  ],
                ),
                const CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  fontSize: 20,
                  text: "Select your payment method",
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray500,
                  bottom: 10,
                ),
                Column(
                  children: generalController.amountOptions
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    String amount = entry.value;
                    return RadioListTile<int>(
                      value: index,
                      groupValue: generalController.selectedValue,
                      // Get the value from controller
                      onChanged: (int? value) {
                        if (value != null) {
                          generalController.selectedValue =
                              value; // Update via controller
                        }
                      },
                      activeColor: Colors.teal,
                      title: Text(
                        amount,
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
                generalController.isSendTips.value
                    ? const CustomLoader()
                    : CustomButton(
                        fillColor: AppColors.blue500,
                        onTap: () {
                          if (generalController.selectedValue == 0) {
                            generalController.sendTips(
                                entityId: favoriteController
                                        .favoritePlayerList[0].player?.id ??
                                    "",
                                entityType: 'Player',
                                tipBy: 'Profile balance');
                            print(
                                "==========================value${generalController.selectedValue}");
                          } else if (generalController.selectedValue == 1) {
                            Get.toNamed(AppRoute.dairekPayScreen,
                                arguments:[id,type]);
                          }
                        },
                        title: AppStrings.continues,
                      ),
              ],
            );
          }),
        );
      },
    );
  }


  ///==========================Send Team ==========================
  void showCustomDialogTeam(BuildContext context,
      {required String title,
      required String team,
      required String position,
      required String id,
        required String type,
      required String image}) {
    final GeneralController _generalController = Get.find();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return CustomDialogBox(
            title: title,
            team: team,
            position: position,
            controller: _generalController.sendAmountController,
            image: image,
            button: _generalController.isSendTips.value
                ? const CustomLoader()
                : CustomButton(
                    title: AppStrings.sendTippz,
                    onTap: () {
                      Get.back();
                      showDialogBoxTeam(context, id,type);
                    },
                  ),
          );
        });
      },
    );
  }

  ///==================================Send Team====================
  void showDialogBoxTeam(BuildContext context, String id,String type) {
    final GeneralController generalController = Get.find<GeneralController>();
    final FavoriteController favoriteController =
    Get.find<FavoriteController>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white50,
          content: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close dialog
                        },
                        child: Assets.icons.closeSmall.svg())
                  ],
                ),
                const CustomText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  fontSize: 20,
                  text: "Select your payment method",
                  fontWeight: FontWeight.w500,
                  color: AppColors.gray500,
                  bottom: 10,
                ),
                Column(
                  children: generalController.amountOptions
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    String amount = entry.value;
                    return RadioListTile<int>(
                      value: index,
                      groupValue: generalController.selectedValue,
                      // Get the value from controller
                      onChanged: (int? value) {
                        if (value != null) {
                          generalController.selectedValue =
                              value; // Update via controller
                        }
                      },
                      activeColor: Colors.teal,
                      title: Text(
                        amount,
                        style:
                        const TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
                generalController.isSendTips.value
                    ? const CustomLoader()
                    : CustomButton(
                  fillColor: AppColors.blue500,
                  onTap: () {
                    if (generalController.selectedValue == 0) {
                      generalController.sendTips(
                          entityId: favoriteController
                              .favoriteTeamList[0].team?.id ??
                              "",
                          entityType: 'Team',
                          tipBy: 'Profile balance');
                    } else if (generalController.selectedValue == 1) {
                      Get.toNamed(AppRoute.dairekPayScreen,
                          arguments: [id,type]);
                    }
                  },
                  title: AppStrings.continues,
                ),
              ],
            );
          }),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/favorite_controller.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
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

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
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
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      decoration: BoxDecoration(
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
            Obx(() {
              switch (favoriteController.rxRequestStatus.value) {
                case Status.loading:
                  return const CustomLoader(); // Show loading indicator

                case Status.internetError:
                  return NoInternetScreen(onTap: () {
                    favoriteController
                        .getFavoriteTeam(); // Retry fetching data on error
                    favoriteController.getFavoritePlayer();
                  });

                case Status.error:
                  return GeneralErrorScreen(
                    onTap: () {
                      favoriteController
                          .getFavoriteTeam(); // Retry fetching data on error
                      favoriteController
                          .getFavoritePlayer(); // Retry fetching data on error
                    },
                  );

                case Status.completed:
                  // Show empty state if no notifications are found
                  if (favoriteController.favoritePlayerList.isEmpty ||
                      favoriteController.favoriteTeamList.isEmpty) {
                    return const Center(
                      child: CustomText(
                        text: "No Data Found",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.gray500,
                      ),
                    );
                  }
                  return Expanded(
                    child: GridView.builder(
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
                                ? 1 / 1.7
                                : 1 / 1.5,
                      ),
                      itemBuilder: (context, index) {
                        if (favoriteController.selectedIndex.value == 0) {
                          // =-======================For players========================
                          var playerData =
                              favoriteController.favoritePlayerList[index];
                          return CustomPlayerCard(
                            imageUrl:
                                "${ApiUrl.netWorkUrl}${playerData.player?.playerImage ?? ""}",
                            name: playerData.player?.name ?? "",
                            team: playerData.player?.team?.name ?? "",
                            // Replace with dynamic team name if available
                            position: playerData.player?.position ?? "",
                            // Replace dynamically if possible
                            onTap: () {
                              // toastMessage(message: "Player tapped: ${playerData.player?.name}");
                            },
                          );
                        } else if (favoriteController.selectedIndex.value ==
                            1) {
                          //========================== For teams===========================
                          var teamData =
                              favoriteController.favoriteTeamList[index];
                          return CustomTeamCard(
                            imageUrl:
                                "${ApiUrl.netWorkUrl}${teamData.team?.teamLogo ?? ""}",
                            name: teamData.team?.name ?? "",
                            sport: teamData.team?.league?.sport ?? "",
                            onTap: () {
                              // toastMessage(message: "Team tapped: ${teamData.team?.name}");
                            },
                          );
                        } else {
                          toastMessage(message: "Invalid selection");
                          return const SizedBox
                              .shrink(); // Placeholder for invalid state
                        }
                      },
                    ),
                  );
                default:
                  return const SizedBox
                      .shrink();
              }
            })
          ],
        );
      }),
    );
  }
}

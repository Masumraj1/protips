import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/player_controller.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/controllers/genarel_controller/genarel_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_dialogbox/custom_dialogbox.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_player_card/custom_player_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final PlayerController _playerController = Get.find<PlayerController>();
  final GeneralController _generalController = Get.find<GeneralController>();

  ///===========================A TO Z=======================
  String dropdownValue = 'A to Z'; // Initial dropdown value

  void _updatePlayerSorting() {
    String selectedId = _playerController.selectPlayerId.value;
    if (selectedId.isEmpty && _playerController.selectPlayerList.isNotEmpty) {
      selectedId = _playerController.selectPlayerList[0].id ?? "";
    }

    _playerController.playerShort(
      id: selectedId,
      name: dropdownValue == 'A to Z' ? 'name' : '-name',
    );
  }

  ///=================================Name=========================
  String dropdownName = 'Name'; // Initial dropdown value

  void _updatePlayerSortingName() {
    String selectedId = _playerController.selectPlayerId.value;
    if (selectedId.isEmpty && _playerController.selectPlayerList.isNotEmpty) {
      selectedId = _playerController.selectPlayerList[0].id ?? "";
    }

    _playerController.playerShort(
      id: selectedId,
      name: dropdownValue == 'Name' ? 'name' : 'position',
    );
  }

  @override
  void initState() {
    super.initState();

    // Ensure that the first league is selected by default and its teams are fetched
    if (_generalController.leagueList.isNotEmpty) {
      _playerController.selectedIndex.value = 0; // Set default index to 0
      // Fetch teams for the first league (index 0)
      _playerController.selectPlayer(
          id: _generalController.leagueList[0].id ?? "");
    }
  }
  final String type = Get.arguments;  // This will retrieve 'Player' or 'Team'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.playerz,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            //============================= League List (Horizontal Scroll)=====================
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
                  children: List.generate(_generalController.leagueList.length,
                      (index) {
                    final item = _generalController.leagueList[index];
                    final isSelected =
                        _playerController.selectedIndex.value == index;

                    return GestureDetector(
                      onTap: () {
                        _playerController.selectedIndex.value = index;
                        _playerController.selectPlayer(id: item.id ?? "");
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
                            // League Image
                            CustomNetworkImage(
                              imageUrl:
                                  "${ApiUrl.netWorkUrl}${item.leagueImage ?? ""}",
                              height: 72,
                              width: 73,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            SizedBox(height: 10.h),
                            // League Name
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

            //======================== Search Field===================================
            CustomTextField(
              isColor: false,
              inputTextStyle: const TextStyle(color: AppColors.gray500),
              onFieldSubmitted: (value) {
                String selectedRewardId =
                    _playerController.selectPlayerId.value;
                if (selectedRewardId.isEmpty &&
                    _playerController.selectPlayerList.isNotEmpty) {
                  selectedRewardId =
                      _playerController.selectPlayerList[0].id ?? "";
                }
                _playerController.searchPlayer(
                  search: value,
                  id: selectedRewardId,
                );
              },
              textEditingController: _playerController.searchController,
              hintText: AppStrings.searchPlayer,
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.gray500,
              ),
              fillColor: AppColors.white50,
              fieldBorderColor: AppColors.grey400,
            ),
            Gap(14.h),

            ///============================A to z========================
            Row(
              children: [
                const CustomText(
                  text: "Sort By:",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.gray500,
                  right: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.green500, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownName,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownName = value!;
                        // Trigger sorting when dropdown value changes
                        _updatePlayerSortingName();
                      });
                    },
                    items: ['Name', 'Position'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    underline: Container(),
                    isExpanded: false,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.green500, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                        // Trigger sorting when dropdown value changes
                        _updatePlayerSorting();
                      });
                    },
                    items: ['A to Z', 'Z to A'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    underline: Container(),
                    isExpanded: false,
                  ),
                ),
              ],
            ),

            Gap(24.h),

            // Player Grid
            Expanded(
              child: Obx(() {
                switch (_playerController.rxRequestStatus.value) {
                  case Status.loading:
                    return const CustomLoader();
                  case Status.internetError:
                    return const Center(
                      child: CustomText(
                        text: 'Please Connect Your Internet',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.gray500,
                      ),
                    );
                  case Status.error:
                    return GeneralErrorScreen(
                      onTap: () {
                        if (_playerController.selectPlayerList.isNotEmpty) {
                          _playerController.selectPlayerList();
                        }
                      },
                    );
                  case Status.completed:
                    if (_playerController.selectPlayerList.isEmpty) {
                      return const Center(
                        child: CustomText(
                          text: "No Player Available",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: AppColors.gray500,
                        ),
                      );
                    }

                    // Responsive GridView
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = constraints.maxWidth > 640 ? 3 : 2;
                        return GridView.builder(
                          itemCount: _playerController.selectPlayerList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 16.w,
                            mainAxisSpacing: 16.h,
                            childAspectRatio: 1 / 2.2,
                          ),
                          itemBuilder: (context, index) {
                            final data =
                                _playerController.selectPlayerList[index];
                            String imageUrl =
                                "${ApiUrl.netWorkUrl}${data.playerImage}";

                            if (data.playerImage == null ||
                                data.playerImage!.isEmpty) {
                              imageUrl = AppConstants.profileImage;
                            }

                            RxBool isBookmarked =
                                (data.isBookmark ?? false).obs;

                            return CustomPlayerCard(
                              imageUrl: imageUrl,
                              name: data.name ?? "",
                              team: data.team?.name ?? "",
                              position: data.position,
                              onTap: () {
                                showCustomDialog(
                                  context,
                                  image: imageUrl,
                                  title: data.name ?? "",
                                  team: data.team?.name ?? "",
                                  position: data.position ?? "",
                                  id: data.id ?? '',
                                );
                              },
                              onBookMarkTab: () {
                                if (isBookmarked.value) {
                                  _playerController.playerBookmarkDelete(
                                      id: data.id ?? "");
                                } else {
                                  _playerController.playerBookMark(
                                      playerId: data.id ?? "");
                                }
                                isBookmarked.value = !isBookmarked.value;
                              },
                              isBookmark: isBookmarked,
                            );
                          },
                        );
                      },
                    );
                  default:
                    return const SizedBox.shrink();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context,
      {required String image,
      required String title,
      required String team,
      required String id,
      required String position}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          team: team,
          position: position,
          controller: _generalController.sendAmountController,
          image: image,
          button: CustomButton(
            title: AppStrings.sendTippz,
            onTap: () {
              Get.back();
              showDialogBox(context,id,type);
            },
          ),
        );
      },
    );
  }

  void showDialogBox(BuildContext context, String id,String type) {
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
                  children: _generalController.amountOptions
                      .asMap()
                      .entries
                      .map((entry) {
                    int index = entry.key;
                    String amount = entry.value;
                    return RadioListTile<int>(
                      value: index,
                      groupValue: _generalController.selectedValue,
                      onChanged: (int? value) {
                        if (value != null) {
                          _generalController.selectedValue = value; // Update via controller
                        }
                      },
                      activeColor: Colors.teal,
                      title: Text(
                        amount,
                        style: const TextStyle(color: Colors.blue, fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),
                _generalController.isSendTips.value
                    ? const CustomLoader()
                    : CustomButton(
                  fillColor: AppColors.blue500,
                  onTap: () {
                    if (_generalController.selectedValue == 0) {
                      _generalController.sendTips(
                        entityId: _playerController.selectPlayerList[0].id ?? "defaultId",
                        entityType: 'Player',
                        tipBy: 'Profile balance',
                      );
                    } else if (_generalController.selectedValue == 1) {
                      Get.toNamed(AppRoute.dairekPayScreen, arguments: [id,type]); // Pass id here to the next screen
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/player_controller.dart';
import 'package:protippz/app/controller/team_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/controllers/genarel_controller/genarel_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_dialogbox/custom_dialogbox.dart';
import 'package:protippz/app/global/widgets/custom_drop_down/custom_drop_down.dart';
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
  State<PlayerScreen> createState() => _PlayerzScreenState();
}

class _PlayerzScreenState extends State<PlayerScreen> {
  int? _selectedValue;
  final List<String> amountOptions = [
    "Send From Deposit Account",
    "Send From Credit Card/Paypal"
  ];
  bool _isDropdownOpen = false;
  String _selectedSortBy = 'Name';
  String _selectedOrder = 'A to Z';

  final List<String> _sortByOptions = ['Name', 'Team', 'Position'];

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _selectSortBy(String sortBy) {
    setState(() {
      _selectedSortBy = sortBy;
      _isDropdownOpen = false;
    });
  }

  void _toggleOrder() {
    setState(() {
      _selectedOrder = _selectedOrder == 'A to Z' ? 'Z to A' : 'A to Z';
    });
  }

  final PlayerController _playerController = Get.find<PlayerController>();
  final GeneralController _generalController = Get.find<GeneralController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,

      ///==============*********>>>>>>>>Playerz<<<<<<<********===
      appBar: const CustomAppBar(
        appBarContent: AppStrings.playerz,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            ///===============================Select Player=====================
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
                        // Update selected index and fetch corresponding data
                        _playerController.selectedIndex.value = index;
                        _playerController.selectPlayer(id: item.id ?? "");
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
                print(
                    "Search with selected Player ID:====================== $selectedRewardId");
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

            ///========================Short by==========================
            SortOptions(
              selectedSortBy: _selectedSortBy,
              selectedOrder: _selectedOrder,
              isDropdownOpen: _isDropdownOpen,
              sortByOptions: _sortByOptions,
              toggleDropdown: _toggleDropdown,
              selectSortBy: _selectSortBy,
              toggleOrder: _toggleOrder,
              isName: true,
            ),
            Gap(24.h),

            ///==================================Player============================
            Expanded(
              child: Obx(() {
                if (_playerController.rxRequestStatus.value == Status.loading) {
                  return const CustomLoader(); // Show loading indicator
                }

                if (_playerController.rxRequestStatus.value ==
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

                if (_playerController.rxRequestStatus.value == Status.error) {
                  return GeneralErrorScreen(
                    onTap: () {
                      if (_playerController.selectPlayerList.isNotEmpty) {
                        _playerController.selectPlayerList();
                      }
                    },
                  );
                }

                if (_playerController.rxRequestStatus.value ==
                        Status.completed &&
                    _playerController.selectPlayerList.isEmpty) {
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
                  itemCount: _playerController.selectPlayerList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 1 / 1.7,
                  ),
                  itemBuilder: (context, index) {
                    var data = _playerController.selectPlayerList[index];
                    // Fix: Check if playerImage has a valid value
                    String imageUrl = "${ApiUrl.netWorkUrl}${data.playerImage}";
                    // If playerImage is empty or invalid, you might want to set a default image
                    if (data.playerImage == null || data.playerImage!.isEmpty) {
                      imageUrl = AppConstants
                          .profileImage; // Replace with a default image URL
                    }
                    RxBool isBookmarked = (data.isBookmark ?? false).obs;

                    return CustomPlayerCard(
                      imageUrl: imageUrl,
                      // Pass the constructed image URL to the card
                      name: data.name ?? "",
                      team: data.team?.name ?? "",
                      position: data.position,
                      onTap: () {
                        showCustomDialog(context,
                            image: imageUrl,
                            title: data.name ?? "",
                            team: data.team?.name ?? "",
                            position: data.position ?? "");
                      },
                      onBookMarkTab: () {
                        _playerController.playerBookMark(playerId: data.id ?? "");
                        isBookmarked.value = !isBookmarked.value;

                      }, isBookmark:isBookmarked,
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

  void showCustomDialog(BuildContext context,
      {required String image,
      required String title,
      required String team,
      required String position}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return CustomDialogBox(
            title: title,
            team: team,
            position: position,
            // onTap: () {
            //   Get.back();

            //   showDialogBox(context);
            // },
            controller: _generalController.sendAmountController,
            image: image,
            button: _generalController.isSendTips.value
                ? const CustomLoader()
                : CustomButton(
                    title: AppStrings.sendTippz,
                    onTap: () {
                      _generalController.sendTips(
                          entityId: _playerController.selectPlayerList[0].id ??
                              "67556c5778fff26bb6d1bbd6",
                          entityType: 'Player',
                          tipBy: 'Profile balance');
                    },
                  ),
          );
        });
      },
    );
  }

  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white50,
          content: Column(
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
                children: amountOptions.asMap().entries.map((entry) {
                  int index = entry.key;
                  String amount = entry.value;
                  return RadioListTile<int>(
                    value: index,
                    groupValue: _selectedValue,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                    activeColor: Colors.teal,
                    title: Text(
                      amount,
                      style: const TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  );
                }).toList(),
              ),
              CustomButton(
                fillColor: AppColors.blue500,
                onTap: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                title: AppStrings.continues,
              )
            ],
          ),
        );
      },
    );
  }
}

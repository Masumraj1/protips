import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/favorite_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_dialogbox/custom_dialogbox.dart';
import 'package:protippz/app/global/widgets/custom_player_card/custom_player_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavoriteController favoriteController = Get.find<FavoriteController>();
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
      body: Obx(
            () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tab Selection Row
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

              //============== Tab Content========================
              Expanded(
                child: GridView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,

                  ),
                  itemBuilder: (context, index) {
                    final bool isPlayerTab = favoriteController.selectedIndex.value == 0;
                    return CustomPlayerCard(
                      isVisible: isPlayerTab?true:false,
                      imageUrl:isPlayerTab? AppConstants.player:AppConstants.leage,
                      name: isPlayerTab ? 'Robert Smith' : 'Indiana Fever',
                      team: isPlayerTab ? 'Manchester City' : null,
                      position: isPlayerTab ? 'Quarterback' : 'Basketball',
                      isTeam: isPlayerTab,
                      buttonTitle: 'Send Tippz',
                      isPosition: isPlayerTab,
                      onTap: () {
                        showCustomDialog(context, 'Robert Smith', 'Manchester City', 'Forward');
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showCustomDialog(BuildContext context, String title, String team, String position) {
    Get.dialog(
      CustomDialogBox(
        title: title,
        team: team,
        position: position,
        onTap: () {
          // Handle action here
          Get.back();
          showDialogBox(context);
        },
      ),
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

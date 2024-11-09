import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_button/custom_button.dart';
import 'package:protippz/app/global/widgets/custom_dialogbox/custom_dialogbox.dart';
import 'package:protippz/app/global/widgets/custom_drop_down/custom_drop_down.dart';
import 'package:protippz/app/global/widgets/custom_horizontal_card/custom_horizontal_card.dart';
import 'package:protippz/app/global/widgets/custom_player_card/custom_player_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class PlayerzScreen extends StatefulWidget {
  const PlayerzScreen({super.key});

  @override
  State<PlayerzScreen> createState() => _PlayerzScreenState();
}

class _PlayerzScreenState extends State<PlayerzScreen> {
  int? _selectedValue;
  final List<String> amountOptions = ["Send From Deposit Account","Send From Credit Card/Paypal"];
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
      appBar: const CustomAppBar(
        appBarContent: AppStrings.playerz,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [
            Row(
              children: List.generate(4, (index) {
                return CustomHorizontalCard(
                  image: AppConstants.nba,
                  title: 'NBA',
                );
              }),
            ),
            Gap(24.h),
            const CustomTextField(
              hintText: 'Search Players',
              prefixIcon: Icon(Icons.search, color: AppColors.gray500),
              fillColor: AppColors.white50,
              fieldBorderColor: AppColors.grey400,
            ),
            Gap(14.h),
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
            Gap(14.h),
            Expanded(
              child: GridView.builder(
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return CustomPlayerCard(
                    imageUrl: AppConstants.team,
                    name: 'Robert Smith',
                    team: 'Manchester City',
                    position: 'Quarterback',
                    isTeam: true,
                    isPosition: true,
                    buttonTitle: "Send Tippz",
                    onTap: () {
                      showCustomDialog(context, 'Robert Smith',
                          'Manchester City', 'Forward');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCustomDialog(
      BuildContext context, String title, String team, String position) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogBox(
          title: title,
          team: team,
          position: position,
          onTap: () {
            showDialogBox(context);
          },
        );
      },
    );
  }

  void showDialogBox(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
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
      ),
    );
  }

}

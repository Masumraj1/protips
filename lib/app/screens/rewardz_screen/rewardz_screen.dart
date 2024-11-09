import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_drop_down/custom_drop_down.dart';
import 'package:protippz/app/global/widgets/custom_network_image/custom_network_image.dart';
import 'package:protippz/app/global/widgets/custom_player_card/custom_player_card.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class RewardzScreen extends StatefulWidget {
  const RewardzScreen({super.key});

  @override
  State<RewardzScreen> createState() => _RewardzScreenState();
}

class _RewardzScreenState extends State<RewardzScreen> {
  bool _isDropdownOpen = false;
  String _selectedSortBy = 'Name';
  String _selectedOrder = 'A to Z';

  final List<String> _sortByOptions = ['Name', 'Team', ];

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
        appBarContent: AppStrings.rewardz,
        iconData: Icons.arrow_back,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          children: [


            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(4, (index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        CustomNetworkImage(
                            imageUrl: AppConstants.reward,
                            height: 72,
                            width: 72),


                        const CustomText(
                          top: 10,
                          text: "Tickets",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.gray500,),
                      ],
                    ),
                  );
                }),
              ),
            ),
            Gap(24.h),

            const CustomTextField(
              hintText: 'Search Reward',
              prefixIcon: Icon(Icons.search,color: AppColors.gray500,),
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
              toggleOrder: _toggleOrder, isName: false
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
                    buttonTitle: "Redeem",
                    imageUrl: AppConstants.team,
                    name: 'Robert Smith' ,
                    team:'Manchester City' ,
                    position: 'Quarterback',
                    isTeam: true,
                    isPosition: true, onTap: () {  },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

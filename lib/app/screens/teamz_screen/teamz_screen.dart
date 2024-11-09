import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_drop_down/custom_drop_down.dart';
import 'package:protippz/app/global/widgets/custom_horizontal_card/custom_horizontal_card.dart';
import 'package:protippz/app/global/widgets/custom_player_card/custom_player_card.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class TeamzScreen extends StatefulWidget {
  const TeamzScreen({super.key});

  @override
  State<TeamzScreen> createState() => _TeamzScreenState();
}

class _TeamzScreenState extends State<TeamzScreen> {
  bool _isDropdownOpen = false;
  String _selectedSortBy = 'Name';
  String _selectedOrder = 'A to Z';

  final List<String> _sortByOptions = ['Name', 'Sport', ];

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
        appBarContent: AppStrings.teamz,
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
                  return CustomHorizontalCard(image: AppConstants.nba, title: "NBA");
                }),
              ),
            ),
            Gap(24.h),

            const CustomTextField(
              hintText: 'Search Teamz',
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
              toggleOrder: _toggleOrder, isName: true,
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
                    name: 'Indiana Fever' ,
                    team:'Manchester City' ,
                    position: 'Quarterback',
                    isTeam: false,
                    isPosition: false,
                    buttonTitle: AppStrings.sendTippz, onTap: () {

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
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/utils/app_colors.dart';

class SortOptions extends StatelessWidget {
  final String selectedSortBy;
  final String selectedOrder;
  final bool isDropdownOpen;
  final bool isName;
  final List<String> sortByOptions;
  final VoidCallback toggleDropdown;
  final Function(String) selectSortBy;
  final VoidCallback toggleOrder;

  const SortOptions({super.key,
    required this.selectedSortBy,
    required this.selectedOrder,
    required this.isDropdownOpen,
    required this.sortByOptions,
    required this.toggleDropdown,
    required this.selectSortBy,
    required this.toggleOrder, required this.isName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CustomText(
              text: "Sort By:",
              color: AppColors.gray500,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            const SizedBox(width: 10),
            isName==true?
            GestureDetector(
              onTap: toggleDropdown,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.green500),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(selectedSortBy),
                    Icon(
                      isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ):SizedBox(),
            Gap(10.w),
            GestureDetector(
              onTap: toggleOrder,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.green500),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(selectedOrder),
                    Gap(10.w),
                    Assets.icons.dropdown.svg(),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (isDropdownOpen)
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.green500),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: sortByOptions.map((option) {
                return GestureDetector(
                  onTap: () => selectSortBy(option),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(option),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
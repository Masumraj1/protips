import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/history_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/history_card/history_card.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class HistoryScreen extends StatelessWidget {


  HistoryScreen({super.key});

   final HistoryController historyController = Get.find<HistoryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
        bottomNavigationBar: const NavBar(currentIndex: 3,),
        ///==========================Tipz History==============
        appBar: const CustomAppBar(
      appBarContent: AppStrings.tippzHistory,
      iconData: Icons.arrow_back,
    ),
      body: ListView.builder(
        itemCount: historyController.historyData.length,
        itemBuilder: (context, index) {
          final item = historyController.historyData[index];
          return HistoryCard(
            isImage: true,
            imageUrl: item['imageUrl'],
            title: item['title'],
            date: item['date'],
            points: item['points'],
            amount: item['amount'],
          );
        },
      ),
    );
  }
}

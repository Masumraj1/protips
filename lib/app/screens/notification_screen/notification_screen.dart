import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/notification_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';
import 'package:protippz/app/screens/tippz_history_screen/inner_widget/history_card.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_strings.dart';

class NotificationScreen extends StatelessWidget {


  NotificationScreen({super.key});

  final NotificationController _notificationController = Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      bottomNavigationBar: const NavBar(currentIndex: 1,),
      appBar: const CustomAppBar(
        appBarContent: AppStrings.notification,
        iconData: Icons.arrow_back,
      ),
      body: ListView.builder(
        itemCount: _notificationController.historyData.length,
        itemBuilder: (context, index) {
          final item = _notificationController.historyData[index];
          return HistoryCard(
            imageUrl: item['imageUrl'],
            title: item['title'],
            date: item['date'],
            time: item['time'],
          );
        },
      ),
    );
  }
}

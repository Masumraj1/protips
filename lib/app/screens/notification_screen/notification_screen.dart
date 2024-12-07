import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/notification_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/global/widgets/history_card/history_card.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController _notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      bottomNavigationBar: const NavBar(
        currentIndex: 1,
      ),

      ///====================Notification=================
      appBar: const CustomAppBar(
        appBarContent: AppStrings.notification,
        iconData: Icons.arrow_back,
      ),
      body: Obx(() {
        switch (_notificationController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(onTap: () {
              _notificationController.notification();
            });

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                _notificationController
                    .notification(); // Retry fetching data on error
              },
            );

          case Status.completed:
            // Show empty state if no notifications are found
            if (_notificationController.notificationList.isEmpty) {
              return const Center(
                child: CustomText(
                  text: "No Data Found",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.gray500,
                ),
              );
            }

            // Show list of notifications
            return ListView.builder(
              itemCount: _notificationController.notificationList.length,
              itemBuilder: (context, index) {
                final item = _notificationController.notificationList[index];
                return HistoryCard(
                  isImage: true,
                  imageUrl: '',
                  // Provide image URL if required
                  title: item.title.toString(),
                  date: item.createdAt.toString(),
                  time: item.message,
                );
              },
            );
        }
      }),
    );
  }
}

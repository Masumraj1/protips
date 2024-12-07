import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/notification_controller.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/global/helper/date_converter/date_converter.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
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
            return Column(
              children: [
                // Button to mark all notifications as read/unread
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: _notificationController
                          .toggleAllNotificationsReadStatus,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green500,
                      ),
                      child: CustomText(
                        text: _notificationController.isAllRead.value
                            ? "Mark As Unread"
                            : "Mark As Read",
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // List of notifications
                Expanded(
                  child: ListView.builder(
                    itemCount: _notificationController.notificationList.length,
                    itemBuilder: (context, index) {
                      final item =
                          _notificationController.notificationList[index];
                      String bdTime = DateConverter.convertToBDTime(item.createdAt.toString());

                      return Column(
                        children: [

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Assets.icons.notificationSelected
                                    .svg(height: 40),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        textAlign: TextAlign.start,
                                        text: item.title.toString(),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: item.seen == false
                                            ? AppColors
                                                .blue500 // Blue for unseen
                                            : AppColors
                                                .gray300, // Gray for seen
                                      ),
                                      SizedBox(height: 8.h),
                                      CustomText(
                                        textAlign: TextAlign.start,
                                        text: item.message.toString(),
                                        fontSize: 14,
                                        maxLines: 10,
                                        fontWeight: FontWeight.w300,
                                        color: item.seen == false
                                            ? AppColors
                                                .blue500 // Blue for unseen
                                            : AppColors
                                                .gray300, // Gray for seen
                                      ),
                                      SizedBox(height: 8.h),
                                      CustomText(
                                        textAlign: TextAlign.start,
                                        text: bdTime,
                                        fontSize: 14,
                                        maxLines: 10,
                                        fontWeight: FontWeight.w300,
                                        color: item.seen == false
                                            ? AppColors
                                            .blue500 // Blue for unseen
                                            : AppColors
                                            .gray300, // Gray for seen
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          const Divider(color: AppColors.gray300),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
        }
      }),
    );
  }
}

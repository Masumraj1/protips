import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/history_controller.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/helper/date_converter/date_converter.dart';
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

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final HistoryController historyController = Get.find<HistoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bg500,
        bottomNavigationBar: const NavBar(
          currentIndex: 3,
        ),

        ///==========================Tipz History appbar==============
        appBar: const CustomAppBar(
          appBarContent: AppStrings.tippzHistory,
          iconData: Icons.arrow_back,
        ),
        body: Obx(() {
          switch (historyController.rxRequestStatus.value) {
            case Status.loading:
              return const CustomLoader(); // Show loading indicator

            case Status.internetError:
              return NoInternetScreen(onTap: () {
                historyController.getMyTips();
              });

            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  historyController.getMyTips(); // Retry fetching data on error
                },
              );

            case Status.completed:
            // Show empty state if no notifications are found
              if (historyController.tipsHistoryList.isEmpty) {
                return const Center(
                  child: CustomText(
                    text: "No Data Found",
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.gray500,
                  ),
                );
              }
              return ListView.builder(
                itemCount: historyController.tipsHistoryList.length,
                itemBuilder: (context, index) {
                  final item = historyController.tipsHistoryList[index];
                  return HistoryCard(
                    isImage: true,
                    imageUrl: "${ApiUrl.netWorkUrl}${item.entity?.playerImage ?? ""}",
                    title: item.entity?.name ?? "",
                    date: DateConverter.formatDate(item.createdAt.toString()),
                    points: item.point,
                    amount: item.amount.toString(),
                  );
                },
              );
          }
        }));
  }
}

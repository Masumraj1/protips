import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/payment_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/custom_loader/custom_loader.dart';
import 'package:protippz/app/global/widgets/custom_text/custom_text.dart';
import 'package:protippz/app/global/widgets/genarel_error/genarel_error.dart';
import 'package:protippz/app/global/widgets/history_card/history_card.dart';
import 'package:protippz/app/screens/no_internet_screen/no_internet_screen.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class TransactionScreen extends StatelessWidget {
   TransactionScreen({super.key});


  final PaymentController  paymentController = Get.find<PaymentController>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.bg500,
      appBar: const CustomAppBar(
        appBarContent: AppStrings.transactionLog,
        iconData: Icons.arrow_back,
      ),
      body:   Obx(() {
        switch (paymentController.rxRequestStatus.value) {
          case Status.loading:
            return const CustomLoader(); // Show loading indicator

          case Status.internetError:
            return NoInternetScreen(onTap: () {
              paymentController.transaction();
            });

          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                paymentController.transaction();// Retry fetching data on error
              },
            );

          case Status.completed:
          // Show empty state if no notifications are found
            if (paymentController.transactionList.isEmpty) {
              return const Center(
                child: CustomText(
                  text: "No Data Found",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.gray500,
                ),
              );
            }
            return      ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            final item = paymentController.transactionList[index];
            return  HistoryCard(
              isImage: false,
              title:item.transactionType??"",
              date: 'd',
              time:item.amount.toString(),
            );
          },
        );
        }
      }));


  }
}

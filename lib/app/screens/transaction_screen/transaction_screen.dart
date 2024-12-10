import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/controller/payment_controller.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/global/widgets/history_card/history_card.dart';
import 'package:protippz/app/utils/app_colors.dart';
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
      // body: ListView.builder(
      //   itemCount: paymentController.transactionList.length,
      //   itemBuilder: (context, index) {
      //     final item = paymentController.transactionList[index];
      //     return HistoryCard(
      //       isImage: false,
      //       title: item['title'],
      //       date: item['date'],
      //       time: item['time'],
      //     );
      //   },
      // ),
    );
  }
}

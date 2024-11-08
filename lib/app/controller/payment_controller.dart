import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';

class  PaymentController extends GetxController{
  final List<Map<String, dynamic>> transactionList = [
    {
      'title': 'Deposit Funds',
      'date': '09/08/24',
      'time': "\$200.00",
    },
    {
      'title': 'Withdraw Funds',
      'date': '28/08/24',
      'time': "\$200.00",
    },
    {
      'title': 'Deposit Funds',
      'date': '09/08/24',
      'time': "\$150.00",
    },
    {
      'title': 'Withdraw Funds',
      'date': '28/08/24',
      'time': "\$150.00",
    },
  ];


  ///=======================Static deposite ======================
  final List<Map<String, dynamic>> paymentMethods = [
    {
      "title": "Credit/Debit Card",
      "value": "credit_card",
      "icon": Row(
        children: [
          Assets.images.visa.image(),
          const SizedBox(width: 8),
          Assets.images.paypal.image(),
        ],
      ),
    },
    {
      "title": "Paypal",
      "value": "paypal",
      "icon": Assets.images.paypal.image(),
    },
  ];
  ///=======================Static withdraw ======================
  final List<Map<String, dynamic>> withdrawMethod = [
    {
      "title": "Credit/Debit Card",
      "value": "credit_card",
      "icon": Row(
        children: [
          Assets.images.visa.image(),
          const SizedBox(width: 8),
          Assets.images.paypal.image(),
        ],
      ),
    },
    {
      "title": "ACH",
      "value": "ach",
      "icon": Assets.images.ach.image(),
    },

    {
      "title": "Check",
      "value": "check",
      "icon": Assets.images.check.image(),
    },
  ];
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
}
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_constants.dart';

class PaypalController extends GetxController {
  ///=============================== PayPal Payment Method ======================
  void paymentPaypal({
    required double amount,
    // required String driverId,
    // required String tripId,
  }) {
    var transactions = [
      {
        "amount": {
          "total": amount.toStringAsFixed(2), // Dynamic amount
          "currency": "USD", // Hardcoded currency for now
        },
        "description": "The payment transaction description.",
      }
    ];

    if (kDebugMode) {
      print("=========Transaction Data:========================================== $transactions");
    }

    // Navigate to PayPal Checkout view
    Get.to(
          () => PaypalCheckoutView(
        clientId: AppConstants.clientId,
        sandboxMode: true,
        secretKey: AppConstants.clientSecret,
        transactions: transactions,
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          toastMessage(message: 'Payment Successfully Completed');

          // Extract the PayPal transaction ID and order details from the response
          String orderId = params['data']['cart'];
          String transactionId = params['data']['transactions'][0]
          ['related_resources'][0]['sale']['id'];
          String payerName =
              "${params['data']['payer']['payer_info']['first_name']} ${params['data']['payer']['payer_info']['last_name']}";

          if (kDebugMode) {
            print("======onSuccess: Payment Data$params");
            debugPrint("============================PAYID========: $orderId", wrapWidth: 1024);
            debugPrint("======================Payer Name: $payerName", wrapWidth: 1024);
            debugPrint("====================Amount: $amount", wrapWidth: 1024);
          }

          // Call the payment method to save the transaction data
          paymentMethod(paymentId: transactionId,
              payerId: params['data']['payer']['payer_info']['payer_id']);

          // Close the payment screen
          Navigator.pop(Get.context!);
        },
        onError: (error) {
          Navigator.pop(Get.context!); // Close the payment screen
          toastMessage(message: 'Something went wrong, Try again!');
          if (kDebugMode) {
            print("onError: $error");
          }
        },
        onCancel: () {
          Navigator.pop(Get.context!); // Close the payment screen
          toastMessage(message: 'Payment cancelled');
          if (kDebugMode) {
            print('Payment cancelled by user');
          }
        },
      ),
    );
  }

  ///=============================== Payment Method Function =====================

  RxBool isPayment = false.obs;

  Future<void> paymentMethod({
    required String paymentId,
    required String payerId,
  }) async {
    isPayment.value = true;
    refresh();

    Map<String, dynamic> body = {
      "paymentId": paymentId,
      "payerId": payerId,
    };

    var response = await ApiClient.postData(ApiUrl.paypalIntend, jsonEncode(body));

    if (response.statusCode == 200) {
      isPayment.value = false;
      refresh();
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }

    isPayment.value = false;
    refresh();
  }
}

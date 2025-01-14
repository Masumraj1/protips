import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_constants.dart';

class DairekPayController extends GetxController {
  ///========================= Create Payment Intent =========================
  Map<String, dynamic> value = {};

  Future<Map<String, dynamic>> createPaymentIntent(
      {required int amount,
      required String id,
      required String playerOrTeamId}) async {
    var bearerToken =
        await SharePrefsHelper.getString(AppConstants.bearerToken);

    var mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': '$bearerToken'
    };
    var body = {
      "entityId": id,
      "entityType": playerOrTeamId,
      "amount": amount,
      "tipBy": "Credit card"
    };

    try {
      var response = await ApiClient.postData(ApiUrl.sendTip, jsonEncode(body),
          headers: mainHeaders);

      debugPrint(
          "==============Payment Intent Response ===========${response.body}");

      if (response.statusCode == 201) {
        var data = response.body["data"];
        value = data; // Save response data for later usage
        String paymentIntentId = data["paymentIntentId"] ?? '';
        if (paymentIntentId.isNotEmpty) {
          debugPrint("Payment Intent ID: $paymentIntentId");
        } else {
          debugPrint(
              "========================Payment Intent ID not found.====================");
        }

        return value; // Return the payment intent data
      } else {
        ApiChecker.checkApi(response);
        return {}; // Return an empty map if something goes wrong
      }
    } catch (error) {
      debugPrint(
          "======================Error creating payment intent:====================== $error");
      Get.snackbar("", 'Payment Canceled');
      return {}; // Handle the error and return empty
    }
  }

  ///========================= Make Payment =========================

  Future<void> makePayment(
      {required int amount,
      required String id,
      required String playerOrTeamId}) async {
    try {
      Map<String, dynamic> paymentIntentData = await createPaymentIntent(
          amount: amount, id: id, playerOrTeamId: playerOrTeamId);

      if (paymentIntentData.isNotEmpty) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            merchantDisplayName: 'Masum',
            // Replace with your merchant name
            paymentIntentClientSecret: paymentIntentData['clientSecret'],
            // Use the retrieved clientSecret
            allowsDelayedPaymentMethods: true,
            style: ThemeMode.light,
          ),
        );

        debugPrint(
            "========================Payment Sheet Initialized=========================");

        await Stripe.instance.presentPaymentSheet();

        debugPrint(
            "=========================Payment Sheet Presented===================");

        final paymentIntent = await Stripe.instance
            .retrievePaymentIntent(paymentIntentData['clientSecret']);

        debugPrint(
            "=========================Fetched PaymentIntent===========================");
        debugPrint("PaymentIntent Data: $paymentIntent");
        String transactionId = paymentIntent.id; // Stripe's PaymentIntent ID
        String status =
            paymentIntent.status.name; // Payment status (e.g., "succeeded")

        debugPrint(
            "=================================Transaction ID: $transactionId");
        debugPrint("=================================Payment Status: $status");
        if (status.toLowerCase() == "succeeded") {
          await makeOrder(
            transactionId: transactionId,
          );

          toastMessage(message: "Payment Successful");
          debugPrint("============================Payment Successful");
        } else {
          toastMessage(message: "Payment failed or incomplete.");
          debugPrint(
              "====================================Payment failed or incomplete.");
        }
      }
    } catch (e) {
      debugPrint("Error in makePayment: ${e.toString()}");
      toastMessage(message: " " "Your Payment Canceled");
    }
  }

  ///============================ Send Response to server ==============================

  Future<void> makeOrder({
    required String transactionId,
  }) async {
    Map<String, dynamic> body = {
      "transactionId": transactionId,
    };

    try {
      var response = await ApiClient.patchData(
        ApiUrl.stripeDeposit,
        jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("============================${response.body}");
        toastMessage(message: response.body["message"]);
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (error) {
      debugPrint(
          "=======================Error sending payment data to server: $error");
      Get.snackbar("Error", "Unable to complete order: $error");
    }
  }

  ///===================================Paypal=================================
  ///=============================== PayPal Payment Method ======================
  void paymentPaypal(
      {required double amount,
      required String playerId,
      required String entityType}) {
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
      print(
          "=========Transaction Data:========================================== $transactions");
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
          // Extract Payment Data
          String orderId = params['data']['cart'];
          String paymentId = params['data']['id'];
          String payerName =
              "${params['data']['payer']['payer_info']['first_name']} ${params['data']['payer']['payer_info']['last_name']}";

          // Debugging output
          if (kDebugMode) {
            debugPrint("======onSuccess: Payment Data$params");
            debugPrint("Order ID: $orderId");
            debugPrint("Payer Name: $payerName");
            debugPrint("Amount: $amount");
          }

          // Process payment method after successful transaction
          await paymentMethod(
            paymentId: paymentId,
            payerId: params['data']['payer']['payer_info']['payer_id'],
            playerId: playerId,
            entityType: entityType,
          );

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

  Future<void> paymentMethod(
      {required String paymentId,
      required String payerId,
      required String playerId,
      required String entityType}) async {
    isPayment.value = true;
    refresh();

    // Ensure valid parameters
    if (paymentId.isEmpty || payerId.isEmpty || playerId.isEmpty) {
      toastMessage(message: 'Invalid payment or player information.');
      isPayment.value = false;
      refresh();
      return;
    }

    Map<String, dynamic> body = {
      "paymentId": paymentId,
      "payerId": payerId,
      "entityId": playerId,
      "entityType": entityType
    };

    var response =
        await ApiClient.patchData(ApiUrl.paypalSend, jsonEncode(body));

    // Handle the response from API
    if (response.statusCode == 200) {
      isPayment.value = false;
      refresh();
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }

    // Reset payment status
    isPayment.value = false;
    refresh();
  }
}

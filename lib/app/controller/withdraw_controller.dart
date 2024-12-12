import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';

class WithdrawController extends GetxController {

           TextEditingController bankAccountNumberController = TextEditingController();
           TextEditingController bankRoutingTypeController = TextEditingController();
           TextEditingController routingNumberController = TextEditingController();
           TextEditingController accountTypeController = TextEditingController();
           TextEditingController bankNameController = TextEditingController();
           TextEditingController accountHolderNameController = TextEditingController();
           TextEditingController amountController = TextEditingController();
           TextEditingController fullNameController = TextEditingController();
           TextEditingController addressController = TextEditingController();
           TextEditingController cityController = TextEditingController();
           TextEditingController stateController = TextEditingController();
           TextEditingController zipCodeController = TextEditingController();
           TextEditingController emailController = TextEditingController();
  ///================================Withdraw Ach===============================
  RxBool isAchLoading = false.obs;

  withdrawAchMethod() async {
    isAchLoading.value = true;
    refresh();
    Map<String, dynamic> body = {
      "amount": int.tryParse(amountController.text),
      "withdrawOption": "ACH",
      "bankAccountNumber":  int.tryParse(bankAccountNumberController.text),
      "routingNumber": int.tryParse(routingNumberController.text),
      "accountType": accountTypeController.text,
      "bankName": bankNameController.text,
      "accountHolderName": accountHolderNameController.text
    };
    var response = await ApiClient.postData(
      ApiUrl.withdrawFunds,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      Get.back();
      toastMessage(
        message: response.body["message"],
      );
    } else if (response.statusCode == 401) {
      ApiChecker.checkApi(response);
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isAchLoading.value = false;
    refresh();
  }


  ///================================Withdraw Check===============================
  RxBool isCheckLoading = false.obs;

  withdrawCheckMethod() async {
    isCheckLoading.value = true;
    refresh();
    Map<String, dynamic> body = {
      "amount": int.tryParse(amountController.text),
      "withdrawOption": "Check",
      "fullName":fullNameController.text,
      "streetAddress": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "zipCode": int.tryParse(zipCodeController.text),
      "email": emailController.text
    };
    var response = await ApiClient.postData(
      ApiUrl.withdrawFunds,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      Get.back();
      toastMessage(
        message: response.body["message"],
      );
    } else if (response.statusCode == 401) {
      ApiChecker.checkApi(response);
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isCheckLoading.value = false;
    refresh();
  }
}

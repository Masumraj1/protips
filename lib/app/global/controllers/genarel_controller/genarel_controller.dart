import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/models/league_model/league_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_constants.dart';

class GeneralController extends GetxController {
  ///==============================ContactUs==========================
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  ///================ Contact Us method=============================
  RxBool isContactLoading = false.obs;

  contactUs() async {
    if (!isValidInput()) {
      toastMessage(message: "Please fill in all the required fields");
      return;
    }
    isContactLoading.value = true;
    try {
      Map<String, String> body = {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
        "message": messageController.text,
      };
      var response = await ApiClient.postData(
        ApiUrl.contactUs,
        jsonEncode(body),
      );
      if (response.statusCode == 200) {
        clearInputFields();
        Get.back();
        toastMessage(message: response.body["message"]);
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      toastMessage(message: "Something went wrong: $e");
    } finally {
      isContactLoading.value = false;
    }
  }

  ///================ Validate user input=============================
  bool isValidInput() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        messageController.text.isNotEmpty;
  }

  ///============================= Clear input fields====================
  void clearInputFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    messageController.clear();
  }

  ///==============*********>>>>>>>>GetLeague<<<<<<<********===

  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxList<LeagueList> leagueList = <LeagueList>[].obs;

  getLeague() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getAllLeague);

    if (response.statusCode == 200) {
      leagueList.value = List<LeagueList>.from(
          response.body["data"]["result"].map((x) => LeagueList.fromJson(x)));

      debugPrint(
          'LeagueList=======================${response.body["data"]["result"]}');
      setRxRequestStatus(Status.completed);
      refresh();
    } else {
      if (response.statusText == ApiClient.noInternetMessage) {
        setRxRequestStatus(Status.internetError);
      } else {
        setRxRequestStatus(Status.error);
      }
      ApiChecker.checkApi(response);
    }
  }


  @override
  void onInit() {
    getLeague();
    super.onInit();
  }

}

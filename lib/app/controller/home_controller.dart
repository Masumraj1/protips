import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/models/reward_model/rewadz_model.dart';
import 'package:protippz/app/data/models/reward_model/selected_reward_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_constants.dart';

class HomeController extends GetxController {

  ///==============*********>>>>>>>>Other Element<<<<<<<********===
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///==============*********>>>>>>>>GetReward<<<<<<<********===
  RxList<RewardList> rewardList = <RewardList>[].obs;

  getReward() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getReward);

    if (response.statusCode == 200) {
      rewardList.value = List<RewardList>.from(
          response.body["data"]["result"].map((x) => RewardList.fromJson(x)));

      debugPrint(
          'GetReward=======================${response.body["data"]["result"]}');
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



  ///==============*********>>>>>>>>SearchMethod<<<<<<<********===
  TextEditingController searchController = TextEditingController();

  searchReward({required String search,required String id}) async {
    setRxRequestStatus(Status.loading);
    selectRewardList.refresh();
    var response = await ApiClient.getData("${ApiUrl.searchReward}=$search${"&category=$id"}");
    selectRewardList.refresh();
    if (response.statusCode == 200) {
      selectRewardList = RxList<SelectRewardList>.from(response.body["data"]
              ['result']
          .map((x) => SelectRewardList.fromJson(x)));
      setRxRequestStatus(Status.completed);
      selectRewardList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  ///==============*********>>>>>>>>SelectReward<<<<<<<********===
  Rx<int?> selectedIndex = Rx<int?>(null); // Track selected index

  RxList<SelectRewardList> selectRewardList = <SelectRewardList>[].obs;
  var selectedRewardId = ''.obs; // Store the selected reward ID

  selectedReward({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.selectReward(id: id));

    if (response.statusCode == 200) {
      selectRewardList.value = List<SelectRewardList>.from(response.body["data"]
              ['result']
          .map((x) => SelectRewardList.fromJson(x)));
      selectedRewardId.value = id;
      print(
          'SelectRewardList=========================="${selectRewardList.length}"');
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

  ///==============*********>>>>>>>>RedeemCreateShirt<<<<<<<********===
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  RxBool isSubmit = false.obs;

  redeemCreate({required String rewardId, required String categoryId}) async {
    isSubmit.value = true;
    refresh();
    Map<String, String> body = {
      "reward": rewardId,
      "category": categoryId,
      "userName": fullNameController.text,
      "phone": phoneController.text,
      "streetAddress": streetController.text,
      "city": cityController.text,
      "state": stateController.text,
      "zipCode": zipCodeController.text
    };

    var response = await ApiClient.postData(
      ApiUrl.redeemCreate,
      jsonEncode(body),
    );
    if (response.statusCode == 201) {
      clearInputFields();
      Get.back();
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isSubmit.value = false;
  }
  //===============Clear field=============================================
  void clearInputFields() {
    fullNameController.clear();
    streetController.clear();
    cityController.clear();
    stateController.clear();
    phoneController.clear();
    zipCodeController.clear();
  }

  ///==============*********>>>>>>>>VeryFy Email<<<<<<<********===
  RxString rewardIdd = ''.obs;
  TextEditingController emailController = TextEditingController();
  RxBool isSendCode = false.obs;
  veryFyEmail({required String rewardId, required String categoryId}) async {
    isSendCode.value = true;
    refresh();

    Map<String, String> body = {
      "reward": rewardId,
      "category": categoryId,
      "email": emailController.text
    };

    var response = await ApiClient.postData(
      ApiUrl.redeemCreate,
      jsonEncode(body),
    );

    if (response.statusCode == 201) {
      emailController.clear();
      // Save the rewardId globally (using RxString for reactive state)
      this.rewardIdd.value = response.body['data']['_id'];
      print("Id=================================$rewardIdd");

      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }

    isSendCode.value = false;
    refresh();
  }

  ///==============*********>>>>>>>>VeryFyOtp<<<<<<<********===
  TextEditingController pinController = TextEditingController();
  String resetCodeInput = ""; // Example input for the reset code

  RxBool isVeryFyOtp = false.obs;

  veryFyOtp() async {
    if (resetCodeInput.isEmpty) {
      toastMessage(message: "Please enter the OTP.");
      return;
    }

    isVeryFyOtp.value = true;
    refresh();
    int resetCode = int.tryParse(resetCodeInput) ?? 0;

    Map<String, dynamic> body = {
      "verifyCode": resetCode
    };

    var response = await ApiClient.postData(
      ApiUrl.veryFyRedeemOtp(id: rewardIdd.value), // Access rewardId globally
      jsonEncode(body),
    );

    isVeryFyOtp.value = false;
    refresh();

    if (response.statusCode == 201) {
        pinController.clear();
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }

    isVeryFyOtp.value = false;
    refresh();
  }







  @override
  void onInit() {
    getReward();
    super.onInit();
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:protippz/app/utils/app_strings.dart';

class AuthController extends GetxController {
  ///=======================Remember me ========================
  RxBool isRemember = false.obs;

  toggleRemember() {
    isRemember.value = !isRemember.value;
    debugPrint("Remember me==============>>>>>>>>>$isRemember");
    refresh();
    SharePrefsHelper.setBool(AppConstants.isRememberMe, isRemember.value);
  }

  ///============================All Controller =====================
  TextEditingController emailController =
      TextEditingController(text: kDebugMode ? "masumrna927@gmail.com" : "");
  TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? "Masum017" : "");
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  ///==================================SignUp Method=======================
  RxBool isSignUpLoading = false.obs;

  signUp() async {
    isSignUpLoading.value = true;
    refresh();
    Map<String, dynamic> body = {
      "password": passwordController.text,
      "confirmPassword": confirmPasswordController.text,
      "userData": {
        "name": nameController.text,
        "username": userNameController.text,
        "phone": phoneNumberController.text,
        "email": emailController.text,
        "address": addressController.text,
        "inviteToken": referralController.text
      }
    };
    var response = await ApiClient.postData(
      ApiUrl.signupAuth,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      Get.toNamed(AppRoute.otpScreen, parameters: {
        AppStrings.signUp: "true",
        AppStrings.email: emailController.text,
      });
      toastMessage(
        message: response.body["message"],
      );
    } else if (response.status == 400) {
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isSignUpLoading.value = false;
    refresh();
  }

  ///============================== LogIn ================================
  RxBool isSignInLoading = false.obs;

  signInUser() async {
    isSignInLoading.value = true;
    refresh();
    Map<String, String> body = {
      "userNameOrEmail": emailController.text,
      "password": passwordController.text
    };
    var response = await ApiClient.postData(
      ApiUrl.signIn,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      SharePrefsHelper.setString(
          AppConstants.bearerToken, response.body['data']["accessToken"]);

      debugPrint(
          '======================token   ${response.body['data']['accessToken']}');
      Get.toNamed(AppRoute.homeScreen);
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
    isSignInLoading.value = false;
    refresh();
  }

  ///============================== resetPassword ================================
  RxBool isResend = false.obs;

  resetPassword() async {
    isResend.value = true;
    refresh();
    Map<String, String> body = {
      "email": emailController.text,
      "password": passwordController.text,
      "confirmPassword": confirmPasswordController.text
    };
    var response = await ApiClient.postData(
      ApiUrl.resetPassword,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      // SharePrefsHelper.setString(AppConstants.bearerToken, response.body["token"]);

      Get.offAllNamed(AppRoute.signInScreen);
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
    isResend.value = false;
    refresh();
  }

  ///============================ Forget Password ==========================

  RxBool isForgetLoading = false.obs;

  forgetPassword() async {
    isForgetLoading.value = true;
    refresh();
    Map<dynamic, String> body = {"email": emailController.text};
    var response =
        await ApiClient.postData(ApiUrl.forgotPassword, jsonEncode(body));
    isForgetLoading.value = false;
    refresh();
    if (response.statusCode == 200) {
      // emailController.clear();
      Get.toNamed(
        AppRoute.otpScreen,
        parameters: {
          AppStrings.signUp: "false",
          AppStrings.email: emailController.text, // Use a proper key for email
        },
      );

      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isForgetLoading.value = false;
    refresh();
  }

  ///=====================Sign up Otp==========================================
  String activationCode = "";
  RxBool isSignUpOtp = false.obs;

  signUpVerifyOTP() async {
    isSignUpOtp.value = true;
    refresh();
    int resetCode = int.tryParse(activationCode) ?? 0;

    Map<dynamic, dynamic> body = {
      "email": emailController.text,
      "verifyCode": resetCode
    };

    var response =
        await ApiClient.postData(ApiUrl.veryFyCode, jsonEncode(body));
    isSignUpOtp.value = false;
    refresh();
    if (response.statusCode == 200) {
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      nameController.clear();

      SharePrefsHelper.setString(
          AppConstants.bearerToken, response.body['data']["accessToken"]);

      debugPrint(
          '======================token   ${response.body['data']['accessToken']}');
      Get.offAllNamed(AppRoute.homeScreen);
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isSignUpOtp.value = false;
    refresh();
  }

  ///==============================Forget otp=================
  String resetCodeInput = ""; // Example input for the reset code
  RxBool isForget = false.obs;

  forgetOtp() async {
    isForget.value = true;
    refresh();

    // Safely parse the reset code input to an integer
    int resetCode = int.tryParse(resetCodeInput) ?? 0;

    // Create the API body with resetCode as a number
    Map<String, dynamic> body = {
      "email": emailController.text, // Get the email from the controller
      "resetCode": resetCode // Pass resetCode as a number
    };

    print("====> API Body: ${jsonEncode(body)}"); // Debugging the API Body

    var response = await ApiClient.postData(ApiUrl.forgetOtp, jsonEncode(body));

    isForget.value = false;
    refresh();

    if (response.statusCode == 200) {
      // Handle success
      Get.offAllNamed(AppRoute.resetPasswordScreen);
      toastMessage(
        message: response.body["message"],
      );
    } else if (response.statusCode == 401) {
      // Handle unauthorized error
      toastMessage(
        message: response.body["message"],
      );
    } else {
      // Handle other errors
      ApiChecker.checkApi(response);
    }

    isForget.value = false;
    refresh();
  }

  ///=========================================Change password===================
  RxBool isChangeLoading = false.obs;

  changePassword() async {
    isChangeLoading.value = true;
    refresh();
    Map<String, String> body = {
      "oldPassword": oldPasswordController.text,
      "newPassword": newPasswordController.text,
      "confirmNewPassword": confirmPasswordController.text
    };

    var response = await ApiClient.postData(
      ApiUrl.changePassword,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      oldPasswordController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      Get.back();
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isChangeLoading.value = false;
  }

  ///=============================================account delete==========================
  RxBool isDeleteLoading = false.obs;

  deleteAccount() async {
    isDeleteLoading.value = true;
    refresh();
    Map<dynamic, String> body = {"password": passwordController.text};
    var response = await ApiClient.deleteData(ApiUrl.deleteAccount,
        body: jsonEncode(body));

    isDeleteLoading.value = false;
    refresh();
    if (response.statusCode == 200) {
      await SharePrefsHelper.remove(AppConstants.bearerToken);
      toastMessage(message: response.body["message"]);
      Get.offAllNamed(AppRoute.signInScreen);
    } else {
      ApiChecker.checkApi(response);
    }
    isDeleteLoading.value = false;
    refresh();
  }


  ///=============================Resend password========================
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  resentUser() async {
    setRxRequestStatus(Status.loading);
    update();
    Map<String, String> body = {"email": emailController.text};

    var response = await ApiClient.postData(
      ApiUrl.signUpResendOtp,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      setRxRequestStatus(Status.completed);
      toastMessage(message: response.body["message"]);
      update();
      return true;
    } else {
      ApiChecker.checkApi(response);
      update();
      return false;
    }
  }
}

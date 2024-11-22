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

  //============================All Controller =====================
  TextEditingController emailController = TextEditingController(text: kDebugMode?"promotion1":"");
  TextEditingController passwordController = TextEditingController(text: kDebugMode?"Masum017":"");
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
        "address": addressController.text
      }
    };
    var response = await ApiClient.postData(
      ApiUrl.signupAuth,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      Get.toNamed(AppRoute.otpScreen, parameters: {AppStrings.signUp: "true"});
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
      "userNameOrEmail":emailController.text,
      "password":passwordController.text
    };
    var response = await ApiClient.postData(
      ApiUrl.signIn,
      jsonEncode(body),
    );
    if (response.statusCode == 200) {
      // SharePrefsHelper.setString(AppConstants.bearerToken, response.body["token"]);

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
      Get.toNamed(AppRoute.otpScreen, parameters: {AppStrings.signUp: "false"});

      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isForgetLoading.value = false;
    refresh();
  }

  ///=====================Sign up Otp==================
  var activationCode = "";
  RxBool isOtpLoading = false.obs;

  signUpVerifyOTP() async {
    isOtpLoading.value = true;
    refresh();
    Map<dynamic, String> body = {
      "email":emailController.text,
      "verifyCode":activationCode
    };

    var response =
    await ApiClient.postData(ApiUrl.veryFyCode, jsonEncode(body));
    isOtpLoading.value = false;
    refresh();
    if (response.statusCode == 200) {
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      nameController.clear();

      // SharePrefsHelper.setString(
      //     AppConstants.bearerToken, response.body["token"]);
      Get.offAllNamed(AppRoute.homeScreen);
      toastMessage(
        message: response.body["message"],
      );
    } else {
      ApiChecker.checkApi(response);
    }
    isOtpLoading.value = false;
    refresh();
  }

  // ///==============================Forget otp=================
  // var otp = "";
  // RxBool isForget = false.obs;
  //
  // forgetOtp() async {
  //   isForget.value = true;
  //   refresh();
  //   Map<dynamic, String> body = {"email": emailController.text, "code": otp};
  //
  //   var response =
  //   await ApiClient.postData(ApiUrl.verifyCOde, jsonEncode(body));
  //   isForget.value = false;
  //   refresh();
  //   if (response.statusCode == 200) {
  //     SharePrefsHelper.setString(
  //         AppConstants.resetToken, response.body["password_reset_token"]);
  //     // print(
  //     //     '======================This is  User Name ${response.body["data"]['name']}');
  //     print(
  //         '======================User Token Saved::: ${response.body['password_reset_token']}');
  //
  //     Get.offAllNamed(AppRoute.resetPassword);
  //     toastMessage(
  //       message: response.body["message"],
  //     );
  //   } else if (response.statusCode == 401) {
  //     toastMessage(
  //       message: response.body["message"],
  //     );
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   isForget.value = false;
  //   refresh();
  // }

}

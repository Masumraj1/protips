import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/core/app_routes.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/data/services/google_sign_In_service.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';

import '../utils/app_constants.dart';

class GoogleAuthController extends GetxController {
  RxBool isGoogleLogin = false.obs;


  ///=====================================Google sign in================================
  Future googleSignIn() async {
    try {
      final user = await GoogleSignInService.login();
      if (user != null) {
        log('==================Display Name:====================== ${user.displayName}');
        log('================Email:=================== ${user.email}');
        log('================ID:===================== ${user.id}');
        log('=====================Photo URL:================ ${user.photoUrl ?? 'No photo URL available'}');

        final googleAuth = await user.authentication;
        log('Authentication Token: ${googleAuth.idToken}');
        log('Access Token: ${googleAuth.accessToken}');
        await googleAuthCall(user);
      } else {
        log('Google Sign-In failed or user cancelled');
      }
    } catch (exception) {
      log('Google Sign-In error: $exception');
    }
  }


  ///=======================================Google Auth================================
  googleAuthCall(user) async {
    isGoogleLogin.value = true;
    refresh();

    Map<String, String> body = {
      "name": user.displayName ?? '',
      "email": user.email ?? '',
      "profile_image": user.photoUrl ?? '',
      "username": user.email.split('@')[0], // Use the email prefix as username
      "inviteToken": "",  // If you have an actual invite token, replace this
    };

    try {
      var response = await ApiClient.postData(
        ApiUrl.googleAuth,
        jsonEncode(body),

        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer", // Add the token if needed
        },
      );

      if (response.statusCode == 200) {
        // Handle successful response
        SharePrefsHelper.setString(
            AppConstants.bearerToken, response.body['data']["accessToken"]);

        debugPrint('======================token   ${response.body['data']['accessToken']}');
        Get.toNamed(AppRoute.homeScreen);
        toastMessage(
          message: response.body["message"],
        );
      } else if (response.statusCode == 401) {
        // Handle unauthorized error
        ApiChecker.checkApi(response);
        toastMessage(
          message: response.body["message"],
        );
      } else {
        // Handle other errors
        ApiChecker.checkApi(response);
      }
    } catch (error) {
      // Handle any API errors
      log('API Call Error: $error');
      toastMessage(message: 'An error occurred during Google authentication');
    }

    isGoogleLogin.value = false;
    refresh();
  }

}

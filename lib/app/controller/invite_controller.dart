import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/custom_text_field/custom_text_field.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_colors.dart';
import 'package:share_plus/share_plus.dart';

class InviteController extends GetxController {
  ///======================================Invite Friend=====================

  RxBool isInvited = false.obs;

  invited() async {
    isInvited.value = true;
    refresh();

    Map<String, String> body = {};
    var response = await ApiClient.postData(
      ApiUrl.invite,
      jsonEncode(body),
    );

    if (response.statusCode == 201) {
      // Extract the token from the response
      String token = response.body["data"]["token"] ?? "No token available"; // Handle case if no token is found

      // Define Play Store and Apple Store links
      String playStoreLink = "https://play.google.com/store/apps/details?id=com.example.yourapp"; // Update with your app's Play Store link
      String appleStoreLink = "https://apps.apple.com/us/app/your-app-name/id123456789"; // Update with your app's Apple Store link

      // Show dialog on success
      Get.dialog(
        AlertDialog(
          title: const Text("Success"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Token display in a read-only CustomTextField
              const SizedBox(height: 10),
              CustomTextField(
                inputTextStyle: const TextStyle(color: AppColors.gray500),
                readOnly: true,
                fillColor: AppColors.white50,
                textEditingController: TextEditingController(text: token),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: token)).then((_) {
                    // Show toast or dialog to confirm that the token has been copied
                    toastMessage(message: "Token copied to clipboard!");
                  });
                },
                suffixIcon: const Icon(Icons.copy),
              ),
              const SizedBox(height: 10),
              // Play Store link display
              CustomTextField(
                inputTextStyle: const TextStyle(color: AppColors.gray500),
                readOnly: true,
                fillColor: AppColors.white50,
                textEditingController: TextEditingController(text: playStoreLink),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: playStoreLink)).then((_) {
                    // Show toast or dialog to confirm that the link has been copied
                    toastMessage(message: "Play Store link copied!");
                  });
                },
                suffixIcon: const Icon(Icons.copy),
              ),
              const SizedBox(height: 10),
              // Apple Store link display
              CustomTextField(
                inputTextStyle: const TextStyle(color: AppColors.gray500),
                readOnly: true,
                fillColor: AppColors.white50,
                textEditingController: TextEditingController(text: appleStoreLink),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: appleStoreLink)).then((_) {
                    // Show toast or dialog to confirm that the link has been copied
                    toastMessage(message: "Apple Store link copied!");
                  });
                },
                suffixIcon: const Icon(Icons.copy),
              ),
              const SizedBox(height: 10),
              // Share button to share token and Play Store and Apple Store links
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: const Icon(Icons.share, color: AppColors.green500),
                  onPressed: () {
                    // Share the token and both store links when the share button is pressed
                    Share.share(
                      "Invite Token: $token\n\n"
                          "Download our app from the Play Store: $playStoreLink\n\n"
                          "Download our app from the Apple Store: $appleStoreLink",
                    );
                  },
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Get.back();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );

      // Show toast message for invite success
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

    isInvited.value = false;
    refresh();
  }
}

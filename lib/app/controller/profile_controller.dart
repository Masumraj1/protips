import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:protippz/app/data/models/profile_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';

import '../global/widgets/toast_message/toast_message.dart';
import '../utils/app_constants.dart';
import 'package:http/http.dart'as http;

class ProfileController extends GetxController{
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;




  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  ///===============================GetProfile Method=========================

  Rx<ProfileData> profileModel = ProfileData().obs;

  getProfile() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getProfile);
    setRxRequestStatus(Status.completed);
    if (response.statusCode == 200) {
      profileModel.value = ProfileData.fromJson(response.body["data"]);
      setTextFieldValue();
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



  ///===============================================Update Profile Calling Method=================================================///
  String networkImg = "";
  bool updateProfileLoding = false;

  Future<void> multipartRequest(
      {String? imagePath, Map<String, String>? header}) async {
    updateProfileLoding = true;
    update();
    try {
      var request = http.MultipartRequest('PATCH',
          Uri.parse("${ApiUrl.baseUrl}${ApiUrl.profileUpdate}"));

      var data = {
        "name": fullNameController.text,
        "address": addressController.text,
        "phone": phoneNumberController.text,
      };

      request.fields["data"] = jsonEncode(data);

      if (imagePath != null) {
        var mimeType = lookupMimeType(imagePath);

        var img = await http.MultipartFile.fromPath('profile_image', imagePath,
            contentType: MediaType.parse(mimeType!));
        request.files.add(img);
      }

      var token = await SharePrefsHelper.getString(AppConstants.bearerToken);
      request.headers['Authorization'] = "$token";

      var response = await request.send();
      updateProfileLoding = false;
      update();
      print("=====${response.statusCode}++++");
      if (response.statusCode == 200) {
        update();

        var data = await response.stream.bytesToString();
        toastMessage(message: "Profile updated successfully");
        // Get.toNamed(AppRoutes.userProfileScreen);
             Get.back();
        getProfile();

        print("=================> data $data");
        updateProfileLoding = false;
        update();
      } else {
        var data = await response.stream.bytesToString();

        print("=================> data $data");
      }
    } catch (e) {
      print("============> $e");
    }
  }


   ///========================Data pass===================
  setTextFieldValue(){
    fullNameController.text=profileModel.value.name.toString();
    emailController.text=profileModel.value.email.toString();
    addressController.text=profileModel.value.address??"";
    phoneNumberController.text=profileModel.value.phone??"";
    userNameController.text=profileModel.value.username??"";
  }
  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
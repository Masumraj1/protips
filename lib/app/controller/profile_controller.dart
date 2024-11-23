import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:protippz/app/data/models/profile_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';

import '../utils/app_constants.dart';

class ProfileController extends GetxController{
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  ///============================Image picker method================
  RxString image = "".obs;

  Rx<File> imageFile = File("").obs;
  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (getImages != null) {
      imageFile.value = File(getImages.path);
      image.value = getImages.path;
    }
  }



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
      // setTextFieldValue();
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
    getProfile();
    super.onInit();
  }
}
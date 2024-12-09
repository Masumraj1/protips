import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:protippz/app/data/models/profile_model/profile_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/helper/local_db/local_db.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final Rx<Status> rxRequestStatus = Status.loading.obs;
  final RxString imagePath = ''.obs; // Holds the image path
  final Rx<ProfileData> profileModel = ProfileData().obs; // Holds profile data
  RxBool updateProfileLoding = false.obs;

  // TextEditing Controllers for profile fields
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  /// Method to change the request status
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  // Method to update the imagePath in controller (for image picking)
  void setImage(String path) {
    imagePath.value = path;
  }

  /// Fetch profile data from API
  Future<void> getProfile() async {
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

  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (getImages != null) {
      // Update the selected image path directly in the controller
      setImage(getImages.path);
    }
  }
  /// Method to update the profile (including image if available)
  Future<void> multipartRequest({String? imagePath}) async {
    updateProfileLoding.value = true;
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

      // Add image if it exists
      if (imagePath != null && imagePath.isNotEmpty) {
        var mimeType = lookupMimeType(imagePath);
        var img = await http.MultipartFile.fromPath(
          'profile_image',
          imagePath,
          contentType: MediaType.parse(mimeType!),
        );
        request.files.add(img);
      }

      // Get the auth token and set it in the headers
      var token = await SharePrefsHelper.getString(AppConstants.bearerToken);
      request.headers['Authorization'] = "$token";

      var response = await request.send();
      updateProfileLoding.value = false;
      update();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        toastMessage(message: "Profile updated successfully");
        Get.back();
        getProfile();
      } else {
        var data = await response.stream.bytesToString();
        print("Profile update failed: $data");
      }
    } catch (e) {
      print("Error during profile update: $e");
    }
  }

  /// Set the text values in the controllers from the profile data
  void setTextFieldValue() {
    fullNameController.text = profileModel.value.name.toString();
    emailController.text = profileModel.value.email.toString();
    addressController.text = profileModel.value.address ?? "";
    phoneNumberController.text = profileModel.value.phone ?? "";
    userNameController.text = profileModel.value.username ?? "";

  }

  /// Initialize the profile when the controller is loaded
  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}


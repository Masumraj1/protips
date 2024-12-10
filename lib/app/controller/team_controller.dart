import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/models/team_model/select_team_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_constants.dart';

class TeamController extends GetxController {
  ///==============*********>>>>>>>>Other Element<<<<<<<********===
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///==============*********>>>>>>>>selectTeam<<<<<<<********===
  Rx<int?> selectedIndex = Rx<int?>(null); // Track selected index

  RxList<SelectTeamList> selectTeamList = <SelectTeamList>[].obs;
  var selectTeamId = ''.obs; // Store the selected reward ID

  selectTeam({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.selectTeam(id: id));

    if (response.statusCode == 200) {
      selectTeamList.value = List<SelectTeamList>.from(response.body["data"]
              ['result']
          .map((x) => SelectTeamList.fromJson(x)));
      selectTeamId.value = id;
      print(
          'selectTeamList=========================="${selectTeamList.length}"');
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

  ///===============================Search Method=================
  TextEditingController searchController = TextEditingController();

  searchTeam({required String search, required String id}) async {
    setRxRequestStatus(Status.loading);
    selectTeamList.refresh();
    var response =
        await ApiClient.getData("${ApiUrl.searchTeam}=$search${"&league=$id"}");
    selectTeamList.refresh();
    if (response.statusCode == 200) {
      selectTeamList = RxList<SelectTeamList>.from(response.body["data"]
              ['result']
          .map((x) => SelectTeamList.fromJson(x)));
      setRxRequestStatus(Status.completed);
      selectTeamList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  ///=====================================Team Bookmark===========================
  RxBool isBookmark = false.obs;

  teamBookmark({required String teamId}) async {
    isBookmark.value = true;
    refresh();
    Map<String, dynamic> body = {"teamId": teamId};
    var response = await ApiClient.postData(
      ApiUrl.bookMarkTeam,
      jsonEncode(body),
    );
    if (response.statusCode == 201) {
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
    isBookmark.value = false;
    refresh();
  }

  ///==================================Team Bookmark Delete=======================
  RxBool isTeamRemove = false.obs;

  teamBookmarkDelete({required String id}) async {
    isTeamRemove.value = true;
    refresh();
    Map<dynamic, String> body = {};
    var response = await ApiClient.deleteData(
        ApiUrl.removeTeamBookmark(id: id),
        body: jsonEncode(body));

    isTeamRemove.value = false;
    refresh();
    if (response.statusCode == 200) {
      toastMessage(message: response.body["message"]);
    } else {
      ApiChecker.checkApi(response);
    }
    isTeamRemove.value = false;
    refresh();
  }
}

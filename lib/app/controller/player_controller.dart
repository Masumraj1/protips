import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:protippz/app/data/models/player_model/select_player_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/global/widgets/toast_message/toast_message.dart';
import 'package:protippz/app/utils/app_constants.dart';

class PlayerController extends GetxController{
  ///==============*********>>>>>>>>Other Element<<<<<<<********===
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;



  ///==============*********>>>>>>>>selectPlayer<<<<<<<********===
  Rx<int?> selectedIndex = Rx<int?>(null); // Track selected index

  RxList<SelectedPlayerList> selectPlayerList = <SelectedPlayerList>[].obs;
  var selectPlayerId = ''.obs; // Store the selected reward ID

  selectPlayer({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.selectPlayer(id: id));

    if (response.statusCode == 200) {
      selectPlayerList.value = List<SelectedPlayerList>.from(response.body["data"]
      ['result']
          .map((x) => SelectedPlayerList.fromJson(x)));
      selectPlayerId.value = id;
      print(
          'SelectPlayerList=========================="${selectPlayerList.length}"');
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

  searchPlayer({required String search,required String id}) async {
    setRxRequestStatus(Status.loading);
    selectPlayerList.refresh();
    var response = await ApiClient.getData("${ApiUrl.searchPlayer}=$search${"&league=$id"}");
    selectPlayerList.refresh();
    if (response.statusCode == 200) {
      selectPlayerList = RxList<SelectedPlayerList>.from(response.body["data"]
      ['result']
          .map((x) => SelectedPlayerList.fromJson(x)));
      setRxRequestStatus(Status.completed);
      selectPlayerList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }


  ///=====================================Player Bookmark===========================
  RxBool isBookmark = false.obs;

  playerBookMark({required String playerId}) async {
    isBookmark.value = true;
    refresh();
    Map<String, dynamic> body ={
      "playerId":playerId
    };
    var response = await ApiClient.postData(
      ApiUrl.bookMarkPlayer,
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
}
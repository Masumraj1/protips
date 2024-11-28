import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/models/league_model.dart';
import 'package:protippz/app/data/models/player_model.dart';
import 'package:protippz/app/data/models/select_player_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/utils/app_constants.dart';

class PlayerController extends GetxController{
  ///==============*********>>>>>>>>Other Element<<<<<<<********===
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  ///==============*********>>>>>>>>GetLeague<<<<<<<********===
  RxList<LeagueList> leagueList = <LeagueList>[].obs;

  getLeague() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getAllLeague);

    if (response.statusCode == 200) {
      leagueList.value = List<LeagueList>.from(
          response.body["data"]["result"].map((x) => LeagueList.fromJson(x)));

      debugPrint(
          'LeagueList=======================${response.body["data"]["result"]}');
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


  ///==============*********>>>>>>>>selectPlayer<<<<<<<********===
  Rx<int?> selectedIndex = Rx<int?>(null); // Track selected index

  RxList<SelectPlayerList> selectPlayerList = <SelectPlayerList>[].obs;
  var selectedRewardId = ''.obs; // Store the selected reward ID

  selectPlayer({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.selectPlayer(id: id));

    if (response.statusCode == 200) {
      selectPlayerList.value = List<SelectPlayerList>.from(response.body["data"]
      ['result']
          .map((x) => SelectPlayerList.fromJson(x)));
      // selectedRewardId.value = id;
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


  ///==============*********>>>>>>>>GetPlayer<<<<<<<********===
  RxList<PlayerList> playerList = <PlayerList>[].obs;

  getPlayer() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getAllPlayer);

    if (response.statusCode == 200) {
      playerList.value = List<PlayerList>.from(
          response.body["data"]["result"].map((x) => PlayerList.fromJson(x)));

      debugPrint(
          'playerList=======================${response.body["data"]["result"]}');
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

  @override
  void onInit() {
   getLeague();
   getPlayer();
    super.onInit();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/models/league_model/league_model.dart';
import 'package:protippz/app/data/models/team_model/select_team_model.dart';
import 'package:protippz/app/data/models/team_model/team_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/utils/app_constants.dart';

class TeamController extends GetxController{
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


  ///==============*********>>>>>>>>getTeam<<<<<<<********===
  RxList<TeamList> teamList = <TeamList>[].obs;

  getTeam() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getAllTeam);

    if (response.statusCode == 200) {
      teamList.value = List<TeamList>.from(
          response.body["data"]["result"].map((x) => TeamList.fromJson(x)));

      debugPrint(
          'TeamList=======================${response.body["data"]["result"]}');
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

  searchTeam({required String search,required String id}) async {
    setRxRequestStatus(Status.loading);
    selectTeamList.refresh();
    var response = await ApiClient.getData("${ApiUrl.searchTeam}=$search${"&league=$id"}");
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

  @override
  void onInit() {
    getTeam();
    super.onInit();
  }
}
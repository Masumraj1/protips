import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/models/league_model.dart';
import 'package:protippz/app/data/models/rewadz_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/utils/app_constants.dart';

class HomeController extends GetxController{

  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  ///==================================Get Reward======================
  RxList<RewardList> rewardList = <RewardList>[].obs;

  getReward() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getReward);

    if (response.statusCode == 200) {
      rewardList.value = List<RewardList>.from(
          response.body["data"]["result"].map((x) => RewardList.fromJson(x))
      );

      debugPrint('GetReward=======================${response.body["data"]["result"]}');
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


  ///==================================GetLeague======================
  RxList<LeagueList> leagueList = <LeagueList>[].obs;

  getLeague() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.getAllLeague);

    if (response.statusCode == 200) {
      leagueList.value = List<LeagueList>.from(
          response.body["data"]["result"].map((x) => LeagueList.fromJson(x))
      );

      debugPrint('LeagueList=======================${response.body["data"]["result"]}');
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
    getReward();
    getLeague();
    super.onInit();
  }
}
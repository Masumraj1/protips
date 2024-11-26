import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:protippz/app/data/models/league_model.dart';
import 'package:protippz/app/data/models/rewadz_model.dart';
import 'package:protippz/app/data/models/selected_reward_model.dart';
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


  ///<<<<<<<<<<======================================Search Method====================>>>>>>>
  TextEditingController searchController = TextEditingController();

  searchReward({required String search}) async {
    setRxRequestStatus(Status.loading);
    selectRewardList.refresh();
    var response = await ApiClient.getData("${ApiUrl.searchReward}=$search");
    selectRewardList.refresh();
    if (response.statusCode == 200) {
      selectRewardList = RxList<SelectRewardList>.from(
          response.body["data"]['result'].map((x) => SelectRewardList.fromJson(x)));
      setRxRequestStatus(Status.completed);
      selectRewardList.refresh();
    } else {
      ApiChecker.checkApi(response);
    }
  }

///========================selected Reward method===========================
  Rx<int?> selectedIndex = Rx<int?>(null); // Track selected index

  RxList<SelectRewardList> selectRewardList = <SelectRewardList>[].obs;
  selectedReward({required String id}) async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(
        ApiUrl.selectReward(id: id));

    if (response.statusCode == 200) {
      selectRewardList.value = List<SelectRewardList>.from(
          response.body["data"]['result'].map((x) => SelectRewardList.fromJson(x)));
      print('SelectRewardList=========================="${selectRewardList.length}"');
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
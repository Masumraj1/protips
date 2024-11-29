import 'package:get/get.dart';
import 'package:protippz/app/data/models/favorite_model/favorite_player_model.dart';
import 'package:protippz/app/data/models/favorite_model/favorite_team_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/utils/app_constants.dart';

class FavoriteController extends GetxController {
  ///=================home select condition=========
  RxInt selectedIndex = 0.obs;

  ///==================toggle button==============
  var isAllSelected = true.obs;

  void toggleSelection() {
    isAllSelected.value = !isAllSelected.value;
  }

  ///=======================List============
  final List<String> favoriteTabList = ["Playerz", "Teamz"];


  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  ///===========================FavoritePlayer==================================
  RxList<FavoritePlayerList> favoritePlayerList = <FavoritePlayerList>[].obs;
  getFavoritePlayer() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.favoritePlayer);

    if (response.statusCode == 200) {
      favoritePlayerList.value = List<FavoritePlayerList>.from(
          response.body["data"].map((x) => FavoritePlayerList.fromJson(x)));

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

  ///===========================favoriteTeamList==================================
  RxList<FavoriteTeamList> favoriteTeamList = <FavoriteTeamList>[].obs;
  getFavoriteTeam() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.favoriteTeam);

    if (response.statusCode == 200) {
      favoriteTeamList.value = List<FavoriteTeamList>.from(
          response.body["data"].map((x) => FavoriteTeamList.fromJson(x)));

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
    getFavoritePlayer();
    getFavoriteTeam();
    super.onInit();
  }

}

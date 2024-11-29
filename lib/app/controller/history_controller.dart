import 'package:get/get.dart';
import 'package:protippz/app/data/models/history_model/tips_history_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/utils/app_constants.dart';

class HistoryController extends GetxController {
  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  RxList<TipsHistoryList> tipsHistoryList = <TipsHistoryList>[].obs;
  getMyTips() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.myTipHistory);

    if (response.statusCode == 200) {
      tipsHistoryList.value = List<TipsHistoryList>.from(
          response.body["data"]["result"].map((x) => TipsHistoryList.fromJson(x)));

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
    getMyTips();
    super.onInit();
  }
}

import 'package:get/get.dart';
import 'package:protippz/app/data/models/notification_model/notification_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/utils/app_constants.dart';

class NotificationController extends GetxController{

  final rxRequestStatus = Status.loading.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;


  RxList<NotificationList> notificationList = <NotificationList>[].obs;
  notification() async {
    setRxRequestStatus(Status.loading);
    refresh();
    var response = await ApiClient.getData(ApiUrl.notification);

    if (response.statusCode == 200) {
      notificationList.value = List<NotificationList>.from(
          response.body["data"]["result"].map((x) => NotificationList.fromJson(x)));

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
    notification();
    super.onInit();
  }


}
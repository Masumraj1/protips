import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:protippz/app/data/models/notification_model/notification_model.dart';
import 'package:protippz/app/data/services/api_check.dart';
import 'package:protippz/app/data/services/api_client.dart';
import 'package:protippz/app/data/services/app_url.dart';
import 'package:protippz/app/utils/app_constants.dart';

class NotificationController extends GetxController {
  final rxRequestStatus = Status.loading.obs;
  RxList<NotificationList> notificationList = <NotificationList>[].obs;

  // This will track if the user wants to mark all notifications as read or unread
  RxBool isAllRead = false.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  // Method to fetch notifications from the API
  notification() async {
    setRxRequestStatus(Status.loading);
    refresh();

    var response = await ApiClient.getData(ApiUrl.notification);

    if (response.statusCode == 200) {
      notificationList.value = List<NotificationList>.from(
        response.body["data"]["result"].map((x) => NotificationList.fromJson(x)),
      );

      // Load saved "seen" status for notifications
      await _loadNotificationSeenStatus();

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

  // Toggle read/unread for all notifications
  void toggleAllNotificationsReadStatus() {
    isAllRead.value = !isAllRead.value; // Toggle the read status

    for (var notification in notificationList) {
      notification.seen = isAllRead.value;
    }

    // Save the new status in SharedPreferences
    _saveNotificationSeenStatus();

    update(); // Refresh the UI
  }

  // Save the seen status of each notification in SharedPreferences
  Future<void> _saveNotificationSeenStatus() async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < notificationList.length; i++) {
      prefs.setBool('notification_seen_$i', notificationList[i].seen ==true);
    }
  }

  // Load the saved seen status from SharedPreferences
  Future<void> _loadNotificationSeenStatus() async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < notificationList.length; i++) {
      final seenStatus = prefs.getBool('notification_seen_$i');
      if (seenStatus != null) {
        notificationList[i].seen = seenStatus;
      }
    }
  }

  // Mark a single notification as seen/unseen
  void markNotificationAsSeen(int index) async {
    final notification = notificationList[index];

    notification.seen = notification.seen;

    // Save the updated status in SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('notification_seen_$index', notification.seen ==true);

    update(); // Refresh the UI
  }

  @override
  void onInit() {
    notification();
    super.onInit();
  }
}

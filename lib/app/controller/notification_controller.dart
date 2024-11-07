import 'package:get/get.dart';
import 'package:protippz/app/utils/app_constants.dart';

class NotificationController extends GetxController{
  final List<Map<String, dynamic>> historyData = [
    {
      'imageUrl': AppConstants.profileImage,
      'title': 'Tippz send successfully!',
      'date': 'You’ve successfully sent a Tippz to tom',
      'points': 100,
      'time': "12:28 PM",
    },
    {
      'imageUrl': AppConstants.team,
      'title': 'Tippz send successfully!',
      'date': 'You’ve successfully sent a Tippz to tom',
      'points': 150,
      'time': "12:00 PM",
    },
    {
      'imageUrl': AppConstants.profileImage,
      'title': 'Tippz send successfully!',
      'date': 'You’ve successfully sent a Tippz to tom',
      'points': 300,
      'time': "12:28 PM",
    },
    {
      'imageUrl': AppConstants.team,
      'title': 'Tippz send successfully!',
      'date': 'You’ve successfully sent a Tippz to tom',
      'points': 300,
      'time': "12:28 PM",
    },
  ];
}
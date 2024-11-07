import 'package:get/get.dart';
import 'package:protippz/app/utils/app_constants.dart';

class HistoryController extends GetxController {
  final List<Map<String, dynamic>> historyData = [
    {
      'imageUrl': AppConstants.profileImage,
      'title': 'Annette Black',
      'date': '12/08/24',
      'points': 100,
      'amount': 25.0,
    },
    {
      'imageUrl': AppConstants.profileImage,
      'title': 'New York Liberty',
      'date': '11/08/24',
      'points': 150,
      'amount': 15.0,
    },
    {
      'imageUrl': AppConstants.profileImage,
      'title': 'Indiana Fever',
      'date': '08/08/24',
      'points': 300,
      'amount': 10.0,
    },
    {
      'imageUrl': AppConstants.profileImage,
      'title': 'Indiana Fever',
      'date': '08/08/24',
      'points': 300,
      'amount': 10.0,
    },
  ];
}

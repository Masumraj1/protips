import 'package:get/get.dart';
import 'package:protippz/app/core/custom_assets/assets.gen.dart';
import 'package:protippz/app/utils/app_constants.dart';

class  PaymentController extends GetxController{
  final List<Map<String, dynamic>> transactionList = [
    {
      'imageUrl': Assets.icons.money.path,
      'title': 'Deposit Funds',
      'date': '09/08/24',
      'time': "\$200.00",
    },
    {
      'imageUrl': Assets.icons.money.path,
      'title': 'Withdraw Funds',
      'date': '28/08/24',
      'time': "\$200.00",
    },
    {
      'imageUrl': Assets.icons.money.path,
      'title': 'Deposit Funds',
      'date': '09/08/24',
      'time': "\$150.00",
    },
    {
      'imageUrl': Assets.icons.money.path,
      'title': 'Withdraw Funds',
      'date': '28/08/24',
      'time': "\$150.00",
    },
  ];
}
import 'package:get/get.dart';

class  PaymentController extends GetxController{
  final List<Map<String, dynamic>> transactionList = [
    {
      'title': 'Deposit Funds',
      'date': '09/08/24',
      'time': "\$200.00",
    },
    {
      'title': 'Withdraw Funds',
      'date': '28/08/24',
      'time': "\$200.00",
    },
    {
      'title': 'Deposit Funds',
      'date': '09/08/24',
      'time': "\$150.00",
    },
    {
      'title': 'Withdraw Funds',
      'date': '28/08/24',
      'time': "\$150.00",
    },
  ];
}
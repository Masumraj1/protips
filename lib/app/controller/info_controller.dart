import 'package:get/get.dart';

class InfoController extends GetxController{
  // Sample data for FAQ
  final List<Map<String, String>> faqData = [
    {
      "question": "How much does delivery cost?",
      "answer": "Delivery charges vary depending on the location and the amount of fuel ordered. You will see the total cost, including delivery fees, before confirming your order."
    },
    {
      "question": "How do I pay for fuel delivery?",
      "answer": "You can pay for fuel delivery using a credit card, debit card, or mobile payment options."
    },
    {
      "question": "Is there a minimum or maximum fuel order?",
      "answer": "Yes, minimum and maximum order amounts apply. Please check our ordering guidelines for specific limits."
    },
    {
      "question": "How do I know when my fuel will arrive?",
      "answer": "Once your order is placed, you'll receive an estimated delivery time."
    },
    {
      "question": "How do I pay for fuel delivery?",
      "answer": "You can pay for fuel delivery through various payment options."
    },
  ];
}
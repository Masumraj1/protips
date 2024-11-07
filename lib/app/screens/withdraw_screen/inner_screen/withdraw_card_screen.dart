import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';

class WithdrawCardScreen extends StatelessWidget {
  const WithdrawCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarContent: "Credite/Debit Card",
        iconData: Icons.arrow_back,
      ),
    );
  }
}

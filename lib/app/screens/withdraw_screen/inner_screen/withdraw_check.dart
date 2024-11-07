import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';

class WithdrawCheck extends StatelessWidget {
  const WithdrawCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarContent: "Check",
        iconData: Icons.arrow_back,
      ),
    );
  }
}

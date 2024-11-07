import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';

class WithdrawAch extends StatelessWidget {
  const WithdrawAch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarContent: "Ach",
        iconData: Icons.arrow_back,
      ),
    );
  }
}

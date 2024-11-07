import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';
import 'package:protippz/app/utils/app_strings.dart';

class DepositeScreen extends StatelessWidget {
  const DepositeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarContent: AppStrings.depositFunds,
        iconData: Icons.arrow_back,
      ),
    );
  }
}

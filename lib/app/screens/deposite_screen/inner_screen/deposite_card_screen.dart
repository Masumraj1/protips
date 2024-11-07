import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';

class DepositeCardScreen extends StatelessWidget {
  const DepositeCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarContent: "Credit/Debit Card",iconData: Icons.arrow_back,),
    );
  }
}

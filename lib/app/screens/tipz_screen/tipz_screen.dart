import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/custom_appbar/custom_appbar.dart';

class TipzScreen extends StatelessWidget {
  const TipzScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        appBarContent: "Tippz",
        iconData: Icons.arrow_back,
      ),
    );
  }
}

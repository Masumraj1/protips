import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';
import 'package:protippz/app/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg500,
      bottomNavigationBar: const NavBar(currentIndex: 0,),
      appBar: AppBar(
        backgroundColor: AppColors.white50,
        title: const Text('22'),),
    );
  }
}

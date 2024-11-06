import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 4,),

      appBar: AppBar(title: Text('Profile'),),
    );;
  }
}

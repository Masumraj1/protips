import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 1,),

      appBar: AppBar(title: Text('noti'),),
    );
  }
}

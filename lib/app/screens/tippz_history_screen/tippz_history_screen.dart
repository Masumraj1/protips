import 'package:flutter/material.dart';
import 'package:protippz/app/global/widgets/nav_bar/nav_bar.dart';

class TippzHistoryScreen extends StatelessWidget {
  const TippzHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NavBar(currentIndex: 3,),

      appBar: AppBar(title: Text('22'),),
    );
  }
}

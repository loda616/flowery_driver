import 'package:flutter/material.dart';

import '../../profile/view/my_profile_screen.dart';
import 'widgets/bottom_navigation_bar.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  int currentIndex = 0;
  List<Widget> _screens = [];

  @override
  initState() {
    super.initState();
    _screens = [
      Scaffold(
        body: Text('Home'),
      ),
      Scaffold(
        body: Text('Home'),
      ),
      MyProfileScreen(),
    ];
  }

  changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: changeIndex,
      ),
    );
  }
}

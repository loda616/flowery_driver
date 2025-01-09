import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/di.dart';
import '../../home_screen/view/home_screen.dart';
import '../../profile/view/my_profile_screen.dart';
import '../../profile/view_model/profile_view_model.dart';
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
      HomeScreen(),
      Scaffold(
        body: Text('Home'),
      ),
      BlocProvider(
        create: (context) => getIt<ProfileCubit>(),
        child: MyProfileScreen(
          onBackPressed: () {
            setState(() {
              currentIndex = 0;
            });
          },
        ),
      ),
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

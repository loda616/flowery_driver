import 'package:flowery_driver/core/styles/colors/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../widget/home_app_bar.dart';
import '../widget/home_order_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          title: HomeAppBar(),
        ),
        body:ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return HomeOrderCard();
              }),
        );
  }
}

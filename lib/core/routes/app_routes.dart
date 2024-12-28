import 'package:flutter/material.dart';

import '../../presentation/onboarding/presentation/onboarding_screen.dart';
import '../../presentation/profile/view/my_profile_screen.dart';
import 'page_route_name.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case PageRouteName.onBoarding:
        return _handleMaterialPageRoute(widget: OnboardingScreen());
      case PageRouteName.myProfile:
        return _handleMaterialPageRoute(widget: MyProfileScreen());
      default:
        return _handleMaterialPageRoute(widget: const Scaffold());
    }
  }

  static MaterialPageRoute<dynamic> _handleMaterialPageRoute(
      {required Widget widget}) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}

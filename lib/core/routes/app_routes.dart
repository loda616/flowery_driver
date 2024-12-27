import 'package:flowery_driver/core/routes/page_route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/profile/view/my_profile_screen.dart';


class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
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

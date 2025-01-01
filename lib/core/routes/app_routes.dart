import 'package:flowery_driver/core/routes/page_route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/profile/view/my_profile_screen.dart';
import '../../presentation/profile/view_model/profile_view_model.dart';
import '../di/di.dart';


class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {

      case PageRouteName.myProfile:
        return _handleMaterialPageRoute(
          widget: BlocProvider(
            create: (context) => getIt.get<ProfileCubit>(),
            child: MyProfileScreen(),
          ),
        );

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

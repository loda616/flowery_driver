import 'package:flowery_driver/presentation/auth/forgot_password/view/widgets/forgot_password_widget/forget_password_screen.dart';
import 'package:flowery_driver/presentation/auth/forgot_password/view_model/forget_passwoed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/auth/apply/view/apply_screen.dart';
import '../../presentation/auth/apply/view_model/apply_view_model.dart';
import '../../presentation/auth/forgot_password/view/widgets/email_verification_widget/email_verification.dart';
import '../../presentation/auth/login/view/login_screen.dart';
import '../../presentation/auth/login/view_model/login_cubit.dart';
import '../../presentation/onboarding/presentation/onboarding_screen.dart';
import '../../presentation/profile/view/my_profile_screen.dart';
import '../di/di.dart';
import 'page_route_name.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case PageRouteName.onBoarding:
        return _handleMaterialPageRoute(widget: OnboardingScreen());

      case PageRouteName.login:
        return _handleMaterialPageRoute(
          widget: BlocProvider<LoginViewModel>(
            create: (context) => getIt<LoginViewModel>(),
            child: LogInScreen(),
          ),
        );

      case PageRouteName.apply:
        return _handleMaterialPageRoute(
          widget: BlocProvider<ApplyViewModel>(
            create: (context) => getIt<ApplyViewModel>(),
            child: ApplyScreen(),
          ),
        );

      case PageRouteName.forgetPassword:
        return _handleMaterialPageRoute(
          widget: BlocProvider<ForgetPasswordCubit>(
            create: (context) => getIt<ForgetPasswordCubit>(),
            child: ForgetPassword(),
          ),
        );

      case PageRouteName.verifyOtp:
        final cubit = setting.arguments as ForgetPasswordCubit;
        return _handleMaterialPageRoute(
          widget: EmailVerification(
            viewModel: cubit,
          ),
        );

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

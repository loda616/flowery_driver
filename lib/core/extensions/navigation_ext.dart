import 'package:flutter/material.dart';

extension NavigatorHelper on BuildContext {
  Future<void> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<void> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<void> pushNamedAndRemoveUntilNamed(
      String newRouteName, RoutePredicate predicate,
      {Object? arguments}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(newRouteName, predicate, arguments: arguments);
  }

  void pop() => Navigator.of(this).pop();
}

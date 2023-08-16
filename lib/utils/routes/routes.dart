import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_task/utils/routes/routes_name.dart';

import '../../view/home_screen.dart';
import '../../view/login_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined here'),
            ),
          );
        });
    }
  }
}

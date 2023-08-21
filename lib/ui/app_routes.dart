import 'package:flutter/material.dart';
import 'package:flutter_defualt_project/app/app.dart';
import 'package:flutter_defualt_project/ui/auth/auth_screen.dart';
import 'package:flutter_defualt_project/ui/home/home_screen.dart';
import 'package:flutter_defualt_project/ui/home2/home_screen_2.dart';
import 'package:flutter_defualt_project/ui/splash/splash_screen.dart';
import 'package:flutter_defualt_project/ui/task_screens/math_screen.dart';
import 'package:flutter_defualt_project/ui/task_screens/tab_box_task/tab_box_screen.dart';

class RouteNames {
  static const String homeScreen = "/home_screen";
  static const String authScreen = "/auth_screen";
  static const String splashScreen = "/";
  static const String appScreen = "/app_screen";
  static const String mathScreen = "/math_screen";
  static const String tabBox = "/tab_box";
  static const String homeScreen2 = "/home2";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.appScreen:
        return MaterialPageRoute(
          builder: (context) => const App(),
        );
      case RouteNames.homeScreen2:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen2(),
        );
      case RouteNames.tabBox:
        return MaterialPageRoute(
          builder: (context) => const TabBoxScreen(),
        );
      case RouteNames.mathScreen:
        return MaterialPageRoute(
          builder: (context) => const MathScreen(),
        );
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RouteNames.authScreen:
        return MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        );
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route not found!"),
            ),
          ),
        );
    }
  }
}

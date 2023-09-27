import 'package:estoregpt/features/admin/screens/add_product_screen.dart';
import 'package:estoregpt/features/admin/screens/login_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> appRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case DashboardScreen.route:
    //   return MaterialPageRoute(
    //     builder: (context) {
    //       return DashboardScreen();
    //     },
    //     settings: routeSettings,
    //   );
    // case SearchScreen.route:
    //   return MaterialPageRoute(
    //     builder: (context) {
    //       return SearchScreen();
    //     },
    //     settings: routeSettings,
    //   );
    case LoginScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
        settings: routeSettings,
      );
    case AddProductScreen.route:
      return MaterialPageRoute(
        builder: (context) {
          return const AddProductScreen();
        },
        settings: routeSettings,
      );
    default:
      return MaterialPageRoute(
        builder: (context) {
          return const Scaffold(
            body: Center(
                child: Text(
                    "Sorry, it seems the page you are looking for is missing")),
          );
        },
      );
  }
}

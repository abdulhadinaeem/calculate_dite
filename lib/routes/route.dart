import 'package:calculate_dite/core/constants/route_names.dart';
import 'package:calculate_dite/screen/add_meal_screen.dart';
import 'package:calculate_dite/screen/create_account.dart';
import 'package:calculate_dite/screen/show_user_screen.dart';
import 'package:calculate_dite/screen/user_dite_details_sceen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> namedRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.createAccountScreen:
        return MaterialPageRoute(
          builder: (_) => CreateAccount(),
        );
      case RouteNames.showUserScreen:
        return MaterialPageRoute(
          builder: (_) => const ShowUserScreen(),
        );
      case RouteNames.userDetailsScreen:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => UserDetailsScreen(map: map),
        );
      case RouteNames.addMealScreen:
        Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => AddMealScreen(
            map: map,
          ),
        );
    }
    return MaterialPageRoute(builder: (context) {
      return const Center(
        child: Text("No Route"),
      );
    });
  }
}

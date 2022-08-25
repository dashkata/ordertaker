import 'package:flutter/material.dart';
import 'package:order_taker/views/auth_screen/auth_checker_screen.dart';
import 'package:order_taker/views/login_screen/login.dart';
import 'package:order_taker/views/user_screens/bill_screen/bill.dart';
import 'package:order_taker/views/user_screens/confirm_reservation_screen/confirm_reservation.dart';
import 'package:order_taker/views/user_screens/menu_screen/menu.dart';
import 'package:order_taker/views/user_screens/profile_screen/profile.dart';
import 'package:order_taker/views/user_screens/register_screen/register.dart';
import 'package:order_taker/views/user_screens/reservations_screen/reservations.dart';
import 'package:order_taker/views/user_screens/restaurant_info_screen/restaurant_info.dart';
import 'package:order_taker/views/user_screens/restaurant_screen/restaurants.dart';

class Routes {
  static const String login = 'login';
  static const String register = 'register';
  static const String auth = 'auth';
  static const String profile = 'profile';
  static const String userRestaurants = 'user_restaurants';
  static const String userReservations = 'user_reservations';
  static const String userRestaurantInfo = 'user_restaurant_info';
  static const String userMenu = 'user_menu';
  static const String userConfirmReserveration = 'user_confirm_reservation';
  static const String userBill = 'bill';
}

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case Routes.auth:
        return MaterialPageRoute(
          builder: (_) => const AuthChecker(),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case Routes.userRestaurants:
        return MaterialPageRoute(
          builder: (_) => const RestaurantScreen(),
        );
      case Routes.userReservations:
        return MaterialPageRoute(
          builder: (_) => const ReservationScreen(),
        );
      case Routes.userRestaurantInfo:
        return MaterialPageRoute(
          builder: (_) => const RestaurantInfoScreen(),
          settings: settings,
        );
      case Routes.userMenu:
        return MaterialPageRoute(
          builder: (_) => const MenuScreen(),
        );
      case Routes.userConfirmReserveration:
        return MaterialPageRoute(
          builder: (_) => const ConfirmReservationScreen(),
        );
      case Routes.userBill:
        return MaterialPageRoute(
          builder: (_) => const BillScreen(),
        );

      default:
        throw const FormatException('Route not found! Check routes again!');
    }
  }
}
